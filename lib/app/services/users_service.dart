import 'package:get/get.dart';
import '../config/api_config.dart';
import 'api_service.dart';

/// Users Service
/// 
/// Handles user management operations
class UsersService extends GetxService {
  final ApiService _apiService = Get.find<ApiService>();

  /// Get all users
  /// 
  /// Returns a list of all users
  Future<List<dynamic>> getAllUsers() async {
    try {
      final response = await _apiService.get(ApiConfig.users);
      return response['users'] ?? response['data'] ?? [];
    } catch (e) {
      rethrow;
    }
  }

  /// Get a single user by ID
  /// 
  /// [id] - The user ID
  /// Returns user details
  Future<Map<String, dynamic>> getUserById(String id) async {
    try {
      final response = await _apiService.get(ApiConfig.userById(id));
      return response['user'] ?? response['data'] ?? {};
    } catch (e) {
      rethrow;
    }
  }
}
