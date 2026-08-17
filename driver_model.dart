import 'package:equatable/equatable.dart';

class Driver extends Equatable {
  final String id;
  final String email;
  final String fullName;
  final String phoneNumber;
  final String? profileImage;
  final double rating;
  final int totalRides;
  final int totalEarnings;
  final bool isOnline;
  final bool isAvailable;
  final Vehicle vehicle;
  final Location? currentLocation;
  final List<Ride> completedRides;
  final List<Ride> currentRide;
  final DateTime joinedDate;
  final double acceptanceRate;
  final double cancellationRate;
  final int driverRank;

  const Driver({
    required this.id,
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    this.profileImage,
    this.rating = 0.0,
    this.totalRides = 0,
    this.totalEarnings = 0,
    this.isOnline = false,
    this.isAvailable = false,
    required this.vehicle,
    this.currentLocation,
    this.completedRides = const [],
    this.currentRide = const [],
    required this.joinedDate,
    this.acceptanceRate = 0.0,
    this.cancellationRate = 0.0,
    this.driverRank = 0,
  });

  factory Driver.empty() {
    return const Driver(
      id: '',
      email: '',
      fullName: '',
      phoneNumber: '',
      vehicle: null,
      joinedDate: null,
    );
  }

  Driver copyWith({
    String? id,
    String? email,
    String? fullName,
    String? phoneNumber,
    String? profileImage,
    double? rating,
    int? totalRides,
    int? totalEarnings,
    bool? isOnline,
    bool? isAvailable,
    Vehicle? vehicle,
    Location? currentLocation,
    List<Ride>? completedRides,
    List<Ride>? currentRide,
    DateTime? joinedDate,
    double? acceptanceRate,
    double? cancellationRate,
    int? driverRank,
  }) {
    return Driver(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImage: profileImage ?? this.profileImage,
      rating: rating ?? this.rating,
      totalRides: totalRides ?? this.totalRides,
      totalEarnings: totalEarnings ?? this.totalEarnings,
      isOnline: isOnline ?? this.isOnline,
      isAvailable: isAvailable ?? this.isAvailable,
      vehicle: vehicle ?? this.vehicle,
      currentLocation: currentLocation ?? this.currentLocation,
      completedRides: completedRides ?? this.completedRides,
      currentRide: currentRide ?? this.currentRide,
      joinedDate: joinedDate ?? this.joinedDate,
      acceptanceRate: acceptanceRate ?? this.acceptanceRate,
      cancellationRate: cancellationRate ?? this.cancellationRate,
      driverRank: driverRank ?? this.driverRank,
    );
  }

  @override
  List<Object?> get props => [
    id,
    email,
    fullName,
    phoneNumber,
    profileImage,
    rating,
    totalRides,
    totalEarnings,
    isOnline,
    isAvailable,
    vehicle,
    currentLocation,
    completedRides,
    currentRide,
    joinedDate,
    acceptanceRate,
    cancellationRate,
    driverRank,
  ];
}

class Vehicle extends Equatable {
  final String id;
  final String model;
  final String brand;
  final String licensePlate;
  final String color;
  final int year;
  final String vehicleType;
  final int capacity;
  final String? imageUrl;
  final bool isActive;

  const Vehicle({
    required this.id,
    required this.model,
    required this.brand,
    required this.licensePlate,
    required this.color,
    required this.year,
    required this.vehicleType,
    this.capacity = 4,
    this.imageUrl,
    this.isActive = true,
  });

  String get fullName => '$brand $model';

  @override
  List<Object?> get props => [
    id,
    model,
    brand,
    licensePlate,
    color,
    year,
    vehicleType,
    capacity,
    imageUrl,
    isActive,
  ];
}