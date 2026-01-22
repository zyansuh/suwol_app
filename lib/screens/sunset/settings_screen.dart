import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('시스템 설정'),
      ),
      body: ListView(
        children: [
          // 앱 설정
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              '앱 설정',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('푸시 알림 설정'),
            trailing: Switch(
              value: true,
              onChanged: (value) {
                // TODO: 알림 설정 변경
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.email),
            title: const Text('이메일 알림 설정'),
            trailing: Switch(
              value: false,
              onChanged: (value) {
                // TODO: 이메일 알림 설정 변경
              },
            ),
          ),
          const Divider(),
          // 포인트 설정
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              '포인트 설정',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.stars),
            title: const Text('기본 적립률'),
            subtitle: const Text('1원당 1포인트'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: 적립률 설정 화면
            },
          ),
          ListTile(
            leading: const Icon(Icons.percent),
            title: const Text('최소 사용 포인트'),
            subtitle: const Text('100P'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: 최소 포인트 설정 화면
            },
          ),
          const Divider(),
          // 등급 설정
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              '등급 설정',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.workspace_premium),
            title: const Text('등급 기준 포인트'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: 등급 기준 설정 화면
            },
          ),
          const Divider(),
          // 기타
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              '기타',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.backup),
            title: const Text('데이터 백업'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: 백업 화면
            },
          ),
          ListTile(
            leading: const Icon(Icons.restore),
            title: const Text('데이터 복원'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: 복원 화면
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('앱 정보'),
            subtitle: const Text('버전 1.0.0'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: 앱 정보 화면
            },
          ),
        ],
      ),
    );
  }
}
