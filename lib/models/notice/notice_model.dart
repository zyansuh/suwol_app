class NoticeModel {
  final String id;
  final String title;
  final String content;
  final bool isPinned;
  final DateTime? publishStartDate;
  final DateTime? publishEndDate;
  final NoticeStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;

  NoticeModel({
    required this.id,
    required this.title,
    required this.content,
    this.isPinned = false,
    this.publishStartDate,
    this.publishEndDate,
    this.status = NoticeStatus.active,
    required this.createdAt,
    this.updatedAt,
  });

  factory NoticeModel.fromJson(Map<String, dynamic> json) {
    return NoticeModel(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      isPinned: json['isPinned'] as bool? ?? false,
      publishStartDate: json['publishStartDate'] != null
          ? DateTime.parse(json['publishStartDate'] as String)
          : null,
      publishEndDate: json['publishEndDate'] != null
          ? DateTime.parse(json['publishEndDate'] as String)
          : null,
      status: NoticeStatus.fromString(json['status'] as String? ?? 'active'),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'isPinned': isPinned,
      'publishStartDate': publishStartDate?.toIso8601String(),
      'publishEndDate': publishEndDate?.toIso8601String(),
      'status': status.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}

enum NoticeStatus {
  active,
  inactive;

  static NoticeStatus fromString(String value) {
    return NoticeStatus.values.firstWhere(
      (e) => e.toString().split('.').last == value,
      orElse: () => NoticeStatus.active,
    );
  }
}
