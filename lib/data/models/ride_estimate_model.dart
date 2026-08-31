import 'vehicle_model.dart';

class RideEstimateModel {
  const RideEstimateModel({
    required this.distanceKm,
    required this.durationMinutes,
    required this.vehicleFares,
  });

  final double distanceKm;
  final int durationMinutes;
  final Map<VehicleType, double> vehicleFares;

  double fareFor(VehicleType type) => vehicleFares[type] ?? 0;

  // TODO: Update this model according to your existing backend API response.
  factory RideEstimateModel.fromJson(Map<String, dynamic> json) {
    final fares = (json['vehicle_fares'] as Map<String, dynamic>?) ?? {};
    return RideEstimateModel(
      distanceKm: (json['distance_km'] as num?)?.toDouble() ?? 0,
      durationMinutes: (json['duration_minutes'] as num?)?.toInt() ?? 0,
      vehicleFares: {
        for (final entry in fares.entries)
          VehicleType.fromName(entry.key): (entry.value as num).toDouble(),
      },
    );
  }

  Map<String, dynamic> toJson() => {
        'distance_km': distanceKm,
        'duration_minutes': durationMinutes,
        'vehicle_fares': {
          for (final entry in vehicleFares.entries) entry.key.name: entry.value,
        },
      };
}
