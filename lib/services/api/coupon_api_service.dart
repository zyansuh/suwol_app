import '../api/api_client.dart';
import '../../models/coupon/coupon_model.dart';

class CouponApiService {
  final ApiClient _apiClient;

  CouponApiService(this._apiClient);

  Future<List<CouponModel>> getAvailableCoupons(String cafeId) async {
    final response = await _apiClient.get('/cafes/$cafeId/coupons');
    return (response.data as List)
        .map((json) => CouponModel.fromJson(json))
        .toList();
  }

  Future<List<UserCoupon>> getUserCoupons(String userId) async {
    final response = await _apiClient.get('/users/$userId/coupons');
    return (response.data as List)
        .map((json) => UserCoupon(
              id: json['id'] as String,
              userId: json['userId'] as String,
              couponId: json['couponId'] as String,
              coupon: CouponModel.fromJson(json['coupon']),
              issuedAt: DateTime.parse(json['issuedAt'] as String),
              usedAt: json['usedAt'] != null
                  ? DateTime.parse(json['usedAt'] as String)
                  : null,
              isUsed: json['isUsed'] as bool? ?? false,
            ))
        .toList();
  }

  Future<CouponModel> createCoupon(Map<String, dynamic> data) async {
    final response = await _apiClient.post('/coupons', data: data);
    return CouponModel.fromJson(response.data);
  }

  Future<void> issueCoupon(String userId, String couponId) async {
    await _apiClient.post('/coupons/$couponId/issue', data: {'userId': userId});
  }

  Future<void> useCoupon(String userCouponId) async {
    await _apiClient.post('/user-coupons/$userCouponId/use');
  }
}

