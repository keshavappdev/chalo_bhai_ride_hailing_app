import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ride_hailing_app/data/models/user_model.dart';
import 'package:ride_hailing_app/data/models/driver_model.dart';
import 'package:ride_hailing_app/data/datasources/local/mock_data.dart';

class AuthRepository {
  static const String _userKey = 'user';
  static const String _driverKey = 'driver';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _isDriverKey = 'is_driver';

  Future<User> login(String email, String password, bool isDriver) async {
    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));

    if (isDriver) {
      final driver = MockData.getDriverByEmail(email);
      if (driver != null && password == 'password123') {
        await _saveDriver(driver);
        return User(
          id: driver.id,
          email: driver.email,
          fullName: driver.fullName,
          phoneNumber: driver.phoneNumber,
          profileImage: driver.profileImage,
          rating: driver.rating,
          totalRides: driver.totalRides,
          createdAt: driver.joinedDate,
          updatedAt: driver.joinedDate,
        );
      }
    } else {
      final user = MockData.getUserByEmail(email);
      if (user != null && password == 'password123') {
        await _saveUser(user);
        return user;
      }
    }

    throw Exception('Invalid email or password');
  }

  Future<User> signup(
      String email,
      String password,
      String fullName,
      String phoneNumber,
      bool isDriver,
      ) async {
    await Future.delayed(const Duration(seconds: 1));

    // Mock signup
    final user = User(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      email: email,
      fullName: fullName,
      phoneNumber: phoneNumber,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    await _saveUser(user);
    return user;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
    await prefs.remove(_driverKey);
    await prefs.setBool(_isLoggedInKey, false);
    await prefs.setBool(_isDriverKey, false);
  }

  Future<User?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool(_isLoggedInKey) ?? false;
    if (!isLoggedIn) return null;

    final isDriver = prefs.getBool(_isDriverKey) ?? false;
    if (isDriver) {
      final driverJson = prefs.getString(_driverKey);
      if (driverJson != null) {
        // Parse driver and convert to User
        final Map<String, dynamic> map = json.decode(driverJson);
        return User(
          id: map['id'],
          email: map['email'],
          fullName: map['fullName'],
          phoneNumber: map['phoneNumber'],
          profileImage: map['profileImage'],
          rating: map['rating']?.toDouble() ?? 0.0,
          totalRides: map['totalRides'] ?? 0,
          createdAt: DateTime.parse(map['joinedDate']),
          updatedAt: DateTime.parse(map['joinedDate']),
        );
      }
    } else {
      final userJson = prefs.getString(_userKey);
      if (userJson != null) {
        final Map<String, dynamic> map = json.decode(userJson);
        return User.fromJson(map);
      }
    }

    return null;
  }

  Future<void> _saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, json.encode(user.toJson()));
    await prefs.setBool(_isLoggedInKey, true);
    await prefs.setBool(_isDriverKey, false);
  }

  Future<void> _saveDriver(Driver driver) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_driverKey, json.encode(driver.toJson()));
    await prefs.setBool(_isLoggedInKey, true);
    await prefs.setBool(_isDriverKey, true);
  }
}

extension UserJson on User {
  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'fullName': fullName,
    'phoneNumber': phoneNumber,
    'profileImage': profileImage,
    'rating': rating,
    'totalRides': totalRides,
    'homeAddress': homeAddress,
    'workAddress': workAddress,
    'isPremium': isPremium,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    email: json['email'],
    fullName: json['fullName'],
    phoneNumber: json['phoneNumber'],
    profileImage: json['profileImage'],
    rating: json['rating']?.toDouble() ?? 0.0,
    totalRides: json['totalRides'] ?? 0,
    homeAddress: json['homeAddress'],
    workAddress: json['workAddress'],
    isPremium: json['isPremium'] ?? false,
    createdAt: DateTime.parse(json['createdAt']),
    updatedAt: DateTime.parse(json['updatedAt']),
  );
}

extension DriverJson on Driver {
  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'fullName': fullName,
    'phoneNumber': phoneNumber,
    'profileImage': profileImage,
    'rating': rating,
    'totalRides': totalRides,
    'totalEarnings': totalEarnings,
    'isOnline': isOnline,
    'isAvailable': isAvailable,
    'joinedDate': joinedDate.toIso8601String(),
    'acceptanceRate': acceptanceRate,
    'cancellationRate': cancellationRate,
    'driverRank': driverRank,
  };

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
    id: json['id'],
    email: json['email'],
    fullName: json['fullName'],
    phoneNumber: json['phoneNumber'],
    profileImage: json['profileImage'],
    rating: json['rating']?.toDouble() ?? 0.0,
    totalRides: json['totalRides'] ?? 0,
    totalEarnings: json['totalEarnings'] ?? 0,
    isOnline: json['isOnline'] ?? false,
    isAvailable: json['isAvailable'] ?? false,
    vehicle: MockData.getVehicleById(json['vehicleId'])!,
    joinedDate: DateTime.parse(json['joinedDate']),
    acceptanceRate: json['acceptanceRate']?.toDouble() ?? 0.0,
    cancellationRate: json['cancellationRate']?.toDouble() ?? 0.0,
    driverRank: json['driverRank'] ?? 0,
  );
}