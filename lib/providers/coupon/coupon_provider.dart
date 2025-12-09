import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../../models/coupon/coupon_model.dart';
import '../../services/api/api_client.dart';
import '../../services/api/coupon_api_service.dart';
import '../../constants/api_constants.dart';

class CouponProvider with ChangeNotifier {
  final CouponApiService _couponApiService;
  final _uuid = const Uuid();
  List<UserCoupon> _userCoupons = [];
  List<CouponModel> _availableCoupons = [];
  bool _isLoading = false;

  CouponProvider()
      : _couponApiService = CouponApiService(
          ApiClient(baseUrl: ApiConstants.baseUrl),
        );

  List<UserCoupon> get userCoupons => _userCoupons;
  List<CouponModel> get availableCoupons => _availableCoupons;
  bool get isLoading => _isLoading;

  Future<void> loadUserCoupons(String userId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _userCoupons = await _couponApiService.getUserCoupons(userId);
    } catch (e) {
      // TODO: 에러 처리
      // fallback: keep existing
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadAvailableCoupons(String cafeId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _availableCoupons = await _couponApiService.getAvailableCoupons(cafeId);
    } catch (e) {
      // TODO: 에러 처리
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> issueCoupon(String userId, String couponId) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _couponApiService.issueCoupon(userId, couponId);
    } catch (e) {
      // 로컬 발급 (데모용)
      final coupon = _availableCoupons.firstWhere(
        (c) => c.id == couponId,
        orElse: () => CouponModel(
          id: couponId,
          cafeId: '',
          title: '임시 쿠폰',
          description: '',
          type: CouponType.amount,
          discountAmount: 0,
          validFrom: DateTime.now(),
          validUntil: DateTime.now().add(const Duration(days: 7)),
          createdAt: DateTime.now(),
        ),
      );

      final newUserCoupon = UserCoupon(
        id: _uuid.v4(),
        userId: userId,
        couponId: coupon.id,
        coupon: coupon,
        issuedAt: DateTime.now(),
        isUsed: false,
      );
      _userCoupons = [newUserCoupon, ..._userCoupons];
    } finally {
      await loadUserCoupons(userId);
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> useCoupon(String userCouponId) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _couponApiService.useCoupon(userCouponId);
      _userCoupons = _userCoupons.map((c) {
        if (c.id == userCouponId) {
          return UserCoupon(
            id: c.id,
            userId: c.userId,
            couponId: c.couponId,
            coupon: c.coupon,
            issuedAt: c.issuedAt,
            usedAt: DateTime.now(),
            isUsed: true,
          );
        }
        return c;
      }).toList();
    } catch (e) {
      // TODO: 에러 처리 또는 로컬 처리
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

