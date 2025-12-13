import 'package:get/get.dart';
import '../config/api_config.dart';
import 'api_service.dart';

/// Loyalty Service
/// 
/// Handles loyalty program operations
class LoyaltyService extends GetxService {
  final ApiService _apiService = Get.find<ApiService>();

  /// Get loyalty points history
  /// 
  /// Returns transaction history of loyalty points
  Future<List<dynamic>> getHistory() async {
    try {
      final response = await _apiService.get(ApiConfig.loyaltyHistory);
      return response['history'] ?? response['data'] ?? [];
    } catch (e) {
      rethrow;
    }
  }

  /// Get current loyalty points balance
  /// 
  /// Returns the user's current points balance
  Future<Map<String, dynamic>> getPoints() async {
    try {
      final response = await _apiService.get(ApiConfig.loyaltyPoints);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Get available rewards
  /// 
  /// Returns a list of rewards that can be redeemed
  Future<List<dynamic>> getRewards() async {
    try {
      final response = await _apiService.get(ApiConfig.loyaltyRewards);
      return response['rewards'] ?? response['data'] ?? [];
    } catch (e) {
      rethrow;
    }
  }
}
