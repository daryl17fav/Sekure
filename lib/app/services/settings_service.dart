import 'package:get/get.dart';
import '../config/api_config.dart';
import 'api_service.dart';

/// Settings Service
/// 
/// Handles application settings operations
class SettingsService extends GetxService {
  final ApiService _apiService = Get.find<ApiService>();

  /// Get user settings
  /// 
  /// Returns user settings and preferences
  Future<Map<String, dynamic>> getSettings() async {
    try {
      final response = await _apiService.get(ApiConfig.settings);
      return response['settings'] ?? response['data'] ?? {};
    } catch (e) {
      rethrow;
    }
  }

  /// Upload a file
  /// 
  /// [uploadData] - Upload data including file and metadata
  /// Returns upload result
  Future<Map<String, dynamic>> uploadFile(
    Map<String, dynamic> uploadData,
  ) async {
    try {
      final response = await _apiService.post(
        ApiConfig.settingsUpload,
        uploadData,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
