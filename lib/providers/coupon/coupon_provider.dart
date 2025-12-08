import 'package:flutter/foundation.dart';
import '../../models/coupon/coupon_model.dart';
import '../../services/api/api_client.dart';
import '../../services/api/coupon_api_service.dart';
import '../../constants/api_constants.dart';

class CouponProvider with ChangeNotifier {
  final CouponApiService _couponApiService;
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
      await loadUserCoupons(userId);
    } catch (e) {
      // TODO: 에러 처리
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

