import '../models/driver_model.dart';
import '../models/earnings_model.dart';
import '../models/location_model.dart';
import '../models/ride_model.dart';
import '../models/user_model.dart';
import '../models/vehicle_model.dart';

abstract final class MockData {
  static const rider = UserModel(
    id: 'rider_101',
    name: 'Keshav Upadhyay',
    email: 'rider@chalobhai.demo',
    phone: '+91 98765 43210',
    rating: 4.9,
  );

  static const driver = DriverModel(
    id: 'driver_201',
    name: 'Arjun Singh',
    phone: '+91 98111 22334',
    rating: 4.8,
    vehicleName: 'Maruti Suzuki Dzire',
    vehicleNumber: 'DL 01 AB 4521',
    vehicleColor: 'White',
  );

  static const pickup = LocationModel(
    latitude: 28.6139,
    longitude: 77.2090,
    title: 'Current location',
    address: 'Connaught Place, New Delhi',
  );

  static const locations = [
    LocationModel(
      latitude: 28.5562,
      longitude: 77.1000,
      title: 'Airport',
      address: 'Indira Gandhi International Airport, Delhi',
    ),
    LocationModel(
      latitude: 28.5933,
      longitude: 77.2507,
      title: 'Sarai Kale Khan',
      address: 'Sarai Kale Khan ISBT, New Delhi',
    ),
    LocationModel(
      latitude: 28.5535,
      longitude: 77.2588,
      title: 'Nehru Place',
      address: 'Nehru Place, New Delhi',
    ),
    LocationModel(
      latitude: 28.5245,
      longitude: 77.1855,
      title: 'Saket',
      address: 'Select Citywalk, Saket, New Delhi',
    ),
    LocationModel(
      latitude: 28.4595,
      longitude: 77.0266,
      title: 'Cyber Hub',
      address: 'DLF Cyber Hub, Gurugram',
    ),
  ];

  static const vehicles = [
    VehicleModel(
      id: 'vehicle_bike',
      type: VehicleType.bike,
      name: 'Chalo Bike',
      capacity: 1,
      baseFare: 25,
      perKmRate: 7,
      etaMinutes: 2,
    ),
    VehicleModel(
      id: 'vehicle_mini',
      type: VehicleType.economy,
      name: 'Chalo Mini',
      capacity: 4,
      baseFare: 55,
      perKmRate: 12,
      etaMinutes: 4,
    ),
    VehicleModel(
      id: 'vehicle_sedan',
      type: VehicleType.sedan,
      name: 'Chalo Sedan',
      capacity: 4,
      baseFare: 85,
      perKmRate: 16,
      etaMinutes: 6,
    ),
    VehicleModel(
      id: 'vehicle_auto',
      type: VehicleType.auto,
      name: 'Chalo Auto',
      capacity: 3,
      baseFare: 40,
      perKmRate: 10,
      etaMinutes: 3,
    ),
  ];

  static List<RideModel> riderHistory() => [
        RideModel(
          id: 'ride_9001',
          rider: rider,
          driver: driver,
          pickup: pickup,
          drop: locations[1],
          vehicleType: VehicleType.economy,
          fare: 236,
          distanceKm: 12.4,
          durationMinutes: 31,
          status: RideStatus.tripCompleted,
          requestedAt: DateTime.now().subtract(const Duration(days: 2)),
          completedAt: DateTime.now().subtract(const Duration(days: 2)),
          rating: 5,
        ),
        RideModel(
          id: 'ride_9002',
          rider: rider,
          driver: driver,
          pickup: locations[3],
          drop: locations[4],
          vehicleType: VehicleType.sedan,
          fare: 482,
          distanceKm: 21.6,
          durationMinutes: 45,
          status: RideStatus.tripCompleted,
          requestedAt: DateTime.now().subtract(const Duration(days: 8)),
          completedAt: DateTime.now().subtract(const Duration(days: 8)),
          rating: 4,
        ),
      ];

  static List<RideModel> rideRequests() => [
        RideModel(
          id: 'request_3001',
          rider: const UserModel(
            id: 'rider_301',
            name: 'Meera Kapoor',
            email: 'meera@example.com',
            phone: '+91 90000 11223',
            rating: 4.9,
          ),
          pickup: locations[2],
          drop: locations[4],
          vehicleType: VehicleType.economy,
          fare: 418,
          distanceKm: 19.2,
          durationMinutes: 41,
          status: RideStatus.requested,
          requestedAt: DateTime.now(),
        ),
        RideModel(
          id: 'request_3002',
          rider: const UserModel(
            id: 'rider_302',
            name: 'Rohan Verma',
            email: 'rohan@example.com',
            phone: '+91 90000 44556',
            rating: 4.7,
          ),
          pickup: pickup,
          drop: locations[0],
          vehicleType: VehicleType.economy,
          fare: 356,
          distanceKm: 16.1,
          durationMinutes: 38,
          status: RideStatus.requested,
          requestedAt: DateTime.now().subtract(const Duration(minutes: 2)),
        ),
      ];

  static const earnings = EarningsModel(
    today: 1240,
    thisWeek: 6850,
    totalTrips: 34,
    onlineHours: 6.5,
    dailyEarnings: [820, 970, 760, 1120, 940, 1000, 1240],
  );
}
