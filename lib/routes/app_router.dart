import 'package:go_router/go_router.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/common/splash_screen.dart';
import '../screens/customer/home_screen.dart';
import '../screens/customer/point_screen.dart';
import '../screens/customer/coupon_screen.dart';
import '../screens/customer/reward_screen.dart';
import '../screens/customer/profile_screen.dart';
import '../screens/owner/owner_home_screen.dart';
import '../screens/owner/cafe_manage_screen.dart';
import '../screens/owner/coupon_manage_screen.dart' as owner;
import '../screens/owner/statistics_screen.dart' as owner;
import '../screens/map/cafe_map_screen.dart';
import '../screens/map/cafe_list_screen.dart';
import '../screens/map/cafe_detail_screen.dart';
import '../screens/community/community_feed_screen.dart';
import '../screens/community/post_detail_screen.dart';
import '../screens/sunset/sunset_home_screen.dart';
import '../screens/sunset/user_manage_screen.dart';
import '../screens/sunset/cafe_approval_screen.dart';
import '../screens/sunset/coupon_manage_screen.dart' as sunset;
import '../screens/sunset/statistics_screen.dart' as sunset;
import '../screens/sunset/post_manage_screen.dart';
import '../screens/sunset/settings_screen.dart';
import '../screens/sunset/business_verification_screen.dart';
import '../screens/sunset/report_manage_screen.dart';
import '../screens/sunset/notice_manage_screen.dart';
import '../screens/sunset/event_manage_screen.dart';
import '../screens/sunset/review_manage_screen.dart';
import '../screens/sunset/settlement_manage_screen.dart';
import '../screens/sunset/notification_manage_screen.dart';
import '../screens/sunset/banner_manage_screen.dart';
import '../screens/sunset/permission_manage_screen.dart';
import '../screens/sunset/system_log_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const CustomerHomeScreen(),
      ),
      GoRoute(
        path: '/points',
        builder: (context, state) => const PointScreen(),
      ),
      GoRoute(
        path: '/coupons',
        builder: (context, state) => const CouponScreen(),
      ),
      GoRoute(
        path: '/rewards',
        builder: (context, state) => const RewardScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/owner',
        builder: (context, state) => const OwnerHomeScreen(),
      ),
      GoRoute(
        path: '/owner/cafe',
        builder: (context, state) => const CafeManageScreen(),
      ),
      GoRoute(
        path: '/owner/coupons',
        builder: (context, state) => const owner.CouponManageScreen(),
      ),
      GoRoute(
        path: '/owner/statistics',
        builder: (context, state) => const owner.StatisticsScreen(),
      ),
      GoRoute(
        path: '/map',
        builder: (context, state) => const CafeMapScreen(),
      ),
      GoRoute(
        path: '/cafes',
        builder: (context, state) => const CafeListScreen(),
      ),
      GoRoute(
        path: '/cafes/:cafeId',
        builder: (context, state) {
          final cafeId = state.pathParameters['cafeId']!;
          return CafeDetailScreen(cafeId: cafeId);
        },
      ),
      GoRoute(
        path: '/community',
        builder: (context, state) => const CommunityFeedScreen(),
      ),
      GoRoute(
        path: '/community/:postId',
        builder: (context, state) {
          final postId = state.pathParameters['postId']!;
          return PostDetailScreen(postId: postId);
        },
      ),
      // Admin (Sunset) Routes
      GoRoute(
        path: '/sunset',
        builder: (context, state) => const SunsetHomeScreen(),
      ),
      GoRoute(
        path: '/sunset/users',
        builder: (context, state) => const UserManageScreen(),
      ),
      GoRoute(
        path: '/sunset/cafes',
        builder: (context, state) => const CafeApprovalScreen(),
      ),
      GoRoute(
        path: '/sunset/coupons',
        builder: (context, state) => const sunset.CouponManageScreen(),
      ),
      GoRoute(
        path: '/sunset/statistics',
        builder: (context, state) => const sunset.StatisticsScreen(),
      ),
      GoRoute(
        path: '/sunset/posts',
        builder: (context, state) => const PostManageScreen(),
      ),
      GoRoute(
        path: '/sunset/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/sunset/business',
        builder: (context, state) => const BusinessVerificationScreen(),
      ),
      GoRoute(
        path: '/sunset/reports',
        builder: (context, state) => const ReportManageScreen(),
      ),
      GoRoute(
        path: '/sunset/notices',
        builder: (context, state) => const NoticeManageScreen(),
      ),
      GoRoute(
        path: '/sunset/events',
        builder: (context, state) => const EventManageScreen(),
      ),
      GoRoute(
        path: '/sunset/reviews',
        builder: (context, state) => const ReviewManageScreen(),
      ),
      GoRoute(
        path: '/sunset/settlements',
        builder: (context, state) => const SettlementManageScreen(),
      ),
      GoRoute(
        path: '/sunset/notifications',
        builder: (context, state) => const NotificationManageScreen(),
      ),
      GoRoute(
        path: '/sunset/banners',
        builder: (context, state) => const BannerManageScreen(),
      ),
      GoRoute(
        path: '/sunset/permissions',
        builder: (context, state) => const PermissionManageScreen(),
      ),
      GoRoute(
        path: '/sunset/logs',
        builder: (context, state) => const SystemLogScreen(),
      ),
    ],
  );
}
