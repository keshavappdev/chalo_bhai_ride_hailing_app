import 'package:ride_hailing_app/data/models/user_model.dart';
import 'package:ride_hailing_app/data/models/driver_model.dart';
import 'package:ride_hailing_app/data/models/ride_model.dart';
import 'package:ride_hailing_app/data/models/location_model.dart';
import 'package:ride_hailing_app/data/models/vehicle_model.dart';

class MockData {
  static List<User> _users = [];
  static List<Driver> _drivers = [];
  static List<Ride> _rides = [];
  static List<Vehicle> _vehicles = [];

  static Future<void> init() async {
    await _initializeMockData();
  }

  static Future<void> _initializeMockData() async {
    // Create vehicles
    _vehicles = [
      Vehicle(
        id: 'v1',
        model: 'Camry',
        brand: 'Toyota',
        licensePlate: 'AB-123-C',
        color: 'White',
        year: 2022,
        vehicleType: 'Standard',
        capacity: 4,
        isActive: true,
      ),
      Vehicle(
        id: 'v2',
        model: 'S-Class',
        brand: 'Mercedes',
        licensePlate: 'CD-456-E',
        color: 'Black',
        year: 2023,
        vehicleType: 'Premium',
        capacity: 4,
        isActive: true,
      ),
      Vehicle(
        id: 'v3',
        model: 'Model S',
        brand: 'Tesla',
        licensePlate: 'EF-789-G',
        color: 'Red',
        year: 2023,
        vehicleType: 'Luxury',
        capacity: 4,
        isActive: true,
      ),
      Vehicle(
        id: 'v4',
        model: 'CR-V',
        brand: 'Honda',
        licensePlate: 'GH-012-H',
        color: 'Blue',
        year: 2022,
        vehicleType: 'SUV',
        capacity: 5,
        isActive: true,
      ),
    ];

    // Create drivers
    _drivers = [
      Driver(
        id: 'd1',
        email: 'driver@example.com',
        fullName: 'John Smith',
        phoneNumber: '+1234567890',
        rating: 4.8,
        totalRides: 156,
        totalEarnings: 12450,
        isOnline: true,
        isAvailable: true,
        vehicle: _vehicles[0],
        joinedDate: DateTime.now().subtract(const Duration(days: 180)),
        acceptanceRate: 0.95,
        cancellationRate: 0.05,
        driverRank: 1,
      ),
      Driver(
        id: 'd2',
        email: 'sarah@example.com',
        fullName: 'Sarah Johnson',
        phoneNumber: '+1234567891',
        rating: 4.9,
        totalRides: 203,
        totalEarnings: 18200,
        isOnline: true,
        isAvailable: true,
        vehicle: _vehicles[1],
        joinedDate: DateTime.now().subtract(const Duration(days: 200)),
        acceptanceRate: 0.97,
        cancellationRate: 0.03,
        driverRank: 2,
      ),
      Driver(
        id: 'd3',
        email: 'mike@example.com',
        fullName: 'Mike Wilson',
        phoneNumber: '+1234567892',
        rating: 4.7,
        totalRides: 98,
        totalEarnings: 8900,
        isOnline: true,
        isAvailable: true,
        vehicle: _vehicles[2],
        joinedDate: DateTime.now().subtract(const Duration(days: 120)),
        acceptanceRate: 0.92,
        cancellationRate: 0.08,
        driverRank: 3,
      ),
      Driver(
        id: 'd4',
        email: 'emma@example.com',
        fullName: 'Emma Davis',
        phoneNumber: '+1234567893',
        rating: 4.6,
        totalRides: 67,
        totalEarnings: 5600,
        isOnline: true,
        isAvailable: true,
        vehicle: _vehicles[3],
        joinedDate: DateTime.now().subtract(const Duration(days: 90)),
        acceptanceRate: 0.90,
        cancellationRate: 0.10,
        driverRank: 4,
      ),
    ];

    // Create users
    _users = [
      User(
        id: 'u1',
        email: 'user@example.com',
        fullName: 'John Doe',
        phoneNumber: '+9876543210',
        rating: 4.5,
        totalRides: 45,
        homeAddress: '123 Main Street, City Center',
        workAddress: '456 Business Park, Tech City',
        savedPlaces: ['Home', 'Work', 'Gym'],
        isPremium: false,
        createdAt: DateTime.now().subtract(const Duration(days: 300)),
        updatedAt: DateTime.now().subtract(const Duration(days: 30)),
      ),
      User(
        id: 'u2',
        email: 'jane@example.com',
        fullName: 'Jane Doe',
        phoneNumber: '+9876543211',
        rating: 4.8,
        totalRides: 78,
        homeAddress: '789 Park Avenue, Green City',
        workAddress: '321 Tech Park, Silicon Valley',
        savedPlaces: ['Home', 'Work', 'Gym', 'Mall'],
        isPremium: true,
        createdAt: DateTime.now().subtract(const Duration(days: 365)),
        updatedAt: DateTime.now().subtract(const Duration(days: 15)),
      ),
    ];

    // Create rides
    _rides = [
      Ride(
        id: 'r1',
        userId: 'u1',
        driverId: 'd1',
        pickupLocation: Location(
          id: 'loc1',
          address: '123 Main Street, City Center',
          latitude: 40.7128,
          longitude: -74.0060,
          name: 'Home',
        ),
        dropoffLocation: Location(
          id: 'loc2',
          address: '456 Business Park, Tech City',
          latitude: 40.7580,
          longitude: -73.9855,
          name: 'Work',
        ),
        scheduledTime: DateTime.now().subtract(const Duration(hours: 2)),
        status: RideStatus.completed,
        rideType: RideType.standard,
        estimatedFare: 170,
        actualFare: 170,
        distance: 12.5,
        duration: 25,
        driver: _drivers[0],
        vehicle: _vehicles[0],
        driverRating: 4.8,
        userRating: 4.5,
        isPaymentDone: true,
        paymentMethod: 'Visa',
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
        updatedAt: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      Ride(
        id: 'r2',
        userId: 'u1',
        driverId: 'd2',
        pickupLocation: Location(
          id: 'loc3',
          address: '456 Business Park, Tech City',
          latitude: 40.7580,
          longitude: -73.9855,
          name: 'Work',
        ),
        dropoffLocation: Location(
          id: 'loc4',
          address: '789 Park Avenue, Green City',
          latitude: 40.7610,
          longitude: -73.9775,
          name: 'Home',
        ),
        scheduledTime: DateTime.now().subtract(const Duration(days: 1)),
        status: RideStatus.completed,
        rideType: RideType.premium,
        estimatedFare: 280,
        actualFare: 280,
        distance: 8.0,
        duration: 18,
        driver: _drivers[1],
        vehicle: _vehicles[1],
        driverRating: 4.9,
        userRating: 5.0,
        isPaymentDone: true,
        paymentMethod: 'Mastercard',
        createdAt: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
        updatedAt: DateTime.now().subtract(const Duration(days: 1, hours: 1)),
      ),
      Ride(
        id: 'r3',
        userId: 'u2',
        driverId: 'd3',
        pickupLocation: Location(
          id: 'loc5',
          address: '789 Park Avenue, Green City',
          latitude: 40.7610,
          longitude: -73.9775,
          name: 'Home',
        ),
        dropoffLocation: Location(
          id: 'loc6',
          address: '321 Tech Park, Silicon Valley',
          latitude: 40.7500,
          longitude: -73.9950,
          name: 'Work',
        ),
        scheduledTime: DateTime.now().subtract(const Duration(days: 2)),
        status: RideStatus.cancelled,
        rideType: RideType.luxury,
        estimatedFare: 450,
        actualFare: null,
        cancellationReason: 'Rider cancelled',
        isPaymentDone: false,
        createdAt: DateTime.now().subtract(const Duration(days: 2, hours: 3)),
        updatedAt: DateTime.now().subtract(const Duration(days: 2, hours: 2)),
      ),
    ];
  }

  static User? getUserByEmail(String email) {
    return _users.firstWhere((u) => u.email == email, orElse: () => null as User);
  }

  static User? getUserById(String id) {
    return _users.firstWhere((u) => u.id == id, orElse: () => null as User);
  }

  static Driver? getDriverByEmail(String email) {
    return _drivers.firstWhere((d) => d.email == email, orElse: () => null as Driver);
  }

  static Driver? getDriverById(String id) {
    return _drivers.firstWhere((d) => d.id == id, orElse: () => null as Driver);
  }

  static List<Driver> getAvailableDrivers() {
    return _drivers.where((d) => d.isOnline && d.isAvailable).toList();
  }

  static Vehicle? getVehicleById(String id) {
    return _vehicles.firstWhere((v) => v.id == id, orElse: () => null as Vehicle);
  }

  static Ride? getRideById(String id) {
    return _rides.firstWhere((r) => r.id == id, orElse: () => null as Ride);
  }

  static List<Ride> getUserRides(String userId) {
    return _rides.where((r) => r.userId == userId).toList();
  }

  static List<Ride> getDriverRides(String driverId) {
    return _rides.where((r) => r.driverId == driverId).toList();
  }

  static Future<void> addRide(Ride ride) async {
    _rides.add(ride);
  }

  static Future<void> updateRide(Ride ride) async {
    final index = _rides.indexWhere((r) => r.id == ride.id);
    if (index != -1) {
      _rides[index] = ride;
    }
  }
}