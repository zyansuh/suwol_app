import '../../models/coupon/coupon_model.dart';
import '../../services/api/api_client.dart';
import '../../services/api/coupon_api_service.dart';
import '../../services/auth/current_user_service.dart';
import '../../constants/api_constants.dart';
import '../../core/base_provider.dart';

class CouponProvider extends BaseProvider {
  final CouponApiService _couponApiService;
  final CurrentUserService _currentUserService = CurrentUserService();
  List<UserCoupon> _userCoupons = [];
  List<CouponModel> _availableCoupons = [];

  CouponProvider()
      : _couponApiService = CouponApiService(
          ApiClient(baseUrl: ApiConstants.baseUrl),
        );

  List<UserCoupon> get userCoupons => _userCoupons;
  List<CouponModel> get availableCoupons => _availableCoupons;

  String? get _currentUserId => _currentUserService.currentUserId;

  Future<void> loadUserCoupons([String? userId]) async {
    final targetUserId = userId ?? _currentUserId;
    if (targetUserId == null) return;

    await safeAsync(() async {
      _userCoupons = await _couponApiService.getUserCoupons(targetUserId);
    });
  }

  Future<void> loadAvailableCoupons(String cafeId) async {
    await safeAsync(() async {
      _availableCoupons = await _couponApiService.getAvailableCoupons(cafeId);
    });
  }

  Future<void> issueCoupon(String couponId, [String? userId]) async {
    final targetUserId = userId ?? _currentUserId;
    if (targetUserId == null) return;

    await safeAsync(() async {
      await _couponApiService.issueCoupon(targetUserId, couponId);
      await loadUserCoupons(targetUserId);
    });
  }

  Future<void> useCoupon(String userCouponId) async {
    await safeAsync(() async {
      await _couponApiService.useCoupon(userCouponId);
      await loadUserCoupons();
    });
  }
}
