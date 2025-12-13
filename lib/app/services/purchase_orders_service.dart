import 'package:get/get.dart';
import '../config/api_config.dart';
import 'api_service.dart';

/// Purchase Orders Service
/// 
/// Handles purchase order operations
class PurchaseOrdersService extends GetxService {
  final ApiService _apiService = Get.find<ApiService>();

  /// Get all purchase orders
  /// 
  /// Returns a list of all purchase orders
  Future<List<dynamic>> getAllPurchaseOrders() async {
    try {
      final response = await _apiService.get(ApiConfig.purchaseOrders);
      return response['purchaseOrders'] ?? response['data'] ?? [];
    } catch (e) {
      rethrow;
    }
  }

  /// Get a single purchase order by ID
  /// 
  /// [id] - The purchase order ID
  /// Returns purchase order details
  Future<Map<String, dynamic>> getPurchaseOrderById(String id) async {
    try {
      final response = await _apiService.get(ApiConfig.purchaseOrderById(id));
      return response['purchaseOrder'] ?? response['data'] ?? {};
    } catch (e) {
      rethrow;
    }
  }

  /// Accept a purchase order
  /// 
  /// [id] - The purchase order ID
  /// [acceptanceData] - Acceptance data
  Future<Map<String, dynamic>> acceptPurchaseOrder(
    String id,
    Map<String, dynamic> acceptanceData,
  ) async {
    try {
      final response = await _apiService.post(
        ApiConfig.purchaseOrderAccept(id),
        acceptanceData,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Process payment for a purchase order
  /// 
  /// [id] - The purchase order ID
  /// [paymentData] - Payment data
  Future<Map<String, dynamic>> processPurchaseOrderPayment(
    String id,
    Map<String, dynamic> paymentData,
  ) async {
    try {
      final response = await _apiService.post(
        ApiConfig.purchaseOrderPayment(id),
        paymentData,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
