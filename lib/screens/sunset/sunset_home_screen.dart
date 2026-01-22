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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('핵심 관리', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
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
            icon: Icons.business_center,
            title: '사업자 인증',
            subtitle: '사업자 등록 승인/거부',
            color: Colors.teal,
            onTap: () {
              AppRouter.router.push('/sunset/business');
            },
          ),
          _AdminCard(
            icon: Icons.report,
            title: '신고/문의',
            subtitle: '신고 및 문의 관리',
            color: Colors.red,
            onTap: () {
              AppRouter.router.push('/sunset/reports');
            },
          ),
        ],
      ),
      const SizedBox(height: 24),
      const Text('콘텐츠 관리', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      const SizedBox(height: 12),
      GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _AdminCard(
            icon: Icons.campaign,
            title: '공지사항',
            subtitle: '공지사항 작성/관리',
            color: Colors.indigo,
            onTap: () {
              AppRouter.router.push('/sunset/notices');
            },
          ),
          _AdminCard(
            icon: Icons.celebration,
            title: '이벤트/프로모션',
            subtitle: '이벤트 생성/관리',
            color: Colors.pink,
            onTap: () {
              AppRouter.router.push('/sunset/events');
            },
          ),
          _AdminCard(
            icon: Icons.star_rate,
            title: '리뷰 관리',
            subtitle: '카페 리뷰 조회/관리',
            color: Colors.amber,
            onTap: () {
              AppRouter.router.push('/sunset/reviews');
            },
          ),
          _AdminCard(
            icon: Icons.view_carousel,
            title: '배너/광고',
            subtitle: '홈 배너 관리',
            color: Colors.deepPurple,
            onTap: () {
              AppRouter.router.push('/sunset/banners');
            },
          ),
        ],
      ),
      const SizedBox(height: 24),
      const Text('운영 관리', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      const SizedBox(height: 12),
      GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _AdminCard(
            icon: Icons.payment,
            title: '정산 관리',
            subtitle: '카페 정산 승인/지급',
            color: Colors.cyan,
            onTap: () {
              AppRouter.router.push('/sunset/settlements');
            },
          ),
          _AdminCard(
            icon: Icons.notifications_active,
            title: '푸시 알림',
            subtitle: '알림 발송 관리',
            color: Colors.deepOrange,
            onTap: () {
              AppRouter.router.push('/sunset/notifications');
            },
          ),
          _AdminCard(
            icon: Icons.admin_panel_settings,
            title: '권한 관리',
            subtitle: 'Admin 권한 설정',
            color: Colors.blueGrey,
            onTap: () {
              AppRouter.router.push('/sunset/permissions');
            },
          ),
          _AdminCard(
            icon: Icons.history,
            title: '시스템 로그',
            subtitle: '오류/활동/API 로그',
            color: Colors.grey,
            onTap: () {
              AppRouter.router.push('/sunset/logs');
            },
          ),
          _AdminCard(
            icon: Icons.settings,
            title: '시스템 설정',
            subtitle: '앱 설정 관리',
            color: Colors.blueGrey,
            onTap: () {
              AppRouter.router.push('/sunset/settings');
            },
          ),
        ],
      ),
    ],
  ),
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
