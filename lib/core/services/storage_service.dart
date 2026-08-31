import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/user_role.dart';

class StorageService extends GetxService {
  static const _tokenKey = 'auth_token';
  static const _roleKey = 'user_role';
  static const _userIdKey = 'user_id';
  static const _loggedInKey = 'is_logged_in';

  late final SharedPreferences _preferences;

  Future<StorageService> init() async {
    _preferences = await SharedPreferences.getInstance();
    return this;
  }

  String? get token => _preferences.getString(_tokenKey);
  String? get userId => _preferences.getString(_userIdKey);
  bool get isLoggedIn => _preferences.getBool(_loggedInKey) ?? false;

  UserRole? get userRole {
    final value = _preferences.getString(_roleKey);
    return UserRole.fromStorage(value);
  }

  Future<void> saveToken(String token) =>
      _preferences.setString(_tokenKey, token);

  Future<void> saveUserRole(UserRole role) =>
      _preferences.setString(_roleKey, role.name);

  Future<void> saveUserId(String userId) =>
      _preferences.setString(_userIdKey, userId);

  Future<void> saveLoginStatus(bool value) =>
      _preferences.setBool(_loggedInKey, value);

  Future<void> saveSession({
    required String token,
    required String userId,
    required UserRole role,
  }) async {
    await saveToken(token);
    await saveUserId(userId);
    await saveUserRole(role);
    await saveLoginStatus(true);
  }

  Future<void> clearSession() async {
    await Future.wait([
      _preferences.remove(_tokenKey),
      _preferences.remove(_userIdKey),
      _preferences.remove(_loggedInKey),
    ]);
  }
}
