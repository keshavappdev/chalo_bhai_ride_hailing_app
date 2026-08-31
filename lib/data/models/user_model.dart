class UserModel {
  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.profileImageUrl,
    this.rating = 5,
  });

  final String id;
  final String name;
  final String email;
  final String phone;
  final String? profileImageUrl;
  final double rating;

  // TODO: Update this model according to your existing backend API response.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      profileImageUrl: json['profile_image_url']?.toString(),
      rating: (json['rating'] as num?)?.toDouble() ?? 5,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'profile_image_url': profileImageUrl,
        'rating': rating,
      };
}
