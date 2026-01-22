class EventModel {
  final String id;
  final String title;
  final String description;
  final String? imageUrl;
  final EventType type;
  final List<String>? targetCafeIds;
  final DateTime startDate;
  final DateTime endDate;
  final EventStatus status;
  final DateTime createdAt;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    required this.type,
    this.targetCafeIds,
    required this.startDate,
    required this.endDate,
    this.status = EventStatus.active,
    required this.createdAt,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String?,
      type: EventType.fromString(json['type'] as String),
      targetCafeIds: (json['targetCafeIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      status: EventStatus.fromString(json['status'] as String? ?? 'active'),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
}

enum EventType {
  platform,
  cafe;

  static EventType fromString(String value) {
    return EventType.values.firstWhere(
        (e) => e.toString().split('.').last == value,
        orElse: () => EventType.platform);
  }
}

enum EventStatus {
  active,
  inactive,
  ended;

  static EventStatus fromString(String value) {
    return EventStatus.values.firstWhere(
        (e) => e.toString().split('.').last == value,
        orElse: () => EventStatus.active);
  }
}

class BannerModel {
  final String id;
  final String title;
  final String imageUrl;
  final String? linkUrl;
  final int order;
  final bool isActive;
  final int clickCount;
  final DateTime createdAt;

  BannerModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.linkUrl,
    required this.order,
    this.isActive = true,
    this.clickCount = 0,
    required this.createdAt,
  });
}
