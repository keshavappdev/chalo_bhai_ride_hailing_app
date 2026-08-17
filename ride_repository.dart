import 'package:ride_hailing_app/data/models/ride_model.dart';
import 'package:ride_hailing_app/data/models/location_model.dart';
import 'package:ride_hailing_app/data/models/driver_model.dart';
import 'package:ride_hailing_app/data/datasources/local/mock_data.dart';

class RideRepository {
  Future<Ride> bookRide(
      Location pickupLocation,
      Location dropoffLocation,
      RideType rideType,
      DateTime? scheduledTime,
      List<String>? specialRequests,
      ) async {
    await Future.delayed(const Duration(seconds: 1));

    final ride = Ride(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: 'user1',
      pickupLocation: pickupLocation,
      dropoffLocation: dropoffLocation,
      scheduledTime: scheduledTime ?? DateTime.now(),
      status: RideStatus.searching,
      rideType: rideType,
      estimatedFare: _calculateFare(pickupLocation, dropoffLocation, rideType),
      isScheduled: scheduledTime != null,
      specialRequests: specialRequests,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    return ride;
  }

  Future<double> estimateFare(
      Location pickupLocation,
      Location dropoffLocation,
      RideType rideType,
      ) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _calculateFare(pickupLocation, dropoffLocation, rideType);
  }

  double _calculateFare(Location pickup, Location dropoff, RideType type) {
    // Mock fare calculation
    final baseFare = 50.0;
    final distance = 5.0; // Mock distance
    final distanceCharge = distance * 10.0;
    final timeCharge = 15.0;
    final serviceFee = 15.0;

    final typeMultiplier = {
      RideType.standard: 1.0,
      RideType.premium: 1.5,
      RideType.luxury: 2.5,
      RideType.shared: 0.8,
      RideType.pet: 1.2,
      RideType.wheelchair: 1.3,
    };

    final total = (baseFare + distanceCharge + timeCharge + serviceFee) *
        (typeMultiplier[type] ?? 1.0);

    return double.parse(total.toStringAsFixed(0));
  }

  Future<List<Driver>> searchNearbyDrivers(Location location, double radius) async {
    await Future.delayed(const Duration(seconds: 1));
    return MockData.getAvailableDrivers();
  }

  Future<Ride> assignDriver(String rideId, String driverId) async {
    await Future.delayed(const Duration(seconds: 1));

    final ride = MockData.getRideById(rideId);
    final driver = MockData.getDriverById(driverId);

    if (ride == null || driver == null) {
      throw Exception('Ride or driver not found');
    }

    return ride.copyWith(
      driverId: driverId,
      driver: driver,
      status: RideStatus.assigned,
      vehicle: driver.vehicle,
      updatedAt: DateTime.now(),
    );
  }

  Future<Ride> trackRide(String rideId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final ride = MockData.getRideById(rideId);
    if (ride == null) {
      throw Exception('Ride not found');
    }

    return ride;
  }

  Future<Ride> cancelRide(String rideId, String? reason) async {
    await Future.delayed(const Duration(seconds: 1));

    final ride = MockData.getRideById(rideId);
    if (ride == null) {
      throw Exception('Ride not found');
    }

    return ride.copyWith(
      status: RideStatus.cancelled,
      cancellationReason: reason,
      cancelledAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  Future<List<Ride>> getRideHistory(String userId, int limit) async {
    await Future.delayed(const Duration(seconds: 1));
    return MockData.getUserRides(userId).take(limit).toList();
  }

  Future<Ride> rateRide(
      String rideId,
      double rating,
      String? feedback,
      bool isDriverRating,
      ) async {
    await Future.delayed(const Duration(seconds: 1));

    final ride = MockData.getRideById(rideId);
    if (ride == null) {
      throw Exception('Ride not found');
    }

    if (isDriverRating) {
      return ride.copyWith(
        driverRating: rating,
        driverFeedback: feedback,
        updatedAt: DateTime.now(),
      );
    } else {
      return ride.copyWith(
        userRating: rating,
        userFeedback: feedback,
        updatedAt: DateTime.now(),
      );
    }
  }

  Future<Ride> updateRideStatus(String rideId, RideStatus status) async {
    await Future.delayed(const Duration(milliseconds: 500));

    final ride = MockData.getRideById(rideId);
    if (ride == null) {
      throw Exception('Ride not found');
    }

    return ride.copyWith(
      status: status,
      updatedAt: DateTime.now(),
      startedAt: status == RideStatus.started ? DateTime.now() : ride.startedAt,
      completedAt: status == RideStatus.completed ? DateTime.now() : ride.completedAt,
    );
  }
}