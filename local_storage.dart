import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorage {
  static late SharedPreferences _preferences;
  static Box? _box;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
    await Hive.initFlutter();
    _box = await Hive.openBox('ride_hailing');
  }

  static Future<void> setString(String key, String value) async {
    await _preferences.setString(key, value);
  }

  static String? getString(String key) {
    return _preferences.getString(key);
  }

  static Future<void> setBool(String key, bool value) async {
    await _preferences.setBool(key, value);
  }

  static bool? getBool(String key) {
    return _preferences.getBool(key);
  }

  static Future<void> setInt(String key, int value) async {
    await _preferences.setInt(key, value);
  }

  static int? getInt(String key) {
    return _preferences.getInt(key);
  }

  static Future<void> setDouble(String key, double value) async {
    await _preferences.setDouble(key, value);
  }

  static double? getDouble(String key) {
    return _preferences.getDouble(key);
  }

  static Future<void> setList(String key, List<String> value) async {
    await _preferences.setStringList(key, value);
  }

  static List<String>? getList(String key) {
    return _preferences.getStringList(key);
  }

  static Future<void> remove(String key) async {
    await _preferences.remove(key);
  }

  static Future<void> clear() async {
    await _preferences.clear();
  }

  static Future<void> put(String key, dynamic value) async {
    await _box?.put(key, value);
  }

  static dynamic get(String key) {
    return _box?.get(key);
  }

  static Future<void> delete(String key) async {
    await _box?.delete(key);
  }
}