import 'package:flutter/material.dart';

class SystemLogScreen extends StatefulWidget {
  const SystemLogScreen({super.key});

  @override
  State<SystemLogScreen> createState() => _SystemLogScreenState();
}

class _SystemLogScreenState extends State<SystemLogScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('시스템 로그'),
        bottom: TabBar(controller: _tabController, tabs: const [Tab(text: '오류 로그'), Tab(text: '활동 로그'), Tab(text: 'API 로그')]),
        actions: [IconButton(icon: const Icon(Icons.refresh), onPressed: () {})],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_ErrorLogList(), _ActivityLogList(), _ApiLogList()],
      ),
    );
  }
}

class _ErrorLogList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 20,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ExpansionTile(
            leading: const Icon(Icons.error, color: Colors.red),
            title: const Text('NullPointerException'),
            subtitle: const Text('발생 시간: 2024-01-22 14:35:20'),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('에러 메시지:', style: TextStyle(fontWeight: FontWeight.bold)),
                    const Text('User object is null at line 45'),
                    const SizedBox(height: 8),
                    const Text('Stack Trace:', style: TextStyle(fontWeight: FontWeight.bold)),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(4)),
                      child: const Text(
                        'at UserProvider.loadUser()\nat AuthScreen.build()\n...',
                        style: TextStyle(fontSize: 12, fontFamily: 'monospace'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ActivityLogList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 30,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            leading: const Icon(Icons.person, size: 20),
            title: const Text('사용자123'),
            subtitle: const Text('로그인 | 2024-01-22 14:30:15'),
            trailing: const Icon(Icons.chevron_right, size: 16),
            dense: true,
          ),
        );
      },
    );
  }
}

class _ApiLogList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 50,
      itemBuilder: (context, index) {
        final isError = index % 10 == 0;
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          color: isError ? Colors.red[50] : null,
          child: ListTile(
            leading: Text(isError ? '500' : '200', style: TextStyle(fontWeight: FontWeight.bold, color: isError ? Colors.red : Colors.green)),
            title: const Text('GET /api/users/123'),
            subtitle: const Text('응답 시간: 234ms | 2024-01-22 14:30:15'),
            trailing: const Icon(Icons.chevron_right, size: 16),
            dense: true,
          ),
        );
      },
    );
  }
}
