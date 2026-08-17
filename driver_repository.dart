import 'package:ride_hailing_app/data/models/driver_model.dart';
import 'package:ride_hailing_app/data/models/ride_model.dart';
import 'package:ride_hailing_app/data/datasources/local/mock_data.dart';

class DriverRepository {
  Future<Driver> getDriver(String driverId) async {
    await Future.delayed(const Duration(seconds: 1));
    final driver = MockData.getDriverById(driverId);
    if (driver == null) {
      throw Exception('Driver not found');
    }
    return driver;
  }

  Future<Driver> updateDriver(Driver driver) async {
    await Future.delayed(const Duration(seconds: 1));
    return driver;
  }

  Future<Driver> setOnlineStatus(String driverId, bool isOnline) async {
    await Future.delayed(const Duration(seconds: 1));
    final driver = MockData.getDriverById(driverId);
    if (driver == null) {
      throw Exception('Driver not found');
    }
    return driver.copyWith(isOnline: isOnline);
  }

  Future<List<Ride>> getDriverRides(String driverId) async {
    await Future.delayed(const Duration(seconds: 1));
    return MockData.getDriverRides(driverId);
  }

  Future<Ride> acceptRide(String driverId, String rideId) async {
    await Future.delayed(const Duration(seconds: 1));
    final ride = MockData.getRideById(rideId);
    if (ride == null) {
      throw Exception('Ride not found');
    }
    return ride.copyWith(
      driverId: driverId,
      status: RideStatus.assigned,
      updatedAt: DateTime.now(),
    );
  }

  Future<Ride> rejectRide(String driverId, String rideId) async {
    await Future.delayed(const Duration(seconds: 1));
    final ride = MockData.getRideById(rideId);
    if (ride == null) {
      throw Exception('Ride not found');
    }
    return ride.copyWith(
      status: RideStatus.cancelled,
      cancellationReason: 'Rejected by driver',
      cancelledAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  Future<Map<String, dynamic>> getEarnings(String driverId) async {
    await Future.delayed(const Duration(seconds: 1));
    final rides = MockData.getDriverRides(driverId);
    final completedRides = rides.where((r) => r.status == RideStatus.completed);

    final totalEarnings = completedRides.fold<double>(
        0, (sum, ride) => sum + (ride.actualFare ?? ride.estimatedFare));

    return {
      'totalEarnings': totalEarnings,
      'totalRides': completedRides.length,
      'averageFare': completedRides.isNotEmpty
          ? totalEarnings / completedRides.length
          : 0,
      'totalDistance': completedRides.fold<double>(
          0, (sum, ride) => sum + (ride.distance ?? 0)),
      'totalHours': completedRides.fold<double>(
          0, (sum, ride) => sum + (ride.duration ?? 0)),
      'thisWeekEarnings': totalEarnings * 0.3, // Mock
      'thisMonthEarnings': totalEarnings * 0.7, // Mock
    };
  }
}