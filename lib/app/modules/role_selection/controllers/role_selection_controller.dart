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
    
    Get.toNamed(Routes.REGISTER_SELLER);
  }

  /// Navigate to buyer registration
  void selectBuyerRole() {
    selectedRole.value = 'buyer';
    
    // Optional: Log analytics event
    // Analytics.logEvent('role_selected', parameters: {'role': 'buyer'});
    
    Get.toNamed(Routes.REGISTER);
  }

  /// Navigate back to login
  void goToLogin() {
    Get.back();
  }
}

