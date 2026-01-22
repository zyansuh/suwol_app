import 'package:flutter/material.dart';
import '../../utils/date_formatter.dart';

class NoticeManageScreen extends StatefulWidget {
  const NoticeManageScreen({super.key});

  @override
  State<NoticeManageScreen> createState() => _NoticeManageScreenState();
}

class _NoticeManageScreenState extends State<NoticeManageScreen> {
  void _showCreateNoticeDialog() {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    bool isPinned = false;
    DateTime? startDate;
    DateTime? endDate;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('공지사항 작성'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: '제목', border: OutlineInputBorder()),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: contentController,
                  decoration: const InputDecoration(labelText: '내용', border: OutlineInputBorder()),
                  maxLines: 5,
                ),
                const SizedBox(height: 12),
                CheckboxListTile(
                  title: const Text('상단 고정'),
                  value: isPinned,
                  onChanged: (value) => setDialogState(() => isPinned = value ?? false),
                ),
                ListTile(
                  title: const Text('게시 시작일'),
                  subtitle: Text(startDate != null ? DateFormatter.formatDate(startDate!) : '미설정'),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (picked != null) setDialogState(() => startDate = picked);
                  },
                ),
                ListTile(
                  title: const Text('게시 종료일'),
                  subtitle: Text(endDate != null ? DateFormatter.formatDate(endDate!) : '미설정'),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: startDate ?? DateTime.now(),
                      firstDate: startDate ?? DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
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
                if (titleController.text.isEmpty || contentController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('제목과 내용을 입력해주세요')));
                  return;
                }
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('공지사항이 작성되었습니다')));
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
      appBar: AppBar(title: const Text('공지사항 관리')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 10,
        itemBuilder: (context, index) {
          final isPinned = index < 2;
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            color: isPinned ? Colors.amber[50] : null,
            child: ListTile(
              leading: isPinned ? const Icon(Icons.push_pin, color: Colors.amber) : const Icon(Icons.article),
              title: Text(isPinned ? '[중요] 공지사항 제목' : '공지사항 제목'),
              subtitle: const Text('게시일: 2024-01-20 | 조회수: 123'),
              trailing: PopupMenuButton(
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'edit', child: Text('수정')),
                  PopupMenuItem(value: 'pin', child: Text(isPinned ? '고정 해제' : '상단 고정')),
                  const PopupMenuItem(value: 'delete', child: Text('삭제')),
                ],
                onSelected: (value) {},
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: _showCreateNoticeDialog, child: const Icon(Icons.add)),
    );
  }
}
