import '../../core/api/api_client.dart';
import '../../core/api/api_endpoints.dart';
import '../../core/config/app_config.dart';
import '../../core/services/map_service.dart';
import '../mock/mock_data.dart';
import '../models/driver_model.dart';
import '../models/location_model.dart';
import '../models/ride_estimate_model.dart';
import '../models/ride_model.dart';
import '../models/user_model.dart';
import '../models/vehicle_model.dart';

class RideRepository {
  const RideRepository(this._apiClient, this._mapService);

  final ApiClient _apiClient;
  final MapService _mapService;

  // =====================================================
  // BACKEND API INTEGRATION POINT
  // FEATURE: Ride Fare Estimate
  // FILE: ride_repository.dart
  // METHOD: getRideEstimate()
  // TODO: Replace URL, method, body, token and response mapping.
  // =====================================================
  Future<RideEstimateModel> getRideEstimate({
    required LocationModel pickup,
    required LocationModel drop,
  }) async {
    if (AppConfig.useMockData) {
      await Future<void>.delayed(const Duration(milliseconds: 500));
      final distance = _mapService.calculateMockDistanceKm(pickup, drop);
      return RideEstimateModel(
        distanceKm: distance,
        durationMinutes: (distance * 2.4).round(),
        vehicleFares: {
          for (final vehicle in MockData.vehicles)
            vehicle.type: vehicle.baseFare + (distance * vehicle.perKmRate),
        },
      );
    }

    final requestBody = {
      'pickup_latitude': pickup.latitude,
      'pickup_longitude': pickup.longitude,
      'drop_latitude': drop.latitude,
      'drop_longitude': drop.longitude,
      // TODO: Replace parameters according to your API documentation.
    };
    final response = await _apiClient.post(
      ApiEndpoints.rideEstimate,
      body: requestBody,
    );
    return RideEstimateModel.fromJson(
      response['data'] as Map<String, dynamic>? ?? response,
    );
  }

  // =====================================================
  // BACKEND API INTEGRATION POINT
  // FEATURE: Ride Booking
  // FILE: ride_repository.dart
  // METHOD: bookRide()
  // TODO: Replace endpoint, request body and response mapping.
  // =====================================================
  Future<RideModel> bookRide({
    required UserModel rider,
    required LocationModel pickup,
    required LocationModel drop,
    required VehicleModel vehicle,
    required RideEstimateModel estimate,
  }) async {
    if (AppConfig.useMockData) {
      await Future<void>.delayed(const Duration(milliseconds: 700));
      return RideModel(
        id: 'ride_${DateTime.now().millisecondsSinceEpoch}',
        rider: rider,
        pickup: pickup,
        drop: drop,
        vehicleType: vehicle.type,
        fare: estimate.fareFor(vehicle.type),
        distanceKm: estimate.distanceKm,
        durationMinutes: estimate.durationMinutes,
        status: RideStatus.searchingDriver,
        requestedAt: DateTime.now(),
      );
    }

    final requestBody = {
      'pickup_latitude': pickup.latitude,
      'pickup_longitude': pickup.longitude,
      'drop_latitude': drop.latitude,
      'drop_longitude': drop.longitude,
      'vehicle_type': vehicle.type.name,
      // TODO: Add payment method, coupon and other backend parameters.
    };
    final response = await _apiClient.post(
      ApiEndpoints.bookRide,
      body: requestBody,
    );
    return RideModel.fromJson(
      response['data'] as Map<String, dynamic>? ?? response,
    );
  }

  // =====================================================
  // BACKEND API INTEGRATION POINT
  // FEATURE: Live Ride Status
  // FILE: ride_repository.dart
  // METHOD: getRideStatus()
  // TODO: Poll this endpoint or replace polling with WebSocket events.
  // =====================================================
  Future<RideModel> getRideStatus(RideModel currentRide) async {
    if (AppConfig.useMockData) return currentRide;
    final response = await _apiClient.get(
      ApiEndpoints.rideStatus(currentRide.id),
    );
    return RideModel.fromJson(
      response['data'] as Map<String, dynamic>? ?? response,
    );
  }

