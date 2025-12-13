import 'package:get/get.dart';
import '../config/api_config.dart';
import 'api_service.dart';

/// Shipments Service
/// 
/// Handles shipment tracking and management
class ShipmentsService extends GetxService {
  final ApiService _apiService = Get.find<ApiService>();

  /// Get all shipments
  /// 
  /// Returns a list of all shipments
  Future<List<dynamic>> getAllShipments() async {
    try {
      final response = await _apiService.get(ApiConfig.shipments);
      return response['shipments'] ?? response['data'] ?? [];
    } catch (e) {
      rethrow;
    }
  }

  /// Get a single shipment by ID
  /// 
  /// [id] - The shipment ID
  /// Returns shipment details and tracking information
  Future<Map<String, dynamic>> getShipmentById(String id) async {
    try {
      final response = await _apiService.get(ApiConfig.shipmentById(id));
      return response['shipment'] ?? response['data'] ?? {};
    } catch (e) {
      rethrow;
    }
  }
}
