import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../services/biometric_service.dart';

class TouchIdAuthController extends GetxController {
  final BiometricService _biometricService = BiometricService();
  
  // Observable states
  final isAuthenticating = false.obs;
  final biometricEnabled = false.obs;
  final hasFingerprint = false.obs;
  final hasFaceID = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkBiometricAvailability();
  }

  /// Authorize Touch ID
  void authorizeTouchId() {
    // Navigate to Touch ID verify screen
    Get.toNamed(Routes.TOUCH_ID_VERIFY);
  }

  /// Skip Touch ID setup
  void skipTouchId() {
    Get.snackbar(
      'Information',
      'Vous pouvez activer l\'authentification biométrique plus tard dans les paramètres',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );

    // Navigate to home or next screen
    Future.delayed(const Duration(milliseconds: 500), () {
      Get.offAllNamed(Routes.HOME); // or Routes.HOME_BUYER depending on role
    });
  }

  /// Check if biometric is available
  Future<void> checkBiometricAvailability() async {
    final canCheck = await _biometricService.canCheckBiometrics();
    final isSupported = await _biometricService.isDeviceSupported();
    biometricEnabled.value = canCheck && isSupported;

    if (biometricEnabled.value) {
      // Check specific biometric types
      hasFingerprint.value = await _biometricService.hasFingerprint();
      hasFaceID.value = await _biometricService.hasFaceID();
    } else {
      Get.snackbar(
        'Information',
        'L\'authentification biométrique n\'est pas disponible sur cet appareil',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  /// Get biometric type name for display
  String get biometricTypeName {
    if (hasFaceID.value) return 'Face ID';
    if (hasFingerprint.value) return 'Touch ID';
    return 'Biométrique';
  }
}

