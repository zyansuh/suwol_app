import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/community/community_provider.dart';
import '../../widgets/community/post_card.dart';
import '../../services/image/image_service.dart';
import '../../routes/app_router.dart';

class CommunityFeedScreen extends StatefulWidget {
  const CommunityFeedScreen({super.key});

  @override
  State<CommunityFeedScreen> createState() => _CommunityFeedScreenState();
}

class _CommunityFeedScreenState extends State<CommunityFeedScreen> {
  final _imageService = ImageService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider =
          Provider.of<CommunityProvider>(context, listen: false);
      provider.loadPosts();
    });
  }

  void _showCreatePostDialog() {
    final contentController = TextEditingController();
    List<File> selectedImages = [];

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('게시글 작성'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: contentController,
                  decoration: const InputDecoration(
                    hintText: '무엇을 공유하고 싶나요?',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                ),
                const SizedBox(height: 16),
                if (selectedImages.isNotEmpty)
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: selectedImages.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              margin: const EdgeInsets.only(right: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: FileImage(selectedImages[index]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: IconButton(
                                icon: const Icon(Icons.close, size: 20),
                                onPressed: () {
                                  setDialogState(() {
                                    selectedImages.removeAt(index);
                                  });
                                },
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                TextButton.icon(
                  icon: const Icon(Icons.image),
                  label: const Text('이미지 추가'),
                  onPressed: () async {
                    final images =
                        await _imageService.pickMultipleImages();
                    setDialogState(() {
                      selectedImages.addAll(images);
                    });
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('취소'),
            ),
            TextButton(
              onPressed: () async {
                if (contentController.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('내용을 입력해주세요'),
                    ),
                  );
                  return;
                }

                final provider =
                    Provider.of<CommunityProvider>(context, listen: false);
                final imagePaths = selectedImages
                    .map((file) => file.path)
                    .toList();

                await provider.createPost(
                  userId: 'user1', // TODO: 실제 사용자 ID
                  content: contentController.text,
                  images: imagePaths,
                );

                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('게시글이 작성되었습니다')),
                  );
                }
              },
              child: const Text('작성'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('커뮤니티'),
      ),
      body: Consumer<CommunityProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.posts.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.posts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.forum, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text('아직 게시글이 없습니다'),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: _showCreatePostDialog,
                    child: const Text('첫 게시글 작성하기'),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              await provider.loadPosts();
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: provider.posts.length,
              itemBuilder: (context, index) {
                final post = provider.posts[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: PostCard(
                    userName: '사용자${post.userId}', // TODO: 실제 사용자 이름
                    content: post.content,
                    images: post.images,
                    likeCount: post.likeCount,
                    commentCount: post.commentCount,
                    createdAt: post.createdAt,
                    onTap: () {
                      AppRouter.router.push('/community/${post.id}');
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreatePostDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}
