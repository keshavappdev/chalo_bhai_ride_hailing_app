import '../../core/api/api_client.dart';
import '../../core/api/api_endpoints.dart';
import '../../core/config/app_config.dart';
import '../mock/mock_data.dart';
import '../models/driver_model.dart';
import '../models/user_model.dart';
import '../models/user_role.dart';

class AuthSession {
  const AuthSession({
    required this.token,
    required this.userId,
    this.rider,
    this.driver,
  });

  final String token;
  final String userId;
  final UserModel? rider;
  final DriverModel? driver;
}

class AuthRepository {
  const AuthRepository(this._apiClient);

  final ApiClient _apiClient;

  // =====================================================
  // BACKEND API INTEGRATION POINT
  // FEATURE: Rider/Driver Authentication
  // FILE: auth_repository.dart
  // METHOD: login()
  // TODO: Update endpoint, headers, body, token and response mapping.
  // =====================================================
  Future<AuthSession> login({
    required UserRole role,
    required String email,
    required String password,
  }) async {
    if (AppConfig.useMockData) {
      await Future<void>.delayed(const Duration(milliseconds: 700));
      return role == UserRole.rider
          ? const AuthSession(
              token: 'mock_rider_token',
              userId: 'rider_101',
              rider: MockData.rider,
            )
          : const AuthSession(
              token: 'mock_driver_token',
              userId: 'driver_201',
              driver: MockData.driver,
            );
    }

    final endpoint = role == UserRole.rider
        ? ApiEndpoints.riderLogin
        : ApiEndpoints.driverLogin;
    final requestBody = {
      'email': email,
      'password': password,
      // TODO: Replace parameters according to your API documentation.
    };
    final response = await _apiClient.post(endpoint, body: requestBody);
    final data = response['data'] as Map<String, dynamic>? ?? response;
    return AuthSession(
      token: data['token']?.toString() ?? '',
      userId: data['user_id']?.toString() ?? '',
      rider: role == UserRole.rider
          ? UserModel.fromJson(data['user'] as Map<String, dynamic>? ?? data)
          : null,
      driver: role == UserRole.driver
          ? DriverModel.fromJson(data['driver'] as Map<String, dynamic>? ?? data)
          : null,
    );
  }

  // =====================================================
  // BACKEND API INTEGRATION POINT
  // FEATURE: Rider/Driver Registration
  // FILE: auth_repository.dart
  // METHOD: register()
  // TODO: Update request body and response mapping for your backend.
  // =====================================================
  Future<AuthSession> register({
    required UserRole role,
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    if (AppConfig.useMockData) {
      return login(role: role, email: email, password: password);
    }

    final endpoint = role == UserRole.rider
        ? ApiEndpoints.riderRegister
        : ApiEndpoints.driverRegister;
    final response = await _apiClient.post(
      endpoint,
      body: {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        // TODO: Add role-specific registration fields here.
      },
    );
    final data = response['data'] as Map<String, dynamic>? ?? response;
    return AuthSession(
      token: data['token']?.toString() ?? '',
      userId: data['user_id']?.toString() ?? '',
      rider: role == UserRole.rider
          ? UserModel.fromJson(data['user'] as Map<String, dynamic>? ?? data)
          : null,
      driver: role == UserRole.driver
          ? DriverModel.fromJson(data['driver'] as Map<String, dynamic>? ?? data)
          : null,
    );
  }
}
