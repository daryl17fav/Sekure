import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class RoleSelectionController extends GetxController {
  // Selected role (for tracking/analytics)
  final selectedRole = ''.obs;

  /// Navigate to seller registration
  void selectSellerRole() {
    selectedRole.value = 'seller';
    
    // Optional: Log analytics event
    // Analytics.logEvent('role_selected', parameters: {'role': 'seller'});
    
    // Pass existing arguments (like social user data) to the next screen
    Get.toNamed(Routes.REGISTER_SELLER, arguments: Get.arguments);
  }

  /// Navigate to buyer registration
  void selectBuyerRole() {
    selectedRole.value = 'buyer';
    
    // Optional: Log analytics event
    // Analytics.logEvent('role_selected', parameters: {'role': 'buyer'});
    
    // Pass existing arguments (like social user data) to the next screen
    Get.toNamed(Routes.REGISTER, arguments: Get.arguments);
  }

  /// Navigate back to login
  void goToLogin() {
    Get.back();
  }
}

