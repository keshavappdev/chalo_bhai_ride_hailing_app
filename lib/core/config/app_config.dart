import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract final class AppConfig {
  // true = Mock Data
  // false = Real Backend APIs
  static bool get useMockData =>
      (dotenv.env['USE_MOCK_DATA'] ?? 'true').toLowerCase() == 'true';

  static String get baseUrl =>
      dotenv.env['BASE_URL'] ?? 'https://YOUR_BACKEND_URL/api';

  static bool get firebaseEnabled =>
      (dotenv.env['FIREBASE_ENABLED'] ?? 'false').toLowerCase() == 'true';
}
