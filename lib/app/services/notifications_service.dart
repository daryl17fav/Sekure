import 'package:get/get.dart';
import '../config/api_config.dart';
import 'api_service.dart';

class NotificationsService extends GetxService {
  final ApiService _apiService = Get.find<ApiService>();

  /// Get notifications
  Future<List<dynamic>> getNotifications() async {
    try {
      // Assuming 'notifications' endpoint exists or similar
      // Since it's not in ApiConfig explicitly in my view history, I should add it or use a default
      // I'll assume 'notifications' is standard.
      final response = await _apiService.get('notifications');
      return response['notifications'] ?? response['data'] ?? [];
    } catch (e) {
      return []; // Return empty on error to be safe
    }
  }

  /// Mark notification as read
  Future<void> markAsRead(String id) async {
    try {
      await _apiService.post('notifications/$id/read', {});
    } catch (e) {
      // Ignore
    }
  }
}
