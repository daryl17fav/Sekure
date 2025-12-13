import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api_config.dart';
/// API Service for communicating with Next.js backend
class ApiService extends GetxService {
  // Get base URL from config
  String get baseUrl => ApiConfig.baseUrl;

  // Default timeout duration
  final Duration timeout = const Duration(seconds: 30);

  // HTTP headers
  Future<Map<String, String>> get _headers async {
    final headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    // Add authorization token if available
    final token = await _getToken();
    if (token != null) {
      headers["Authorization"] = "Bearer $token";
    }

    return headers;
  }

  /// Get stored authentication token
  Future<String?> _getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('auth_token');
    } catch (e) {
      return null;
    }
  }

  /// Generic GET request
  Future<Map<String, dynamic>> get(String endpoint, {Map<String, String>? queryParams}) async {
    try {
      final uri = Uri.parse('$baseUrl/$endpoint').replace(queryParameters: queryParams);
      final headers = await _headers;

      final response = await http.get(
        uri,
        headers: headers,
      ).timeout(timeout);

      return _handleResponse(response);
    } on SocketException {
      throw ApiException('No internet connection. Please check your network.');
    } on TimeoutException {
      throw ApiException('Request timeout. Please try again.');
    } catch (e) {
      throw ApiException('An error occurred: ${e.toString()}');
    }
  }

  /// Generic POST request
  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> body) async {
    try {
      final url = Uri.parse('$baseUrl/$endpoint');
      final headers = await _headers;

      final response = await http.post(
        url,
        headers: headers,
        body: jsonEncode(body),
      ).timeout(timeout);

      return _handleResponse(response);
    } on SocketException {
      throw ApiException('No internet connection. Please check your network.');
    } on TimeoutException {
      throw ApiException('Request timeout. Please try again.');
    } catch (e) {
      throw ApiException('An error occurred: ${e.toString()}');
    }
  }

  /// Generic PUT request
  Future<Map<String, dynamic>> put(String endpoint, Map<String, dynamic> body) async {
    try {
      final url = Uri.parse('$baseUrl/$endpoint');
      final headers = await _headers;

      final response = await http.put(
        url,
        headers: headers,
        body: jsonEncode(body),
      ).timeout(timeout);

      return _handleResponse(response);
    } on SocketException {
      throw ApiException('No internet connection. Please check your network.');
    } on TimeoutException {
      throw ApiException('Request timeout. Please try again.');
    } catch (e) {
      throw ApiException('An error occurred: ${e.toString()}');
    }
  }

  /// Generic PATCH request
  Future<Map<String, dynamic>> patch(String endpoint, Map<String, dynamic> body) async {
    try {
      final url = Uri.parse('$baseUrl/$endpoint');
      final headers = await _headers;

      final response = await http.patch(
        url,
        headers: headers,
        body: jsonEncode(body),
      ).timeout(timeout);

      return _handleResponse(response);
    } on SocketException {
      throw ApiException('No internet connection. Please check your network.');
    } on TimeoutException {
      throw ApiException('Request timeout. Please try again.');
    } catch (e) {
      throw ApiException('An error occurred: ${e.toString()}');
    }
  }

  /// Generic DELETE request
  Future<Map<String, dynamic>> delete(String endpoint) async {
    try {
      final url = Uri.parse('$baseUrl/$endpoint');
      final headers = await _headers;

      final response = await http.delete(
        url,
        headers: headers,
      ).timeout(timeout);

      return _handleResponse(response);
    } on SocketException {
      throw ApiException('No internet connection. Please check your network.');
    } on TimeoutException {
      throw ApiException('Request timeout. Please try again.');
    } catch (e) {
      throw ApiException('An error occurred: ${e.toString()}');
    }
  }

  /// Handle HTTP response
  Map<String, dynamic> _handleResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        // Success
        return jsonDecode(response.body);
      case 400:
        // Bad Request
        throw ApiException('Bad request: ${_getErrorMessage(response)}');
      case 401:
        // Unauthorized
        throw ApiException('Unauthorized. Please login again.');
      case 403:
        // Forbidden
        throw ApiException('Access forbidden.');
      case 404:
        // Not Found
        throw ApiException('Resource not found.');
      case 422:
        // Validation Error
        throw ApiException('Validation error: ${_getErrorMessage(response)}');
      case 500:
        // Server Error
        throw ApiException('Server error. Please try again later.');
      default:
        throw ApiException('Error ${response.statusCode}: ${response.body}');
    }
  }

  /// Extract error message from response
  String _getErrorMessage(http.Response response) {
    try {
      final body = jsonDecode(response.body);
      return body['message'] ?? body['error'] ?? response.body;
    } catch (e) {
      return response.body;
    }
  }
}

/// Custom API Exception
class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  @override
  String toString() => message;
}
