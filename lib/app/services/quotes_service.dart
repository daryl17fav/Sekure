import 'package:get/get.dart';
import '../config/api_config.dart';
import 'api_service.dart';

/// Quotes Service
/// 
/// Handles quote-related operations
class QuotesService extends GetxService {
  final ApiService _apiService = Get.find<ApiService>();

  /// Get all quotes
  /// 
  /// Returns a list of all quotes
  Future<List<dynamic>> getAllQuotes() async {
    try {
      final response = await _apiService.get(ApiConfig.quotes);
      return response['quotes'] ?? response['data'] ?? [];
    } catch (e) {
      rethrow;
    }
  }

  /// Get a single quote by ID
  /// 
  /// [id] - The quote ID
  /// Returns quote details
  Future<Map<String, dynamic>> getQuoteById(String id) async {
    try {
      final response = await _apiService.get(ApiConfig.quoteById(id));
      return response['quote'] ?? response['data'] ?? {};
    } catch (e) {
      rethrow;
    }
  }

  /// Get a quote by code
  /// 
  /// [code] - The quote code
  /// Returns quote details
  Future<Map<String, dynamic>> getQuoteByCode(String code) async {
    try {
      final response = await _apiService.get(ApiConfig.quoteByCode(code));
      return response['quote'] ?? response['data'] ?? {};
    } catch (e) {
      rethrow;
    }
  }

  /// Process payment for a quote
  /// 
  /// [id] - The quote ID
  /// [paymentData] - Payment data
  Future<Map<String, dynamic>> processQuotePayment(
    String id,
    Map<String, dynamic> paymentData,
  ) async {
    try {
      final response = await _apiService.post(
        ApiConfig.quotePayment(id),
        paymentData,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
