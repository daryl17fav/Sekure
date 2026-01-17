import 'package:get/get.dart';
import '../config/api_config.dart';
import 'api_service.dart';

/// Orders Service
/// 
/// Handles order-related operations
class OrdersService extends GetxService {
  final ApiService _apiService = Get.find<ApiService>();

  /// Get all orders
  /// 
  /// Returns a list of all orders
  Future<List<dynamic>> getAllOrders() async {
    try {
      final response = await _apiService.get(ApiConfig.orders);
      return response['orders'] ?? response['data'] ?? [];
    } catch (e) {
      rethrow;
    }
  }

  /// Create a new order
  Future<Map<String, dynamic>> createOrder(Map<String, dynamic> orderData) async {
    try {
      final response = await _apiService.post(
        ApiConfig.orders,
        orderData,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Get a single order by ID
  /// 
  /// [id] - The order ID
  /// Returns order details
  Future<Map<String, dynamic>> getOrderById(String id) async {
    try {
      final response = await _apiService.get(ApiConfig.orderById(id));
      return response['order'] ?? response['data'] ?? {};
    } catch (e) {
      rethrow;
    }
  }

  /// Dispute an order
  /// 
  /// [id] - The order ID
  /// [disputeData] - Dispute data including reason, description, etc.
  Future<Map<String, dynamic>> disputeOrder(
    String id,
    Map<String, dynamic> disputeData,
  ) async {
    try {
      final response = await _apiService.post(
        ApiConfig.orderDispute(id),
        disputeData,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Get order timeline
  /// 
  /// [id] - The order ID
  /// Returns timeline of order events
  Future<List<dynamic>> getOrderTimeline(String id) async {
    try {
      final response = await _apiService.get(ApiConfig.orderTimeline(id));
      return response['timeline'] ?? response['data'] ?? [];
    } catch (e) {
      rethrow;
    }
  }

  /// Validate an order
  /// 
  /// [id] - The order ID
  /// [validationData] - Validation data
  Future<Map<String, dynamic>> validateOrder(
    String id,
    Map<String, dynamic> validationData,
  ) async {
    try {
      final response = await _apiService.post(
        ApiConfig.orderValidate(id),
        validationData,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
