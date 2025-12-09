import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/community/community_provider.dart';
import '../../widgets/community/post_card.dart';
import '../../utils/date_formatter.dart';

class PostDetailScreen extends StatefulWidget {
  final String postId;

  const PostDetailScreen({
    super.key,
    required this.postId,
  });

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  final _commentController = TextEditingController();
  bool _isLiked = false;

  @override
  void initState() {
    super.initState();
    // TODO: 실제 게시글 로드
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('게시글 상세'),
      ),
      body: Consumer<CommunityProvider>(
        builder: (context, provider, child) {
          // TODO: 실제 게시글 데이터 로드
          final post = provider.posts.firstWhere(
            (p) => p.id == widget.postId,
            orElse: () => provider.posts.isNotEmpty
                ? provider.posts.first
                : throw Exception('Post not found'),
          );

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 게시글
                      PostCard(
                        userName: '사용자${post.userId}',
                        content: post.content,
                        images: post.images,
                        likeCount: post.likeCount + (_isLiked ? 1 : 0),
                        commentCount: post.commentCount,
                        createdAt: post.createdAt,
                        onTap: null,
                      ),
                      const SizedBox(height: 24),
                      const Divider(),
                      const SizedBox(height: 16),
                      // 댓글 섹션
                      const Text(
                        '댓글',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // TODO: 실제 댓글 목록 표시
                      const Text('댓글이 없습니다'),
                    ],
                  ),
                ),
              ),
              // 댓글 입력
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, -3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _commentController,
                        decoration: const InputDecoration(
                          hintText: '댓글을 입력하세요...',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () {
                        if (_commentController.text.trim().isNotEmpty) {
                          // TODO: 댓글 작성 로직
                          _commentController.clear();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('댓글이 작성되었습니다')),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
