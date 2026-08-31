import 'driver_model.dart';
import 'location_model.dart';
import 'user_model.dart';
import 'vehicle_model.dart';

enum RideStatus {
  requested,
  searchingDriver,
  driverAssigned,
  driverArriving,
  driverArrived,
  tripStarted,
  tripCompleted,
  cancelled;

  String get label => switch (this) {
        RideStatus.requested => 'Requested',
        RideStatus.searchingDriver => 'Searching driver',
        RideStatus.driverAssigned => 'Driver assigned',
        RideStatus.driverArriving => 'Driver arriving',
        RideStatus.driverArrived => 'Driver arrived',
        RideStatus.tripStarted => 'Trip started',
        RideStatus.tripCompleted => 'Completed',
        RideStatus.cancelled => 'Cancelled',
      };

  static RideStatus fromName(String? name) {
    return RideStatus.values.firstWhere(
      (status) => status.name == name,
      orElse: () => RideStatus.requested,
    );
  }
}

class RideModel {
  const RideModel({
    required this.id,
    required this.rider,
    required this.pickup,
    required this.drop,
    required this.vehicleType,
    required this.fare,
    required this.distanceKm,
    required this.durationMinutes,
    required this.status,
    required this.requestedAt,
    this.driver,
    this.completedAt,
    this.rating,
  });

  final String id;
  final UserModel rider;
  final DriverModel? driver;
  final LocationModel pickup;
  final LocationModel drop;
  final VehicleType vehicleType;
  final double fare;
  final double distanceKm;
  final int durationMinutes;
  final RideStatus status;
  final DateTime requestedAt;
  final DateTime? completedAt;
  final double? rating;

  // TODO: Update this model according to your existing backend API response.
  factory RideModel.fromJson(Map<String, dynamic> json) {
    return RideModel(
      id: json['id']?.toString() ?? '',
      rider: UserModel.fromJson(json['rider'] as Map<String, dynamic>? ?? {}),
      driver: json['driver'] == null
          ? null
          : DriverModel.fromJson(json['driver'] as Map<String, dynamic>),
      pickup: LocationModel.fromJson(
        json['pickup'] as Map<String, dynamic>? ?? {},
      ),
      drop: LocationModel.fromJson(
        json['drop'] as Map<String, dynamic>? ?? {},
      ),
      vehicleType: VehicleType.fromName(json['vehicle_type']?.toString()),
      fare: (json['fare'] as num?)?.toDouble() ?? 0,
      distanceKm: (json['distance_km'] as num?)?.toDouble() ?? 0,
      durationMinutes: (json['duration_minutes'] as num?)?.toInt() ?? 0,
      status: RideStatus.fromName(json['status']?.toString()),
      requestedAt: DateTime.tryParse(json['requested_at']?.toString() ?? '') ??
          DateTime.now(),
      completedAt: DateTime.tryParse(json['completed_at']?.toString() ?? ''),
      rating: (json['rating'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'rider': rider.toJson(),
        'driver': driver?.toJson(),
        'pickup': pickup.toJson(),
        'drop': drop.toJson(),
        'vehicle_type': vehicleType.name,
        'fare': fare,
        'distance_km': distanceKm,
        'duration_minutes': durationMinutes,
        'status': status.name,
        'requested_at': requestedAt.toIso8601String(),
        'completed_at': completedAt?.toIso8601String(),
        'rating': rating,
      };

  RideModel copyWith({
    DriverModel? driver,
    RideStatus? status,
    DateTime? completedAt,
    double? rating,
  }) {
    return RideModel(
      id: id,
      rider: rider,
      driver: driver ?? this.driver,
      pickup: pickup,
      drop: drop,
      vehicleType: vehicleType,
      fare: fare,
      distanceKm: distanceKm,
      durationMinutes: durationMinutes,
      status: status ?? this.status,
      requestedAt: requestedAt,
      completedAt: completedAt ?? this.completedAt,
      rating: rating ?? this.rating,
    );
  }
}
