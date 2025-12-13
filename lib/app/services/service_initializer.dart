import 'package:get/get.dart';
import 'api_service.dart';
import 'auth_service.dart';
import 'biometric_service.dart';
import 'dashboard_service.dart';
import 'disputes_service.dart';
import 'loyalty_service.dart';
import 'orders_service.dart';
import 'payments_service.dart';
import 'purchase_orders_service.dart';
import 'quotes_service.dart';
import 'settings_service.dart';
import 'shipments_service.dart';
import 'users_service.dart';

/// Service Initializer
/// 
/// Initializes and registers all services with GetX dependency injection
class ServiceInitializer {
  /// Initialize all services
  /// 
  /// Call this method in main.dart before runApp()
  static Future<void> init() async {
    // Core services
    Get.put(ApiService(), permanent: true);
    Get.put(AuthService(), permanent: true);
    Get.put(BiometricService(), permanent: true);
    
    // Feature services
    Get.put(DashboardService(), permanent: true);
    Get.put(DisputesService(), permanent: true);
    Get.put(LoyaltyService(), permanent: true);
    Get.put(OrdersService(), permanent: true);
    Get.put(PaymentsService(), permanent: true);
    Get.put(PurchaseOrdersService(), permanent: true);
    Get.put(QuotesService(), permanent: true);
    Get.put(SettingsService(), permanent: true);
    Get.put(ShipmentsService(), permanent: true);
    Get.put(UsersService(), permanent: true);
  }
}
