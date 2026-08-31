class LocationModel {
  const LocationModel({
    required this.latitude,
    required this.longitude,
    required this.address,
    this.title,
  });

  final double latitude;
  final double longitude;
  final String address;
  final String? title;

  // TODO: Update this model according to your existing backend API response.
  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      latitude: (json['latitude'] as num?)?.toDouble() ?? 0,
      longitude: (json['longitude'] as num?)?.toDouble() ?? 0,
      address: json['address']?.toString() ?? '',
      title: json['title']?.toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'latitude': latitude,
        'longitude': longitude,
        'address': address,
        if (title != null) 'title': title,
      };

  LocationModel copyWith({
    double? latitude,
    double? longitude,
    String? address,
    String? title,
  }) {
    return LocationModel(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
      title: title ?? this.title,
    );
  }
}
