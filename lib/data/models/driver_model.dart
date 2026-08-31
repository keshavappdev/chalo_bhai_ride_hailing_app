class DriverModel {
  const DriverModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.rating,
    required this.vehicleName,
    required this.vehicleNumber,
    required this.vehicleColor,
    this.profileImageUrl,
    this.isOnline = false,
  });

  final String id;
  final String name;
  final String phone;
  final double rating;
  final String vehicleName;
  final String vehicleNumber;
  final String vehicleColor;
  final String? profileImageUrl;
  final bool isOnline;

  // TODO: Update this model according to your existing backend API response.
  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      vehicleName: json['vehicle_name']?.toString() ?? '',
      vehicleNumber: json['vehicle_number']?.toString() ?? '',
      vehicleColor: json['vehicle_color']?.toString() ?? '',
      profileImageUrl: json['profile_image_url']?.toString(),
      isOnline: json['is_online'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'rating': rating,
        'vehicle_name': vehicleName,
        'vehicle_number': vehicleNumber,
        'vehicle_color': vehicleColor,
        'profile_image_url': profileImageUrl,
        'is_online': isOnline,
      };

  DriverModel copyWith({bool? isOnline}) {
    return DriverModel(
      id: id,
      name: name,
      phone: phone,
      rating: rating,
      vehicleName: vehicleName,
      vehicleNumber: vehicleNumber,
      vehicleColor: vehicleColor,
      profileImageUrl: profileImageUrl,
      isOnline: isOnline ?? this.isOnline,
    );
  }
}
