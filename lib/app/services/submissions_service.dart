import 'package:get/get.dart';
import '../config/api_config.dart';
import 'api_service.dart';

class SubmissionsService extends GetxService {
  final ApiService _apiService = Get.find<ApiService>();

  // Use a hypothetical endpoint for submissions since it wasn't valid in ApiConfig originally
  // Assuming 'submissions' based on pattern
  static const String submissionsEndpoint = "submissions";

  Future<List<dynamic>> getSubmissions() async {
    try {
      final response = await _apiService.get(submissionsEndpoint);
      return response['submissions'] ?? response['data'] ?? [];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createSubmission(Map<String, dynamic> data) async {
    try {
      // Handle file upload if image path is present
      // For now, assuming base64 or simpler flow until multipart is needed explicitly
      await _apiService.post(submissionsEndpoint, data);
    } catch (e) {
      rethrow;
    }
  }
}
