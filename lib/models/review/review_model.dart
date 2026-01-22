class ReviewModel {
  final String id;
  final String userId;
  final String cafeId;
  final int rating;
  final String content;
  final List<String> images;
  final DateTime createdAt;
  final DateTime? updatedAt;

  ReviewModel({
    required this.id,
    required this.userId,
    required this.cafeId,
    required this.rating,
    required this.content,
    this.images = const [],
    required this.createdAt,
    this.updatedAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      cafeId: json['cafeId'] as String,
      rating: json['rating'] as int,
      content: json['content'] as String,
      images: (json['images'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt'] as String) : null,
    );
  }
}
