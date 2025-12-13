import 'package:get/get.dart';
import '../config/api_config.dart';
import 'api_service.dart';

/// Disputes Service
/// 
/// Handles dispute-related operations
class DisputesService extends GetxService {
  final ApiService _apiService = Get.find<ApiService>();

  /// Get all disputes
  /// 
  /// Returns a list of all disputes
  Future<List<dynamic>> getAllDisputes() async {
    try {
      final response = await _apiService.get(ApiConfig.disputes);
      return response['disputes'] ?? response['data'] ?? [];
    } catch (e) {
      rethrow;
    }
  }

  /// Get a single dispute by ID
  /// 
  /// [id] - The dispute ID
  /// Returns dispute details
  Future<Map<String, dynamic>> getDisputeById(String id) async {
    try {
      final response = await _apiService.get(ApiConfig.disputeById(id));
      return response['dispute'] ?? response['data'] ?? {};
    } catch (e) {
      rethrow;
    }
  }

  /// Respond to a dispute
  /// 
  /// [id] - The dispute ID
  /// [responseData] - Response data including message, attachments, etc.
  Future<Map<String, dynamic>> respondToDispute(
    String id,
    Map<String, dynamic> responseData,
  ) async {
    try {
      final response = await _apiService.post(
        ApiConfig.disputeRespond(id),
        responseData,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Resolve a dispute
  /// 
  /// [id] - The dispute ID
  /// [resolutionData] - Resolution data including outcome, notes, etc.
  Future<Map<String, dynamic>> resolveDispute(
    String id,
    Map<String, dynamic> resolutionData,
  ) async {
    try {
      final response = await _apiService.post(
        ApiConfig.disputeResolve(id),
        resolutionData,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
