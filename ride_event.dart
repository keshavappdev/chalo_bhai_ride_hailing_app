part of 'ride_bloc.dart';

abstract class RideEvent extends Equatable {
  const RideEvent();

  @override
  List<Object?> get props => [];
}

class BookRideEvent extends RideEvent {
  final Location pickupLocation;
  final Location dropoffLocation;
  final RideType rideType;
  final DateTime? scheduledTime;
  final List<String>? specialRequests;

  const BookRideEvent({
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.rideType,
    this.scheduledTime,
    this.specialRequests,
  });

  @override
  List<Object?> get props => [
    pickupLocation,
    dropoffLocation,
    rideType,
    scheduledTime,
    specialRequests,
  ];
}

class EstimateFareEvent extends RideEvent {
  final Location pickupLocation;
  final Location dropoffLocation;
  final RideType rideType;

  const EstimateFareEvent({
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.rideType,
  });

  @override
  List<Object?> get props => [pickupLocation, dropoffLocation, rideType];
}

class SearchDriverEvent extends RideEvent {
  final Location location;
  final double radius;

  const SearchDriverEvent({
    required this.location,
    this.radius = 5.0,
  });

  @override
  List<Object?> get props => [location, radius];
}

class AcceptDriverEvent extends RideEvent {
  final String rideId;
  final String driverId;

  const AcceptDriverEvent({
    required this.rideId,
    required this.driverId,
  });

  @override
  List<Object?> get props => [rideId, driverId];
}

class TrackRideEvent extends RideEvent {
  final String rideId;

  const TrackRideEvent({required this.rideId});

  @override
  List<Object?> get props => [rideId];
}

class CancelRideEvent extends RideEvent {
  final String rideId;
  final String? reason;

  const CancelRideEvent({
    required this.rideId,
    this.reason,
  });

  @override
  List<Object?> get props => [rideId, reason];
}

class GetRideHistoryEvent extends RideEvent {
  final String userId;
  final int limit;

  const GetRideHistoryEvent({
    required this.userId,
    this.limit = 20,
  });

  @override
  List<Object?> get props => [userId, limit];
}

class RateRideEvent extends RideEvent {
  final String rideId;
  final double rating;
  final String? feedback;
  final bool isDriverRating;

  const RateRideEvent({
    required this.rideId,
    required this.rating,
    this.feedback,
    this.isDriverRating = false,
  });

  @override
  List<Object?> get props => [rideId, rating, feedback, isDriverRating];
}