  // =====================================================
  // BACKEND API INTEGRATION POINT
  // FEATURE: Rider Ride History
  // FILE: ride_repository.dart
  // METHOD: getRideHistory()
  // TODO: Replace list key and pagination mapping for your API.
  // =====================================================
  Future<List<RideModel>> getRideHistory() async {
    if (AppConfig.useMockData) return MockData.riderHistory();
    final response = await _apiClient.get(ApiEndpoints.riderHistory);
    final items = response['data'] as List<dynamic>? ?? [];
    return items
        .map((item) => RideModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  // =====================================================
  // BACKEND API INTEGRATION POINT
  // FEATURE: Driver Accept/Reject Request
  // FILE: ride_repository.dart
  // METHODS: acceptRide(), rejectRide()
  // TODO: Map your backend's accepted ride payload.
  // =====================================================
  Future<RideModel> acceptRide(RideModel ride, DriverModel driver) async {
    if (AppConfig.useMockData) {
      await Future<void>.delayed(const Duration(milliseconds: 400));
      return ride.copyWith(driver: driver, status: RideStatus.driverAssigned);
    }
    final response = await _apiClient.post(ApiEndpoints.acceptRide(ride.id));
    return RideModel.fromJson(
      response['data'] as Map<String, dynamic>? ?? response,
    );
  }

  Future<void> rejectRide(String rideId) async {
    if (AppConfig.useMockData) return;
    await _apiClient.post(ApiEndpoints.rejectRide(rideId));
  }

  // =====================================================
  // BACKEND API INTEGRATION POINT
  // FEATURE: Driver Trip Lifecycle
  // FILE: ride_repository.dart
  // METHODS: markArrived(), startRide(), completeRide()
  // TODO: Replace the endpoints and response mapping if required.
  // =====================================================
  Future<RideModel> markArrived(RideModel ride) => _updateDriverRide(
        ride,
        ApiEndpoints.arrivedAtPickup(ride.id),
        RideStatus.driverArrived,
      );

  Future<RideModel> startRide(RideModel ride) => _updateDriverRide(
        ride,
        ApiEndpoints.startRide(ride.id),
        RideStatus.tripStarted,
      );

  Future<RideModel> completeRide(RideModel ride) => _updateDriverRide(
        ride,
        ApiEndpoints.completeRide(ride.id),
        RideStatus.tripCompleted,
      );

  Future<RideModel> _updateDriverRide(
    RideModel ride,
    String endpoint,
    RideStatus mockStatus,
  ) async {
    if (AppConfig.useMockData) {
      await Future<void>.delayed(const Duration(milliseconds: 350));
      return ride.copyWith(
        status: mockStatus,
        completedAt: mockStatus == RideStatus.tripCompleted
            ? DateTime.now()
            : null,
      );
    }
    final response = await _apiClient.post(endpoint);
    return RideModel.fromJson(
      response['data'] as Map<String, dynamic>? ?? response,
    );
  }

  // =====================================================
  // BACKEND API INTEGRATION POINT
  // FEATURE: Cancel and Rate Ride
  // FILE: ride_repository.dart
  // METHODS: cancelRide(), rateRide()
  // TODO: Match request bodies with your backend documentation.
  // =====================================================
  Future<RideModel> cancelRide(RideModel ride) async {
    if (AppConfig.useMockData) {
      return ride.copyWith(status: RideStatus.cancelled);
    }
    final response = await _apiClient.post(ApiEndpoints.cancelRide(ride.id));
    return RideModel.fromJson(
      response['data'] as Map<String, dynamic>? ?? response,
    );
  }

  Future<RideModel> rateRide(RideModel ride, double rating) async {
    if (AppConfig.useMockData) return ride.copyWith(rating: rating);
    final response = await _apiClient.post(
      ApiEndpoints.rateRide(ride.id),
      body: {'rating': rating},
    );
    return RideModel.fromJson(
      response['data'] as Map<String, dynamic>? ?? response,
    );
  }
}
