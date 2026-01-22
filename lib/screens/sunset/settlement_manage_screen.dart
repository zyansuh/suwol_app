import 'package:flutter/material.dart';
import '../../utils/format_helper.dart';

class SettlementManageScreen extends StatefulWidget {
  const SettlementManageScreen({super.key});

  @override
  State<SettlementManageScreen> createState() => _SettlementManageScreenState();
}

class _SettlementManageScreenState extends State<SettlementManageScreen> with SingleTickerProviderStateMixin {
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
        title: const Text('정산 관리'),
        bottom: TabBar(controller: _tabController, tabs: const [Tab(text: '정산 대기'), Tab(text: '승인 완료'), Tab(text: '지급 완료')]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_PendingList(), _ApprovedList(), _PaidList()],
      ),
    );
  }
}

class _PendingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ExpansionTile(
            leading: const Icon(Icons.account_balance_wallet, color: Colors.orange),
            title: const Text('카페 이름'),
            subtitle: const Text('정산 기간: 2024-01-01 ~ 2024-01-31'),
            trailing: Chip(label: const Text('대기 중'), backgroundColor: Colors.orange[100]),
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _DetailRow(label: '총 매출', value: FormatHelper.formatCurrency(2500000)),
                    const Divider(),
                    _DetailRow(label: '플랫폼 수수료 (5%)', value: FormatHelper.formatCurrency(125000)),
                    const Divider(),
                    _DetailRow(label: '정산 금액', value: FormatHelper.formatCurrency(2375000), isBold: true),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(onPressed: () {}, child: const Text('거부')),
                        const SizedBox(width: 8),
                        ElevatedButton(onPressed: () {}, child: const Text('승인')),
                      ],
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

class _ApprovedList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: const Icon(Icons.check_circle, color: Colors.green),
            title: const Text('카페 이름'),
            subtitle: Text('정산 금액: ${FormatHelper.formatCurrency(2375000)} | 승인일: 2024-01-31'),
            trailing: ElevatedButton(onPressed: () {}, child: const Text('지급')),
          ),
        );
      },
    );
  }
}

class _PaidList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 12,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: ListTile(
            leading: const Icon(Icons.done_all, color: Colors.blue),
            title: const Text('카페 이름'),
            subtitle: Text('정산 금액: ${FormatHelper.formatCurrency(2375000)} | 지급일: 2024-02-05'),
          ),
        );
      },
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  final bool isBold;
  const _DetailRow({required this.label, required this.value, this.isBold = false});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(value, style: TextStyle(fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
