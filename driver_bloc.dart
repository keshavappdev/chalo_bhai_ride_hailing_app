import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ride_hailing_app/data/models/driver_model.dart';
import 'package:ride_hailing_app/data/models/ride_model.dart';
import 'package:ride_hailing_app/data/repositories/driver_repository.dart';

part 'driver_event.dart';
part 'driver_state.dart';

class DriverBloc extends Bloc<DriverEvent, DriverState> {
  final DriverRepository _driverRepository;

  DriverBloc({DriverRepository? driverRepository})
      : _driverRepository = driverRepository ?? DriverRepository(),
        super(DriverInitial()) {
    on<LoadDriverEvent>(_onLoadDriver);
    on<UpdateDriverEvent>(_onUpdateDriver);
    on<ToggleOnlineStatusEvent>(_onToggleOnlineStatus);
    on<AcceptRideEvent>(_onAcceptRide);
    on<RejectRideEvent>(_onRejectRide);
    on<LoadDriverRidesEvent>(_onLoadDriverRides);
    on<LoadEarningsEvent>(_onLoadEarnings);
  }

  Future<void> _onLoadDriver(LoadDriverEvent event, Emitter<DriverState> emit) async {
    emit(DriverLoading());
    try {
      final driver = await _driverRepository.getDriver(event.driverId);
      emit(DriverLoaded(driver: driver));
    } catch (error) {
      emit(DriverError(message: error.toString()));
    }
  }

  Future<void> _onUpdateDriver(
      UpdateDriverEvent event,
      Emitter<DriverState> emit,
      ) async {
    emit(DriverLoading());
    try {
      final driver = await _driverRepository.updateDriver(event.driver);
      emit(DriverLoaded(driver: driver));
    } catch (error) {
      emit(DriverError(message: error.toString()));
    }
  }

  Future<void> _onToggleOnlineStatus(
      ToggleOnlineStatusEvent event,
      Emitter<DriverState> emit,
      ) async {
    emit(DriverLoading());
    try {
      final driver = await _driverRepository.setOnlineStatus(
        event.driverId,
        event.isOnline,
      );
      emit(DriverLoaded(driver: driver));
    } catch (error) {
      emit(DriverError(message: error.toString()));
    }
  }

  Future<void> _onAcceptRide(AcceptRideEvent event, Emitter<DriverState> emit) async {
    emit(DriverLoading());
    try {
      final ride = await _driverRepository.acceptRide(
        event.driverId,
        event.rideId,
      );
      emit(RideAccepted(ride: ride));
    } catch (error) {
      emit(DriverError(message: error.toString()));
    }
  }

  Future<void> _onRejectRide(RejectRideEvent event, Emitter<DriverState> emit) async {
    emit(DriverLoading());
    try {
      final ride = await _driverRepository.rejectRide(
        event.driverId,
        event.rideId,
      );
      emit(RideRejected(ride: ride));
    } catch (error) {
      emit(DriverError(message: error.toString()));
    }
  }

  Future<void> _onLoadDriverRides(
      LoadDriverRidesEvent event,
      Emitter<DriverState> emit,
      ) async {
    emit(DriverLoading());
    try {
      final rides = await _driverRepository.getDriverRides(event.driverId);
      emit(DriverRidesLoaded(rides: rides));
    } catch (error) {
      emit(DriverError(message: error.toString()));
    }
  }

  Future<void> _onLoadEarnings(
      LoadEarningsEvent event,
      Emitter<DriverState> emit,
      ) async {
    emit(DriverLoading());
    try {
      final earnings = await _driverRepository.getEarnings(event.driverId);
      emit(EarningsLoaded(earnings: earnings));
    } catch (error) {
      emit(DriverError(message: error.toString()));
    }
  }
}