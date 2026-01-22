//admin 전용 홈페이지

import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../constants/app_constants.dart';
import '../../routes/app_router.dart';

class SunsetHomeScreen extends StatelessWidget {
  const SunsetHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin 관리'),
        backgroundColor: AppTheme.brandPrimary,
        foregroundColor: Colors.white,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _AdminCard(
            icon: Icons.people,
            title: '사용자 관리',
            subtitle: '회원 정보 조회/관리',
            color: Colors.blue,
            onTap: () {
              AppRouter.router.push('/sunset/users');
            },
          ),
          _AdminCard(
            icon: Icons.local_cafe,
            title: '카페 관리',
            subtitle: '제휴 카페 승인/관리',
            color: Colors.brown,
            onTap: () {
              AppRouter.router.push('/sunset/cafes');
            },
          ),
          _AdminCard(
            icon: Icons.receipt_long,
            title: '쿠폰 관리',
            subtitle: '전체 쿠폰 조회/관리',
            color: Colors.orange,
            onTap: () {
              AppRouter.router.push('/sunset/coupons');
            },
          ),
          _AdminCard(
            icon: Icons.analytics,
            title: '통계',
            subtitle: '플랫폼 통계 조회',
            color: Colors.green,
            onTap: () {
              AppRouter.router.push('/sunset/statistics');
            },
          ),
          _AdminCard(
            icon: Icons.article,
            title: '게시글 관리',
            subtitle: '커뮤니티 게시글 관리',
            color: Colors.purple,
            onTap: () {
              AppRouter.router.push('/sunset/posts');
            },
          ),
          _AdminCard(
            icon: Icons.settings,
            title: '시스템 설정',
            subtitle: '앱 설정 관리',
            color: Colors.grey,
            onTap: () {
              AppRouter.router.push('/sunset/settings');
            },
          ),
        ],
      ),
    );
  }
}

class _AdminCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  const _AdminCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: color,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
