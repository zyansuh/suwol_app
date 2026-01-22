import 'dart:io';
import 'package:flutter/material.dart';
import '../../services/image/image_service.dart';
import '../../utils/date_formatter.dart';

class EventManageScreen extends StatefulWidget {
  const EventManageScreen({super.key});

  @override
  State<EventManageScreen> createState() => _EventManageScreenState();
}

class _EventManageScreenState extends State<EventManageScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _imageService = ImageService();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showCreateEventDialog() {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    File? eventImage;
    String eventType = 'platform';
    DateTime startDate = DateTime.now();
    DateTime endDate = DateTime.now().add(const Duration(days: 7));

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('이벤트 생성'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () async {
                    final image = await _imageService.pickImage();
                    if (image != null) setDialogState(() => eventImage = image);
                  },
                  child: Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                      image: eventImage != null ? DecorationImage(image: FileImage(eventImage!), fit: BoxFit.cover) : null,
                    ),
                    child: eventImage == null ? const Center(child: Icon(Icons.add_photo_alternate, size: 48)) : null,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(controller: titleController, decoration: const InputDecoration(labelText: '제목', border: OutlineInputBorder())),
                const SizedBox(height: 12),
                TextField(controller: descriptionController, decoration: const InputDecoration(labelText: '설명', border: OutlineInputBorder()), maxLines: 3),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: eventType,
                  decoration: const InputDecoration(labelText: '이벤트 유형', border: OutlineInputBorder()),
                  items: const [
                    DropdownMenuItem(value: 'platform', child: Text('전체 플랫폼')),
                    DropdownMenuItem(value: 'cafe', child: Text('특정 카페 그룹')),
                  ],
                  onChanged: (value) => setDialogState(() => eventType = value!),
                ),
                const SizedBox(height: 12),
                ListTile(
                  title: const Text('시작일'),
                  subtitle: Text(DateFormatter.formatDate(startDate)),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final picked = await showDatePicker(context: context, initialDate: startDate, firstDate: DateTime.now(), lastDate: DateTime.now().add(const Duration(days: 365)));
                    if (picked != null) setDialogState(() => startDate = picked);
                  },
                ),
                ListTile(
                  title: const Text('종료일'),
                  subtitle: Text(DateFormatter.formatDate(endDate)),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final picked = await showDatePicker(context: context, initialDate: endDate, firstDate: startDate, lastDate: DateTime.now().add(const Duration(days: 365)));
                    if (picked != null) setDialogState(() => endDate = picked);
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('취소')),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('이벤트가 생성되었습니다')));
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
      appBar: AppBar(
        title: const Text('이벤트/프로모션 관리'),
        bottom: TabBar(controller: _tabController, tabs: const [Tab(text: '진행 중'), Tab(text: '종료')]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_ActiveEventList(), _EndedEventList()],
      ),
      floatingActionButton: FloatingActionButton(onPressed: _showCreateEventDialog, child: const Icon(Icons.add)),
    );
  }
}

class _ActiveEventList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Container(width: 60, height: 60, decoration: BoxDecoration(color: Colors.blue[100], borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.event, size: 30)),
            title: const Text('신규 회원 환영 이벤트'),
            subtitle: const Text('전체 플랫폼 | 2024-01-20 ~ 2024-02-20'),
            trailing: PopupMenuButton(
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'edit', child: Text('수정')),
                const PopupMenuItem(value: 'end', child: Text('종료')),
                const PopupMenuItem(value: 'delete', child: Text('삭제')),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _EndedEventList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: Container(width: 60, height: 60, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.event_busy, size: 30)),
            title: const Text('크리스마스 특별 이벤트'),
            subtitle: const Text('종료일: 2023-12-31'),
            trailing: const Icon(Icons.info_outline),
          ),
        );
      },
    );
  }
}
