class PointModel {
  final String id;
  final String userId;
  final String cafeId;
  final int amount; // 적립 또는 사용된 포인트
  final PointType type; // earn or use
  final String? description;
  final DateTime createdAt;

  PointModel({
    required this.id,
    required this.userId,
    required this.cafeId,
    required this.amount,
    required this.type,
    this.description,
    required this.createdAt,
  });

  factory PointModel.fromJson(Map<String, dynamic> json) {
    return PointModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      cafeId: json['cafeId'] as String,
      amount: json['amount'] as int,
      type: PointType.fromString(json['type'] as String),
      description: json['description'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'cafeId': cafeId,
      'amount': amount,
      'type': type.toString().split('.').last,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

enum PointType {
  earn, // 적립
  use; // 사용

  static PointType fromString(String value) {
    return PointType.values.firstWhere(
      (e) => e.toString().split('.').last == value,
      orElse: () => PointType.earn,
    );
  }
}

// 사용자의 총 포인트 정보
class UserPointSummary {
  final String userId;
  final int totalPoints;
  final DateTime lastUpdated;

  UserPointSummary({
    required this.userId,
    required this.totalPoints,
    required this.lastUpdated,
  });
}

