import 'package:get/get.dart';
import '../config/api_config.dart';
import 'api_service.dart';

/// Dashboard Service
/// 
/// Handles dashboard-related operations
class DashboardService extends GetxService {
  final ApiService _apiService = Get.find<ApiService>();

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
}
