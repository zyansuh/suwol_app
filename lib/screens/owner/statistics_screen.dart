import 'package:flutter/material.dart';
import '../../utils/format_helper.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> with SingleTickerProviderStateMixin {
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
        title: const Text('통계'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [Tab(text: '매출'), Tab(text: '고객 방문'), Tab(text: '포인트')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_SalesStatistics(), _CustomerStatistics(), _PointStatistics()],
      ),
    );
  }
}

class _SalesStatistics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: 'day', label: Text('일간')),
                    ButtonSegment(value: 'week', label: Text('주간')),
                    ButtonSegment(value: 'month', label: Text('월간')),
                  ],
                  selected: {'day'},
                  onSelectionChanged: (selected) {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Card(
            color: Colors.green[50],
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text('오늘 매출', style: TextStyle(fontSize: 16, color: Colors.grey)),
                  const SizedBox(height: 8),
                  Text(FormatHelper.formatCurrency(450000), style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.green)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _SmallStatCard(title: '주간 매출', value: FormatHelper.formatCurrency(2800000))),
              const SizedBox(width: 12),
              Expanded(child: _SmallStatCard(title: '월간 매출', value: FormatHelper.formatCurrency(12000000))),
            ],
          ),
          const SizedBox(height: 24),
          const Text('매출 상세', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _DetailRow(label: '현금 결제', value: FormatHelper.formatCurrency(200000)),
                  const Divider(),
                  _DetailRow(label: '카드 결제', value: FormatHelper.formatCurrency(250000)),
                  const Divider(),
                  _DetailRow(label: '포인트 사용', value: FormatHelper.formatPoints(5000)),
                  const Divider(),
                  _DetailRow(label: '총 거래 건수', value: '28건', isBold: true),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomerStatistics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: Colors.blue[50],
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text('오늘 방문 고객', style: TextStyle(fontSize: 16, color: Colors.grey)),
                  const SizedBox(height: 8),
                  const Text('28명', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.blue)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _SmallStatCard(title: '주간 방문', value: '156명')),
              const SizedBox(width: 12),
              Expanded(child: _SmallStatCard(title: '월간 방문', value: '642명')),
            ],
          ),
          const SizedBox(height: 24),
          const Text('고객 유형', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _DetailRow(label: '신규 고객', value: '8명'),
                  const Divider(),
                  _DetailRow(label: '재방문 고객', value: '20명'),
                  const Divider(),
                  _DetailRow(label: '단골 고객 (5회 이상)', value: '12명'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text('등급별 고객 방문', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _DetailRow(label: '브론즈', value: '10명'),
                  const Divider(),
                  _DetailRow(label: '실버', value: '12명'),
                  const Divider(),
                  _DetailRow(label: '골드', value: '5명'),
                  const Divider(),
                  _DetailRow(label: '플래티넘', value: '1명'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text('시간대별 방문', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _DetailRow(label: '오전 (09:00-12:00)', value: '8명'),
                  const Divider(),
                  _DetailRow(label: '점심 (12:00-14:00)', value: '15명'),
                  const Divider(),
                  _DetailRow(label: '오후 (14:00-18:00)', value: '3명'),
                  const Divider(),
                  _DetailRow(label: '저녁 (18:00-21:00)', value: '2명'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PointStatistics extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            color: Colors.amber[50],
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text('오늘 적립 포인트', style: TextStyle(fontSize: 16, color: Colors.grey)),
                  const SizedBox(height: 8),
                  Text(FormatHelper.formatPoints(5600), style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.amber)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _SmallStatCard(title: '주간 적립', value: FormatHelper.formatPoints(28000))),
              const SizedBox(width: 12),
              Expanded(child: _SmallStatCard(title: '월간 적립', value: FormatHelper.formatPoints(120000))),
            ],
          ),
          const SizedBox(height: 24),
          const Text('포인트 사용', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _DetailRow(label: '오늘 사용', value: FormatHelper.formatPoints(3200)),
                  const Divider(),
                  _DetailRow(label: '주간 사용', value: FormatHelper.formatPoints(18000)),
                  const Divider(),
                  _DetailRow(label: '월간 사용', value: FormatHelper.formatPoints(75000)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text('적립 vs 사용', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 7,
                        child: Container(
                          height: 30,
                          decoration: const BoxDecoration(color: Colors.green, borderRadius: BorderRadius.horizontal(left: Radius.circular(8))),
                          child: const Center(child: Text('적립 70%', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 30,
                          decoration: const BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.horizontal(right: Radius.circular(8))),
                          child: const Center(child: Text('사용 30%', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _DetailRow(label: '총 적립 포인트', value: FormatHelper.formatPoints(120000)),
                  const Divider(),
                  _DetailRow(label: '총 사용 포인트', value: FormatHelper.formatPoints(75000)),
                  const Divider(),
                  _DetailRow(label: '순 적립', value: FormatHelper.formatPoints(45000), isBold: true),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text('평균 통계', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _DetailRow(label: '방문당 평균 적립', value: FormatHelper.formatPoints(200)),
                  const Divider(),
                  _DetailRow(label: '일일 평균 적립', value: FormatHelper.formatPoints(4000)),
                  const Divider(),
                  _DetailRow(label: '고객당 평균 적립', value: FormatHelper.formatPoints(187)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SmallStatCard extends StatelessWidget {
  final String title;
  final String value;
  const _SmallStatCard({required this.title, required this.value});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(title, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
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
          Text(label, style: TextStyle(fontSize: 14, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
          Text(value, style: TextStyle(fontSize: 14, fontWeight: isBold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
