class CouponModel {
  final String id;
  final String cafeId;
  final String title;
  final String description;
  final CouponType type;
  final int discountAmount; // 할인 금액 또는 퍼센트
  final int? minPurchaseAmount; // 최소 구매 금액
  final DateTime validFrom;
  final DateTime validUntil;
  final int? maxUsageCount; // 최대 사용 횟수
  final String? imageUrl;
  final CouponStatus status;
  final DateTime createdAt;

  CouponModel({
    required this.id,
    required this.cafeId,
    required this.title,
    required this.description,
    required this.type,
    required this.discountAmount,
    this.minPurchaseAmount,
    required this.validFrom,
    required this.validUntil,
    this.maxUsageCount,
    this.imageUrl,
    this.status = CouponStatus.active,
    required this.createdAt,
  });

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      id: json['id'] as String,
      cafeId: json['cafeId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      type: CouponType.fromString(json['type'] as String),
      discountAmount: json['discountAmount'] as int,
      minPurchaseAmount: json['minPurchaseAmount'] as int?,
      validFrom: DateTime.parse(json['validFrom'] as String),
      validUntil: DateTime.parse(json['validUntil'] as String),
      maxUsageCount: json['maxUsageCount'] as int?,
      imageUrl: json['imageUrl'] as String?,
      status: CouponStatus.fromString(json['status'] as String? ?? 'active'),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cafeId': cafeId,
      'title': title,
      'description': description,
      'type': type.toString().split('.').last,
      'discountAmount': discountAmount,
      'minPurchaseAmount': minPurchaseAmount,
      'validFrom': validFrom.toIso8601String(),
      'validUntil': validUntil.toIso8601String(),
      'maxUsageCount': maxUsageCount,
      'imageUrl': imageUrl,
      'status': status.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

enum CouponType {
  amount, // 정액 할인
  percent; // 퍼센트 할인

  static CouponType fromString(String value) {
    return CouponType.values.firstWhere(
      (e) => e.toString().split('.').last == value,
      orElse: () => CouponType.amount,
    );
  }
}

enum CouponStatus {
  active,
  inactive,
  expired;

  static CouponStatus fromString(String value) {
    return CouponStatus.values.firstWhere(
      (e) => e.toString().split('.').last == value,
      orElse: () => CouponStatus.inactive,
    );
  }
}

// 사용자가 보유한 쿠폰
class UserCoupon {
  final String id;
  final String userId;
  final String couponId;
  final CouponModel coupon;
  final DateTime issuedAt;
  final DateTime? usedAt;
  final bool isUsed;

  UserCoupon({
    required this.id,
    required this.userId,
    required this.couponId,
    required this.coupon,
    required this.issuedAt,
    this.usedAt,
    this.isUsed = false,
  });
}
