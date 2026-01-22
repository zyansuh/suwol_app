import 'package:flutter/material.dart';

class NotificationManageScreen extends StatefulWidget {
  const NotificationManageScreen({super.key});

  @override
  State<NotificationManageScreen> createState() => _NotificationManageScreenState();
}

class _NotificationManageScreenState extends State<NotificationManageScreen> {
  void _showSendNotificationDialog() {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    String targetType = 'all';

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('푸시 알림 발송'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: titleController, decoration: const InputDecoration(labelText: '제목', border: OutlineInputBorder())),
                const SizedBox(height: 12),
                TextField(controller: contentController, decoration: const InputDecoration(labelText: '내용', border: OutlineInputBorder()), maxLines: 3),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: targetType,
                  decoration: const InputDecoration(labelText: '발송 대상', border: OutlineInputBorder()),
                  items: const [
                    DropdownMenuItem(value: 'all', child: Text('전체 사용자')),
                    DropdownMenuItem(value: 'customer', child: Text('일반 고객')),
                    DropdownMenuItem(value: 'owner', child: Text('사업자')),
                    DropdownMenuItem(value: 'custom', child: Text('특정 그룹')),
                  ],
                  onChanged: (value) => setDialogState(() => targetType = value!),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('취소')),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('알림이 발송되었습니다')));
              },
              child: const Text('발송'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('푸시 알림 관리')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 15,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const Icon(Icons.notifications, color: Colors.blue),
              title: const Text('알림 제목'),
              subtitle: const Text('발송 대상: 전체 사용자 | 발송일: 2024-01-20 | 수신: 1,234명'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: _showSendNotificationDialog, child: const Icon(Icons.add)),
    );
  }
}
