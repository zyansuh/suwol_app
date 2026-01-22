class ReportModel {
  final String id;
  final String reporterId;
  final ReportType type;
  final String targetId;
  final String reason;
  final String? description;
  final ReportStatus status;
  final DateTime createdAt;
  final DateTime? resolvedAt;

  ReportModel({
    required this.id,
    required this.reporterId,
    required this.type,
    required this.targetId,
    required this.reason,
    this.description,
    this.status = ReportStatus.pending,
    required this.createdAt,
    this.resolvedAt,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'] as String,
      reporterId: json['reporterId'] as String,
      type: ReportType.fromString(json['type'] as String),
      targetId: json['targetId'] as String,
      reason: json['reason'] as String,
      description: json['description'] as String?,
      status: ReportStatus.fromString(json['status'] as String? ?? 'pending'),
      createdAt: DateTime.parse(json['createdAt'] as String),
      resolvedAt: json['resolvedAt'] != null ? DateTime.parse(json['resolvedAt'] as String) : null,
    );
  }
}

enum ReportType {
  user,
  post,
  comment;

  static ReportType fromString(String value) {
    return ReportType.values.firstWhere((e) => e.toString().split('.').last == value, orElse: () => ReportType.post);
  }
}

enum ReportStatus {
  pending,
  resolved,
  rejected;

  static ReportStatus fromString(String value) {
    return ReportStatus.values.firstWhere((e) => e.toString().split('.').last == value, orElse: () => ReportStatus.pending);
  }
}

class InquiryModel {
  final String id;
  final String userId;
  final String title;
  final String content;
  final String? answer;
  final InquiryStatus status;
  final DateTime createdAt;
  final DateTime? answeredAt;

  InquiryModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
    this.answer,
    this.status = InquiryStatus.pending,
    required this.createdAt,
    this.answeredAt,
  });
}

enum InquiryStatus {
  pending,
  answered;

  static InquiryStatus fromString(String value) {
    return InquiryStatus.values.firstWhere((e) => e.toString().split('.').last == value, orElse: () => InquiryStatus.pending);
  }
}
