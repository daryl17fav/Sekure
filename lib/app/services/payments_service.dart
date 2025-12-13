import 'package:get/get.dart';
import '../config/api_config.dart';
import 'api_service.dart';

/// Payments Service
/// 
/// Handles payment-related operations
class PaymentsService extends GetxService {
  final ApiService _apiService = Get.find<ApiService>();

  /// Simulate a payment
  /// 
  /// [paymentData] - Payment data including amount, method, etc.
  /// Returns payment simulation result
  Future<Map<String, dynamic>> simulatePayment(
    Map<String, dynamic> paymentData,
  ) async {
    try {
      final response = await _apiService.post(
        ApiConfig.paymentsSimulate,
        paymentData,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Handle payment webhook
  /// 
  /// [webhookData] - Webhook data from payment provider
  /// Returns webhook processing result
  Future<Map<String, dynamic>> handleWebhook(
    Map<String, dynamic> webhookData,
  ) async {
    try {
      final response = await _apiService.post(
        ApiConfig.paymentsWebhook,
        webhookData,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
