import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ride_hailing_app/data/models/ride_model.dart';
import 'package:ride_hailing_app/data/models/location_model.dart';
import 'package:ride_hailing_app/data/repositories/ride_repository.dart';

part 'ride_event.dart';
part 'ride_state.dart';

class RideBloc extends Bloc<RideEvent, RideState> {
  final RideRepository _rideRepository;

  RideBloc({RideRepository? rideRepository})
      : _rideRepository = rideRepository ?? RideRepository(),
        super(RideInitial()) {
    on<BookRideEvent>(_onBookRide);
    on<EstimateFareEvent>(_onEstimateFare);
    on<SearchDriverEvent>(_onSearchDriver);
    on<AcceptDriverEvent>(_onAcceptDriver);
    on<TrackRideEvent>(_onTrackRide);
    on<CancelRideEvent>(_onCancelRide);
    on<GetRideHistoryEvent>(_onGetRideHistory);
    on<RateRideEvent>(_onRateRide);
  }

  Future<void> _onBookRide(BookRideEvent event, Emitter<RideState> emit) async {
    emit(RideLoading());
    try {
      final ride = await _rideRepository.bookRide(
        event.pickupLocation,
        event.dropoffLocation,
        event.rideType,
        event.scheduledTime,
        event.specialRequests,
      );
      emit(RideBooked(ride: ride));
    } catch (error) {
      emit(RideError(message: error.toString()));
    }
  }

  Future<void> _onEstimateFare(EstimateFareEvent event, Emitter<RideState> emit) async {
    emit(RideLoading());
    try {
      final fare = await _rideRepository.estimateFare(
        event.pickupLocation,
        event.dropoffLocation,
        event.rideType,
      );
      emit(FareEstimated(fare: fare));
    } catch (error) {
      emit(RideError(message: error.toString()));
    }
  }

  Future<void> _onSearchDriver(SearchDriverEvent event, Emitter<RideState> emit) async {
    emit(RideLoading());
    try {
      final drivers = await _rideRepository.searchNearbyDrivers(
        event.location,
        event.radius,
      );
      emit(DriversFound(drivers: drivers));
    } catch (error) {
      emit(RideError(message: error.toString()));
    }
  }

  Future<void> _onAcceptDriver(AcceptDriverEvent event, Emitter<RideState> emit) async {
    emit(RideLoading());
    try {
      final ride = await _rideRepository.assignDriver(
        event.rideId,
        event.driverId,
      );
      emit(DriverAssigned(ride: ride));
    } catch (error) {
      emit(RideError(message: error.toString()));
    }
  }

  Future<void> _onTrackRide(TrackRideEvent event, Emitter<RideState> emit) async {
    emit(RideLoading());
    try {
      final ride = await _rideRepository.trackRide(event.rideId);
      emit(RideTracking(ride: ride));
    } catch (error) {
      emit(RideError(message: error.toString()));
    }
  }

  Future<void> _onCancelRide(CancelRideEvent event, Emitter<RideState> emit) async {
    emit(RideLoading());
    try {
      final ride = await _rideRepository.cancelRide(
        event.rideId,
        event.reason,
      );
      emit(RideCancelled(ride: ride));
    } catch (error) {
      emit(RideError(message: error.toString()));
    }
  }

  Future<void> _onGetRideHistory(GetRideHistoryEvent event, Emitter<RideState> emit) async {
    emit(RideLoading());
    try {
      final rides = await _rideRepository.getRideHistory(
        event.userId,
        event.limit,
      );
      emit(RideHistoryLoaded(rides: rides));
    } catch (error) {
      emit(RideError(message: error.toString()));
    }
  }

  Future<void> _onRateRide(RateRideEvent event, Emitter<RideState> emit) async {
    emit(RideLoading());
    try {
      final ride = await _rideRepository.rateRide(
        event.rideId,
        event.rating,
        event.feedback,
        event.isDriverRating,
      );
      emit(RideRated(ride: ride));
    } catch (error) {
      emit(RideError(message: error.toString()));
    }
  }
}