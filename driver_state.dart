part of 'driver_bloc.dart';

abstract class DriverState extends Equatable {
  const DriverState();

  @override
  List<Object?> get props => [];
}

class DriverInitial extends DriverState {}

class DriverLoading extends DriverState {}

class DriverLoaded extends DriverState {
  final Driver driver;

  const DriverLoaded({required this.driver});

  @override
  List<Object?> get props => [driver];
}

class RideAccepted extends DriverState {
  final Ride ride;

  const RideAccepted({required this.ride});

  @override
  List<Object?> get props => [ride];
}

class RideRejected extends DriverState {
  final Ride ride;

  const RideRejected({required this.ride});

  @override
  List<Object?> get props => [ride];
}

class DriverRidesLoaded extends DriverState {
  final List<Ride> rides;

  const DriverRidesLoaded({required this.rides});

  @override
  List<Object?> get props => [rides];
}

class EarningsLoaded extends DriverState {
  final Map<String, dynamic> earnings;

  const EarningsLoaded({required this.earnings});

  @override
  List<Object?> get props => [earnings];
}

class DriverError extends DriverState {
  final String message;

  const DriverError({required this.message});

  @override
  List<Object?> get props => [message];
}