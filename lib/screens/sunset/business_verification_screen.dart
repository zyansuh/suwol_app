import 'package:flutter/material.dart';

class BusinessVerificationScreen extends StatefulWidget {
  const BusinessVerificationScreen({super.key});

  @override
  State<BusinessVerificationScreen> createState() => _BusinessVerificationScreenState();
}

class _BusinessVerificationScreenState extends State<BusinessVerificationScreen> with SingleTickerProviderStateMixin {
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
        title: const Text('사업자 인증 관리'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '인증 대기'),
            Tab(text: '승인 완료'),
            Tab(text: '거부'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _PendingList(),
          _ApprovedList(),
          _RejectedList(),
        ],
      ),
    );
  }
}

class _PendingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text('카페 이름', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    Chip(label: const Text('인증 대기'), backgroundColor: Colors.orange[100]),
                  ],
                ),
                const SizedBox(height: 8),
                _InfoRow(icon: Icons.person, label: '사장님', value: '홍길동'),
                _InfoRow(icon: Icons.business, label: '사업자 등록번호', value: '123-45-67890'),
                _InfoRow(icon: Icons.phone, label: '연락처', value: '010-1234-5678'),
                _InfoRow(icon: Icons.location_on, label: '주소', value: '서울시 강남구...'),
                const SizedBox(height: 12),
                const Text('제출 서류:', style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: [
                    Chip(
                      avatar: const Icon(Icons.insert_drive_file, size: 18),
                      label: const Text('사업자등록증.pdf'),
                      onDeleted: () {},
                      deleteIcon: const Icon(Icons.download, size: 18),
                    ),
                    Chip(
                      avatar: const Icon(Icons.insert_drive_file, size: 18),
                      label: const Text('통장사본.pdf'),
                      onDeleted: () {},
                      deleteIcon: const Icon(Icons.download, size: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => _showRejectDialog(context),
                      child: const Text('거부'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () => _showApproveDialog(context),
                      child: const Text('승인'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showApproveDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('사업자 승인'),
        content: const Text('사업자 인증을 승인하시겠습니까?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('취소')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('사업자 인증이 승인되었습니다')));
            },
            child: const Text('승인'),
          ),
        ],
      ),
    );
  }

  void _showRejectDialog(BuildContext context) {
    final reasonController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('사업자 거부'),
        content: TextField(
          controller: reasonController,
          decoration: const InputDecoration(labelText: '거부 사유', border: OutlineInputBorder()),
          maxLines: 3,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('취소')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('사업자 인증이 거부되었습니다')));
            },
            child: const Text('거부', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}

class _ApprovedList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: const CircleAvatar(backgroundColor: Colors.green, child: Icon(Icons.check, color: Colors.white)),
            title: const Text('카페 이름'),
            subtitle: const Text('사업자: 123-45-67890 | 승인일: 2024-01-01'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        );
      },
    );
  }
}

class _RejectedList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: const CircleAvatar(backgroundColor: Colors.red, child: Icon(Icons.close, color: Colors.white)),
            title: const Text('카페 이름'),
            subtitle: const Text('거부 사유: 서류 미비 | 거부일: 2024-01-01'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
        );
      },
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _InfoRow({required this.icon, required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
