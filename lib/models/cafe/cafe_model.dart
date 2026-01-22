class CafeModel {
  final String id;
  final String name;
  final String ownerId;
  final String address;
  final double latitude;
  final double longitude;
  final String? phoneNumber;
  final String? description;
  final String? imageUrl;
  final List<String> images;
  final CafeStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;

  CafeModel({
    required this.id,
    required this.name,
    required this.ownerId,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.phoneNumber,
    this.description,
    this.imageUrl,
    this.images = const [],
    this.status = CafeStatus.active,
    required this.createdAt,
    this.updatedAt,
  });

  factory CafeModel.fromJson(Map<String, dynamic> json) {
    return CafeModel(
      id: json['id'] as String,
      name: json['name'] as String,
      ownerId: json['ownerId'] as String,
      address: json['address'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      phoneNumber: json['phoneNumber'] as String?,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      status: CafeStatus.fromString(json['status'] as String? ?? 'active'),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'ownerId': ownerId,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'phoneNumber': phoneNumber,
      'description': description,
      'imageUrl': imageUrl,
      'images': images,
      'status': status.toString().split('.').last,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}

enum CafeStatus {
  active,
  inactive,
  pending;

  static CafeStatus fromString(String value) {
    return CafeStatus.values.firstWhere(
      (e) => e.toString().split('.').last == value,
      orElse: () => CafeStatus.pending,
    );
  }
}
