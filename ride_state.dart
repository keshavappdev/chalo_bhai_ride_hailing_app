part of 'ride_bloc.dart';

abstract class RideState extends Equatable {
  const RideState();

  @override
  List<Object?> get props => [];
}

class RideInitial extends RideState {}

class RideLoading extends RideState {}

class RideBooked extends RideState {
  final Ride ride;

  const RideBooked({required this.ride});

  @override
  List<Object?> get props => [ride];
}

class FareEstimated extends RideState {
  final double fare;

  const FareEstimated({required this.fare});

  @override
  List<Object?> get props => [fare];
}

class DriversFound extends RideState {
  final List<Driver> drivers;

  const DriversFound({required this.drivers});

  @override
  List<Object?> get props => [drivers];
}

class DriverAssigned extends RideState {
  final Ride ride;

  const DriverAssigned({required this.ride});

  @override
  List<Object?> get props => [ride];
}

class RideTracking extends RideState {
  final Ride ride;

  const RideTracking({required this.ride});

  @override
  List<Object?> get props => [ride];
}

class RideCancelled extends RideState {
  final Ride ride;

  const RideCancelled({required this.ride});

  @override
  List<Object?> get props => [ride];
}

class RideHistoryLoaded extends RideState {
  final List<Ride> rides;

  const RideHistoryLoaded({required this.rides});

  @override
  List<Object?> get props => [rides];
}

class RideRated extends RideState {
  final Ride ride;

  const RideRated({required this.ride});

  @override
  List<Object?> get props => [ride];
}

class RideError extends RideState {
  final String message;

  const RideError({required this.message});

  @override
  List<Object?> get props => [message];
}