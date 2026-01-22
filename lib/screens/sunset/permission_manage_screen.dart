import 'package:flutter/material.dart';

class PermissionManageScreen extends StatelessWidget {
  const PermissionManageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('권한 관리')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Admin 권한 관리', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.person)),
                    title: const Text('관리자1'),
                    subtitle: const Text('admin1@cafelink.com'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Chip(label: const Text('최고 관리자'), backgroundColor: Colors.red[100]),
                        PopupMenuButton(
                          itemBuilder: (context) => [
                            const PopupMenuItem(value: 'edit', child: Text('권한 수정')),
                            const PopupMenuItem(value: 'log', child: Text('접근 로그')),
                            const PopupMenuItem(value: 'revoke', child: Text('권한 회수')),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.person)),
                    title: const Text('관리자2'),
                    subtitle: const Text('admin2@cafelink.com'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Chip(label: const Text('일반 관리자'), backgroundColor: Colors.blue[100]),
                        PopupMenuButton(
                          itemBuilder: (context) => [
                            const PopupMenuItem(value: 'edit', child: Text('권한 수정')),
                            const PopupMenuItem(value: 'log', child: Text('접근 로그')),
                            const PopupMenuItem(value: 'revoke', child: Text('권한 회수')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('역할별 권한 설정', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Card(
              child: Column(
                children: [
                  _PermissionTile(role: '최고 관리자', permissions: ['모든 권한']),
                  const Divider(),
                  _PermissionTile(role: '일반 관리자', permissions: ['사용자 조회', '통계 조회', '게시글 관리']),
                  const Divider(),
                  _PermissionTile(role: 'CS 관리자', permissions: ['신고 관리', '문의 답변']),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('최근 접근 로그', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Card(
              child: Column(
                children: List.generate(
                  5,
                  (index) => ListTile(
                    leading: const Icon(Icons.login, size: 20),
                    title: const Text('관리자1'),
                    subtitle: const Text('사용자 관리 접근 | 2024-01-22 14:30'),
                    trailing: const Icon(Icons.chevron_right),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.person_add),
      ),
    );
  }
}

class _PermissionTile extends StatelessWidget {
  final String role;
  final List<String> permissions;
  const _PermissionTile({required this.role, required this.permissions});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(role, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Wrap(
        spacing: 4,
        children: permissions.map((p) => Chip(label: Text(p, style: const TextStyle(fontSize: 10)))).toList(),
      ),
      trailing: const Icon(Icons.edit),
      onTap: () {},
    );
  }
}
