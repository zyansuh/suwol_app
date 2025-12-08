class RewardModel {
  final String id;
  final String userId;
  final RewardLevel level;
  final int totalPoints;
  final int totalVisits;
  final DateTime lastVisitAt;
  final DateTime updatedAt;

  RewardModel({
    required this.id,
    required this.userId,
    required this.level,
    required this.totalPoints,
    required this.totalVisits,
    required this.lastVisitAt,
    required this.updatedAt,
  });

  factory RewardModel.fromJson(Map<String, dynamic> json) {
    return RewardModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      level: RewardLevel.fromString(json['level'] as String),
      totalPoints: json['totalPoints'] as int,
      totalVisits: json['totalVisits'] as int,
      lastVisitAt: DateTime.parse(json['lastVisitAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'level': level.toString().split('.').last,
      'totalPoints': totalPoints,
      'totalVisits': totalVisits,
      'lastVisitAt': lastVisitAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}

enum RewardLevel {
  bronze, // 브론즈
  silver, // 실버
  gold, // 골드
  platinum; // 플래티넘

  static RewardLevel fromString(String value) {
    return RewardLevel.values.firstWhere(
      (e) => e.toString().split('.').last == value,
      orElse: () => RewardLevel.bronze,
    );
  }

  String get displayName {
    switch (this) {
      case RewardLevel.bronze:
        return '브론즈';
      case RewardLevel.silver:
        return '실버';
      case RewardLevel.gold:
        return '골드';
      case RewardLevel.platinum:
        return '플래티넘';
    }
  }

  int get requiredPoints {
    switch (this) {
      case RewardLevel.bronze:
        return 0;
      case RewardLevel.silver:
        return 1000;
      case RewardLevel.gold:
        return 5000;
      case RewardLevel.platinum:
        return 10000;
    }
  }
}

