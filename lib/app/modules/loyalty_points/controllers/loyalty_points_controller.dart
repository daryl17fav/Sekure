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

  @override
  void onInit() {
    super.onInit();
    fetchPoints();
  }

  /// Fetch points from API
  Future<void> fetchPoints() async {
    isLoading.value = true;
    try {
      final data = await _loyaltyService.getPoints();
      // Assuming response has 'points' or 'balance'
      totalPoints.value = int.tryParse(data['points']?.toString() ?? data['balance']?.toString() ?? '0') ?? 0;
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de charger vos points');
    } finally {
      isLoading.value = false;
    }
  }

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
    fetchPoints();
  }
}

