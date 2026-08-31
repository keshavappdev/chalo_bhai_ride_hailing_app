import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants/app_constants.dart';
import '../services/storage_service.dart';
import 'api_endpoints.dart';
import 'api_exception.dart';

class ApiClient {
  ApiClient(this._storageService, {http.Client? client})
      : _client = client ?? http.Client();

  final StorageService _storageService;
  final http.Client _client;

  Future<Map<String, dynamic>> get(
    String endpoint, {
    Map<String, String>? queryParameters,
  }) async {
    final uri = Uri.parse('${ApiEndpoints.baseUrl}$endpoint')
        .replace(queryParameters: queryParameters);
    return _send(() => _client.get(uri, headers: _headers()));
  }

  Future<Map<String, dynamic>> post(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    final uri = Uri.parse('${ApiEndpoints.baseUrl}$endpoint');
    return _send(
      () => _client.post(uri, headers: _headers(), body: jsonEncode(body ?? {})),
    );
  }

  Future<Map<String, dynamic>> put(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    final uri = Uri.parse('${ApiEndpoints.baseUrl}$endpoint');
    return _send(
      () => _client.put(uri, headers: _headers(), body: jsonEncode(body ?? {})),
    );
  }

  Future<Map<String, dynamic>> delete(
    String endpoint, {
    Map<String, dynamic>? body,
  }) async {
    final uri = Uri.parse('${ApiEndpoints.baseUrl}$endpoint');
    return _send(
      () => _client.delete(
        uri,
        headers: _headers(),
        body: jsonEncode(body ?? {}),
      ),
    );
  }

  Map<String, String> _headers() {
    final token = _storageService.token;
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  Future<Map<String, dynamic>> _send(
    Future<http.Response> Function() request,
  ) async {
    try {
      final response = await request().timeout(AppConstants.apiTimeout);
      final decoded = response.body.isEmpty
          ? <String, dynamic>{}
          : jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return decoded;
      }

      throw ApiException(
        decoded['message']?.toString() ?? 'The server rejected this request.',
        statusCode: response.statusCode,
      );
    } on ApiException {
      rethrow;
    } on FormatException {
      throw const ApiException('The server returned an invalid response.');
    } on Exception {
      throw const ApiException(
        'Unable to connect. Check your internet connection and try again.',
      );
    }
  }

  void close() => _client.close();
}
