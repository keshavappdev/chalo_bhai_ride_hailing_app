part of 'driver_bloc.dart';

abstract class DriverEvent extends Equatable {
  const DriverEvent();

  @override
  List<Object?> get props => [];
}

class LoadDriverEvent extends DriverEvent {
  final String driverId;

  const LoadDriverEvent({required this.driverId});

  @override
  List<Object?> get props => [driverId];
}

class UpdateDriverEvent extends DriverEvent {
  final Driver driver;

  const UpdateDriverEvent({required this.driver});

  @override
  List<Object?> get props => [driver];
}

class ToggleOnlineStatusEvent extends DriverEvent {
  final String driverId;
  final bool isOnline;

  const ToggleOnlineStatusEvent({
    required this.driverId,
    required this.isOnline,
  });

  @override
  List<Object?> get props => [driverId, isOnline];
}

class AcceptRideEvent extends DriverEvent {
  final String driverId;
  final String rideId;

  const AcceptRideEvent({
    required this.driverId,
    required this.rideId,
  });

  @override
  List<Object?> get props => [driverId, rideId];
}

class RejectRideEvent extends DriverEvent {
  final String driverId;
  final String rideId;

  const RejectRideEvent({
    required this.driverId,
    required this.rideId,
  });

  @override
  List<Object?> get props => [driverId, rideId];
}

class LoadDriverRidesEvent extends DriverEvent {
  final String driverId;

  const LoadDriverRidesEvent({required this.driverId});

  @override
  List<Object?> get props => [driverId];
}

class LoadEarningsEvent extends DriverEvent {
  final String driverId;

  const LoadEarningsEvent({required this.driverId});

  @override
  List<Object?> get props => [driverId];
}