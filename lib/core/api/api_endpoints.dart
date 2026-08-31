import '../config/app_config.dart';

abstract final class ApiEndpoints {
  // =====================================================
  // BACKEND API CONFIGURATION
  // =====================================================
  // TODO: Replace with your existing backend base URL in .env.
  static String get baseUrl => AppConfig.baseUrl;

  // Authentication
  static const String riderLogin = '/rider/login';
  static const String driverLogin = '/driver/login';
  static const String riderRegister = '/rider/register';
  static const String driverRegister = '/driver/register';

  // Rider
  static const String rideEstimate = '/rides/estimate';
  static const String bookRide = '/rides/book';
  static const String riderHistory = '/rider/history';
  static String rideStatus(String rideId) => '/rides/$rideId/status';
  static String cancelRide(String rideId) => '/rides/$rideId/cancel';
  static String rateRide(String rideId) => '/rides/$rideId/rate';

  // Driver
  static const String driverStatus = '/driver/status';
  static const String updateDriverLocation = '/driver/location/update';
  static const String rideRequests = '/driver/ride-requests';
  static const String driverEarnings = '/driver/earnings';
  static const String driverHistory = '/driver/history';
  static String acceptRide(String rideId) => '/rides/$rideId/accept';
  static String rejectRide(String rideId) => '/rides/$rideId/reject';
  static String arrivedAtPickup(String rideId) => '/rides/$rideId/arrived';
  static String startRide(String rideId) => '/rides/$rideId/start';
  static String completeRide(String rideId) => '/rides/$rideId/complete';
}
