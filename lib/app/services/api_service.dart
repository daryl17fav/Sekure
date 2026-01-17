import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:get/get.dart' hide Response;
import 'package:path_provider/path_provider.dart';
import '../config/api_config.dart';

/// API Service using Dio with Cookie Support for Next.js Backend
class ApiService extends GetxService {
  late Dio _dio;
  late PersistCookieJar _cookieJar;

  // Get base URL from config
  String get baseUrl => ApiConfig.baseUrl;

  /// Async Initialization
  Future<ApiService> init() async {
    await _initDio();
    return this;
  }

  @override
  void onInit() {
    super.onInit();
    // Initialization is handled via init() called from ServiceInitializer
  }

  Future<void> _initDio() async {
    // 1. Setup Cookie Jar
    final appDocDir = await getApplicationDocumentsDirectory();
    final cookiePath = '${appDocDir.path}/.cookies/';
    _cookieJar = PersistCookieJar(storage: FileStorage(cookiePath));

    // 2. Setup Dio Options
    final options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 60), // Reasonable connection timeout
      receiveTimeout: const Duration(seconds: 300), // 5 minutes for cold starts
      sendTimeout: const Duration(seconds: 60), // Reasonable send timeout
      contentType: 'application/json',
      responseType: ResponseType.json,
      validateStatus: (status) {
        return status != null && status < 500; // Let us handle 4xx errors
      },
    );

    _dio = Dio(options);

    // 3. Add Interceptors
    _dio.interceptors.add(CookieManager(_cookieJar));
    
    // Logging Interceptor (Optional, helpful for debug)
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (obj) => print('API LOG: $obj'),
    ));
  }

  /// Clear cookies (Logout)
  Future<void> clearCookies() async {
    await _cookieJar.deleteAll();
  }

  /// Ensure Dio is initialized before requests
  Future<void> _ensureInitialized() async {
     // No-op if init() is dealt with correctly
  }

  /// Generic GET request
  Future<dynamic> get(String endpoint, {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParams,
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ApiException('An unexpected error occurred: $e');
    }
  }

  /// Generic POST request
  Future<dynamic> post(String endpoint, dynamic data) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ApiException('An unexpected error occurred: $e');
    }
  }

  /// Generic PUT request
  Future<dynamic> put(String endpoint, dynamic data) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: data,
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ApiException('An unexpected error occurred: $e');
    }
  }

  /// Generic PATCH request
  Future<dynamic> patch(String endpoint, dynamic data) async {
    try {
      final response = await _dio.patch(
        endpoint,
        data: data,
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ApiException('An unexpected error occurred: $e');
    }
  }

  /// Generic DELETE request
  Future<dynamic> delete(String endpoint) async {
    try {
      final response = await _dio.delete(endpoint);
      return _handleResponse(response);
    } on DioException catch (e) {
      throw _handleDioError(e);
    } catch (e) {
      throw ApiException('An unexpected error occurred: $e');
    }
  }

  /// Handle API Response
  dynamic _handleResponse(Response response) {
    final statusCode = response.statusCode ?? 0;
    
    if (statusCode >= 200 && statusCode < 300) {
      return response.data;
    } else {
      // Handle Error Responses based on status
      final message = _extractErrorMessage(response.data);
      
      switch (statusCode) {
        case 400:
          throw ApiException(message);
        case 401:
          throw ApiException('Unauthorized: $message');
        case 403:
          throw ApiException('Forbidden: $message');
        case 404:
          throw ApiException('Not Found: $message');
        case 409:
          throw ApiException(message);
        case 422:
          throw ApiException('Validation Error: $message');
        case 429:
           throw ApiException(message);
        case 500:
          throw ApiException('Server Error. Please try again later.');
        default:
          throw ApiException('Error $statusCode: $message');
      }
    }
  }

  /// Handle Dio Errors (Network, Timeout, etc)
  ApiException _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException('Connection timed out. Please check your internet.');
      case DioExceptionType.badResponse:
         // This typically goes to _handleResponse if validateStatus allows it, 
         // but if not, we catch it here.
        return ApiException('Server error: ${e.response?.statusCode}');
      case DioExceptionType.connectionError:
        return ApiException('No internet connection.');
      default:
        return ApiException('Network error occurred.');
    }
  }

  String _extractErrorMessage(dynamic data) {
    if (data is Map) {
      if (data.containsKey('message')) return data['message'].toString();
      if (data.containsKey('error')) {
        final error = data['error'];
        if (error is Map && error.containsKey('message')) {
          return error['message'].toString();
        }
        return error.toString();
      }
    }
    if (data is String) {
      // Check for HTML response (e.g. 404/500 pages)
      if (data.trim().startsWith('<') || data.contains('<!DOCTYPE html>')) {
        return 'Server Error: Invalid response format.';
      }
      // Truncate extremely long messages to prevent UI overflow
      if (data.length > 300) {
        return '${data.substring(0, 300)}...';
      }
      return data;
    }
    return 'Unknown error';
  }
}

/// Custom API Exception
class ApiException implements Exception {
  final String message;
  ApiException(this.message);
  @override
  String toString() => message;
}
