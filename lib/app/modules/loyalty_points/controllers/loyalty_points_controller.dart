import 'package:get/get.dart';
import '../../../services/loyalty_service.dart';


class LoyaltyPointsController extends GetxController {
  final LoyaltyService _loyaltyService = Get.find<LoyaltyService>();
  
  // User points
  final totalPoints = 350.obs;
  
  // Loading state
  final isLoading = false.obs;

  /// Get formatted points
  String get formattedPoints => totalPoints.value.toString();

  /// View advantages
  void viewAdvantages() {
    Get.snackbar(
      'Avantages',
      'Fonctionnalité à venir',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  /// Refresh points
  void refreshPoints() {
    isLoading.value = true;
    
    // Simulate API call
    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false;
      totalPoints.value = 350; // Mock refresh
    });
  }
}

