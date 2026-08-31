enum VehicleType {
  bike,
  economy,
  sedan,
  auto;

  String get label => switch (this) {
        VehicleType.bike => 'Bike',
        VehicleType.economy => 'Mini',
        VehicleType.sedan => 'Sedan',
        VehicleType.auto => 'Auto',
      };

  static VehicleType fromName(String? name) {
    return VehicleType.values.firstWhere(
      (type) => type.name == name,
      orElse: () => VehicleType.economy,
    );
  }
}

class VehicleModel {
  const VehicleModel({
    required this.id,
    required this.type,
    required this.name,
    required this.capacity,
    required this.baseFare,
    required this.perKmRate,
    required this.etaMinutes,
  });

  final String id;
  final VehicleType type;
  final String name;
  final int capacity;
  final double baseFare;
  final double perKmRate;
  final int etaMinutes;

  // TODO: Update this model according to your existing backend API response.
  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    return VehicleModel(
      id: json['id']?.toString() ?? '',
      type: VehicleType.fromName(json['type']?.toString()),
      name: json['name']?.toString() ?? '',
      capacity: (json['capacity'] as num?)?.toInt() ?? 1,
      baseFare: (json['base_fare'] as num?)?.toDouble() ?? 0,
      perKmRate: (json['per_km_rate'] as num?)?.toDouble() ?? 0,
      etaMinutes: (json['eta_minutes'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type.name,
        'name': name,
        'capacity': capacity,
        'base_fare': baseFare,
        'per_km_rate': perKmRate,
        'eta_minutes': etaMinutes,
      };
}
