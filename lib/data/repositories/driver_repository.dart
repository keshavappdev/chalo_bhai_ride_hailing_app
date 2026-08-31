import '../../core/api/api_client.dart';
import '../../core/api/api_endpoints.dart';
import '../../core/config/app_config.dart';
import '../mock/mock_data.dart';
import '../models/earnings_model.dart';
import '../models/location_model.dart';
import '../models/ride_model.dart';

class DriverRepository {
  const DriverRepository(this._apiClient);

  final ApiClient _apiClient;

  // =====================================================
  // BACKEND API INTEGRATION POINT
  // FEATURE: Driver Online/Offline Status
  // FILE: driver_repository.dart
  // METHOD: updateStatus()
  // TODO: Replace status values and response handling for your backend.
  // =====================================================
  Future<void> updateStatus(bool isOnline) async {
    if (AppConfig.useMockData) {
      await Future<void>.delayed(const Duration(milliseconds: 250));
      return;
    }
    await _apiClient.post(
      ApiEndpoints.driverStatus,
      body: {'is_online': isOnline},
    );
  }

  // =====================================================
  // BACKEND API INTEGRATION POINT
  // FEATURE: Driver Live Location
  // FILE: driver_repository.dart
  // METHOD: updateLocation()
  // TODO: Add heading, speed and accuracy if your backend expects them.
  // =====================================================
  Future<void> updateLocation(LocationModel location) async {
    if (AppConfig.useMockData) return;
    await _apiClient.post(
      ApiEndpoints.updateDriverLocation,
      body: {
        'latitude': location.latitude,
        'longitude': location.longitude,
      },
    );
  }

  // =====================================================
  // BACKEND API INTEGRATION POINT
  // FEATURE: Incoming Ride Requests
  // FILE: driver_repository.dart
  // METHOD: getRideRequests()
  // TODO: Replace polling with WebSocket/FCM when your backend supports it.
  // =====================================================
  Future<List<RideModel>> getRideRequests() async {
    if (AppConfig.useMockData) {
      await Future<void>.delayed(const Duration(milliseconds: 450));
      return MockData.rideRequests();
    }
    final response = await _apiClient.get(ApiEndpoints.rideRequests);
    final items = response['data'] as List<dynamic>? ?? [];
    return items
        .map((item) => RideModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  // =====================================================
  // BACKEND API INTEGRATION POINT
  // FEATURE: Driver Earnings
  // FILE: driver_repository.dart
  // METHOD: getEarnings()
  // TODO: Update the earnings model mapping for your response.
  // =====================================================
  Future<EarningsModel> getEarnings() async {
    if (AppConfig.useMockData) return MockData.earnings;
    final response = await _apiClient.get(ApiEndpoints.driverEarnings);
    return EarningsModel.fromJson(
      response['data'] as Map<String, dynamic>? ?? response,
    );
  }

  // =====================================================
  // BACKEND API INTEGRATION POINT
  // FEATURE: Driver Trip History
  // FILE: driver_repository.dart
  // METHOD: getTripHistory()
  // TODO: Map pagination and the driver-specific trip list.
  // =====================================================
  Future<List<RideModel>> getTripHistory() async {
    if (AppConfig.useMockData) return MockData.riderHistory();
    final response = await _apiClient.get(ApiEndpoints.driverHistory);
    final items = response['data'] as List<dynamic>? ?? [];
    return items
        .map((item) => RideModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
