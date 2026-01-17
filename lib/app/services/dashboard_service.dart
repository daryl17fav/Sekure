import 'package:get/get.dart';
import '../config/api_config.dart';
import 'api_service.dart';

/// Dashboard Service
/// 
/// Handles dashboard-related operations
class DashboardService extends GetxService {
  final ApiService _apiService = Get.find<ApiService>();

  @override
  void onInit() {
    super.onInit();
  }

  /// Get dashboard statistics
  /// 
  /// Returns dashboard stats including orders, revenue, etc.
  Future<Map<String, dynamic>> getStats() async {
    try {
      final response = await _apiService.get(ApiConfig.dashboardStats);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Get recent transactions
  Future<List<dynamic>> getRecentTransactions() async {
    try {
      // Assuming an endpoint exists or using dashboard stats to pull this
      final response = await _apiService.get("${ApiConfig.dashboardStats}/transactions");
      return response['transactions'] ?? response['data'] ?? [];
    } catch (e) {
      // Return empty list on error for now to prevent crash if endpoint doesn't exist
      print("Error fetching transactions: $e");
      return [];
    }
  }
}
