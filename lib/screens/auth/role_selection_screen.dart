import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class RoleSelectionScreen extends StatelessWidget {
  final RoleSelectionType type;

  const RoleSelectionScreen({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final isLogin = type == RoleSelectionType.login;

    return Scaffold(
      appBar: AppBar(
        title: Text(isLogin ? '로그인' : '회원가입'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isLogin ? '어떤 계정으로\n로그인하시겠어요?' : '어떤 계정으로\n가입하시겠어요?',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                isLogin
                    ? '카페링크 수월에 오신 것을 환영합니다'
                    : '카페링크 수월과 함께 시작하세요',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 60),
              _RoleCard(
                icon: Icons.person,
                title: '일반 사용자',
                description: '포인트 적립 및 쿠폰 사용',
                color: AppTheme.brandAccent,
                onTap: () {
                  if (isLogin) {
                    Navigator.pushNamed(context, '/login/customer');
                  } else {
                    Navigator.pushNamed(context, '/register/customer');
                  }
                },
              ),
              const SizedBox(height: 20),
              _RoleCard(
                icon: Icons.storefront,
                title: '카페 사업자',
                description: '카페 관리 및 쿠폰 발행',
                color: AppTheme.brandPrimary,
                onTap: () {
                  if (isLogin) {
                    Navigator.pushNamed(context, '/login/owner');
                  } else {
                    Navigator.pushNamed(context, '/register/owner');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum RoleSelectionType {
  login,
  register,
}

class _RoleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final VoidCallback onTap;

  const _RoleCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppTheme.cardRadius),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppTheme.cardRadius),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color.withOpacity(0.1),
                color.withOpacity(0.05),
              ],
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 48,
                  color: color,
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
