import 'package:flutter/material.dart';
import '../../routes/app_router.dart';
import '../../theme/app_theme.dart';

class OwnerHomeScreen extends StatelessWidget {
  const OwnerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('사장님 관리'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '환영합니다, 사장님!',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '오늘도 좋은 하루 되세요 ☕',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              '오늘의 통계',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _StatCard(icon: Icons.people, title: '방문 고객', value: '28', unit: '명', color: Colors.blue)),
                const SizedBox(width: 12),
                Expanded(child: _StatCard(icon: Icons.stars, title: '적립 포인트', value: '5,600', unit: 'P', color: Colors.amber)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _StatCard(icon: Icons.local_offer, title: '사용 쿠폰', value: '12', unit: '개', color: Colors.orange)),
                const SizedBox(width: 12),
                Expanded(child: _StatCard(icon: Icons.attach_money, title: '매출', value: '450,000', unit: '원', color: Colors.green)),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              '관리',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _MenuCard(icon: Icons.store, title: '카페 관리', description: '카페 정보 수정 및 운영 관리', onTap: () => AppRouter.router.push('/owner/cafe')),
            const SizedBox(height: 12),
            _MenuCard(icon: Icons.local_offer, title: '쿠폰 관리', description: '쿠폰 생성 및 발급 관리', onTap: () => AppRouter.router.push('/owner/coupons')),
            const SizedBox(height: 12),
            _MenuCard(icon: Icons.analytics, title: '통계', description: '매출, 고객, 포인트 통계 조회', onTap: () => AppRouter.router.push('/owner/statistics')),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final String unit;
  final Color color;
  const _StatCard({required this.icon, required this.title, required this.value, required this.unit, required this.color});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
                Text(' $unit', style: const TextStyle(fontSize: 12)),
              ],
            ),
            Text(title, style: const TextStyle(fontSize: 11), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;
  const _MenuCard({required this.icon, required this.title, required this.description, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppTheme.brandPrimary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: AppTheme.brandPrimary, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(description, style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
