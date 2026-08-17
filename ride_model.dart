import 'package:equatable/equatable.dart';
import 'location_model.dart';

enum RideStatus {
  searching,
  assigned,
  arrived,
  started,
  completed,
  cancelled,
}

enum RideType {
  standard,
  premium,
  luxury,
  shared,
  pet,
  wheelchair,
}

class Ride extends Equatable {
  final String id;
  final String userId;
  final String? driverId;
  final Location pickupLocation;
  final Location dropoffLocation;
  final DateTime scheduledTime;
  final RideStatus status;
  final RideType rideType;
  final double estimatedFare;
  final double? actualFare;
  final double? distance;
  final double? duration;
  final int? estimatedArrivalMinutes;
  final int? actualArrivalMinutes;
  final Vehicle? vehicle;
  final Driver? driver;
  final double? driverRating;
  final double? userRating;
  final String? driverFeedback;
  final String? userFeedback;
  final List<String>? specialRequests;
  final bool isScheduled;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final DateTime? cancelledAt;
  final String? cancellationReason;
  final bool isPaymentDone;
  final String? paymentMethod;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Ride({
    required this.id,
    required this.userId,
    this.driverId,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.scheduledTime,
    required this.status,
    required this.rideType,
    required this.estimatedFare,
    this.actualFare,
    this.distance,
    this.duration,
    this.estimatedArrivalMinutes,
    this.actualArrivalMinutes,
    this.vehicle,
    this.driver,
    this.driverRating,
    this.userRating,
    this.driverFeedback,
    this.userFeedback,
    this.specialRequests,
    this.isScheduled = false,
    this.startedAt,
    this.completedAt,
    this.cancelledAt,
    this.cancellationReason,
    this.isPaymentDone = false,
    this.paymentMethod,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Ride.empty() {
    return const Ride(
      id: '',
      userId: '',
      pickupLocation: null,
      dropoffLocation: null,
      scheduledTime: null,
      status: RideStatus.searching,
      rideType: RideType.standard,
      estimatedFare: 0,
      createdAt: null,
      updatedAt: null,
    );
  }

  Ride copyWith({
    String? id,
    String? userId,
    String? driverId,
    Location? pickupLocation,
    Location? dropoffLocation,
    DateTime? scheduledTime,
    RideStatus? status,
    RideType? rideType,
    double? estimatedFare,
    double? actualFare,
    double? distance,
    double? duration,
    int? estimatedArrivalMinutes,
    int? actualArrivalMinutes,
    Vehicle? vehicle,
    Driver? driver,
    double? driverRating,
    double? userRating,
    String? driverFeedback,
    String? userFeedback,
    List<String>? specialRequests,
    bool? isScheduled,
    DateTime? startedAt,
    DateTime? completedAt,
    DateTime? cancelledAt,
    String? cancellationReason,
    bool? isPaymentDone,
    String? paymentMethod,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Ride(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      driverId: driverId ?? this.driverId,
      pickupLocation: pickupLocation ?? this.pickupLocation,
      dropoffLocation: dropoffLocation ?? this.dropoffLocation,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      status: status ?? this.status,
      rideType: rideType ?? this.rideType,
      estimatedFare: estimatedFare ?? this.estimatedFare,
      actualFare: actualFare ?? this.actualFare,
      distance: distance ?? this.distance,
      duration: duration ?? this.duration,
      estimatedArrivalMinutes: estimatedArrivalMinutes ?? this.estimatedArrivalMinutes,
      actualArrivalMinutes: actualArrivalMinutes ?? this.actualArrivalMinutes,
      vehicle: vehicle ?? this.vehicle,
      driver: driver ?? this.driver,
      driverRating: driverRating ?? this.driverRating,
      userRating: userRating ?? this.userRating,
      driverFeedback: driverFeedback ?? this.driverFeedback,
      userFeedback: userFeedback ?? this.userFeedback,
      specialRequests: specialRequests ?? this.specialRequests,
      isScheduled: isScheduled ?? this.isScheduled,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      cancelledAt: cancelledAt ?? this.cancelledAt,
      cancellationReason: cancellationReason ?? this.cancellationReason,
      isPaymentDone: isPaymentDone ?? this.isPaymentDone,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  String get statusDisplay {
    switch (status) {
      case RideStatus.searching:
        return 'Searching for driver';
      case RideStatus.assigned:
        return 'Driver assigned';
      case RideStatus.arrived:
        return 'Driver arrived';
      case RideStatus.started:
        return 'Ride started';
      case RideStatus.completed:
        return 'Completed';
      case RideStatus.cancelled:
        return 'Cancelled';
    }
  }

  @override
  List<Object?> get props => [
    id,
    userId,
    driverId,
    pickupLocation,
    dropoffLocation,
    scheduledTime,
    status,
    rideType,
    estimatedFare,
    actualFare,
    distance,
    duration,
    estimatedArrivalMinutes,
    actualArrivalMinutes,
    vehicle,
    driver,
    driverRating,
    userRating,
    driverFeedback,
    userFeedback,
    specialRequests,
    isScheduled,
    startedAt,
    completedAt,
    cancelledAt,
    cancellationReason,
    isPaymentDone,
    paymentMethod,
    createdAt,
    updatedAt,
  ];
}