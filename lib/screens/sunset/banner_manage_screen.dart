import 'dart:io';
import 'package:flutter/material.dart';
import '../../services/image/image_service.dart';

class BannerManageScreen extends StatefulWidget {
  const BannerManageScreen({super.key});

  @override
  State<BannerManageScreen> createState() => _BannerManageScreenState();
}

class _BannerManageScreenState extends State<BannerManageScreen> {
  final _imageService = ImageService();
  List<Map<String, dynamic>> banners = [
    {'id': '1', 'title': '신규 회원 환영 배너', 'order': 1, 'isActive': true, 'clicks': 234},
    {'id': '2', 'title': '이벤트 배너', 'order': 2, 'isActive': true, 'clicks': 456},
    {'id': '3', 'title': '프로모션 배너', 'order': 3, 'isActive': false, 'clicks': 123},
  ];

  void _showCreateBannerDialog() {
    final titleController = TextEditingController();
    final linkController = TextEditingController();
    File? bannerImage;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('배너 생성'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () async {
                    final image = await _imageService.pickImage();
                    if (image != null) setDialogState(() => bannerImage = image);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 120,
                    decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8), image: bannerImage != null ? DecorationImage(image: FileImage(bannerImage!), fit: BoxFit.cover) : null),
                    child: bannerImage == null ? const Center(child: Icon(Icons.add_photo_alternate, size: 48)) : null,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(controller: titleController, decoration: const InputDecoration(labelText: '배너 제목', border: OutlineInputBorder())),
                const SizedBox(height: 12),
                TextField(controller: linkController, decoration: const InputDecoration(labelText: '링크 URL (선택)', border: OutlineInputBorder())),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('취소')),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('배너가 생성되었습니다')));
              },
              child: const Text('생성'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('배너/광고 관리')),
      body: ReorderableListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: banners.length,
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) newIndex--;
            final item = banners.removeAt(oldIndex);
            banners.insert(newIndex, item);
          });
        },
        itemBuilder: (context, index) {
          final banner = banners[index];
          return Card(
            key: ValueKey(banner['id']),
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.drag_handle),
                  const SizedBox(width: 8),
                  Text('${banner['order']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              title: Text(banner['title'] as String),
              subtitle: Text('클릭: ${banner['clicks']}회'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Switch(
                    value: banner['isActive'] as bool,
                    onChanged: (value) => setState(() => banner['isActive'] = value),
                  ),
                  PopupMenuButton(
                    itemBuilder: (context) => [
                      const PopupMenuItem(value: 'edit', child: Text('수정')),
                      const PopupMenuItem(value: 'stats', child: Text('통계 보기')),
                      const PopupMenuItem(value: 'delete', child: Text('삭제')),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: _showCreateBannerDialog, child: const Icon(Icons.add)),
    );
  }
}
