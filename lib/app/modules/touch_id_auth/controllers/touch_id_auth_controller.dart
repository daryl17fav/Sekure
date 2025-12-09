import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class TouchIdAuthController extends GetxController {
  // Observable states
  final isAuthenticating = false.obs;
  final biometricEnabled = false.obs;

  /// Authorize Touch ID
  void authorizeTouchId() {
    // Navigate to Touch ID verify screen
    Get.toNamed(Routes.TOUCH_ID_VERIFY);
  }

  /// Skip Touch ID setup
  void skipTouchId() {
    Get.snackbar(
      'Information',
      'Vous pouvez activer Touch ID plus tard dans les paramètres',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );

    // Navigate to home or next screen
    Future.delayed(const Duration(milliseconds: 500), () {
      // TODO: Navigate to appropriate home screen based on user role
      // For now, just go back or to a default route
      Get.offAllNamed(Routes.HOME); // or Routes.HOME_BUYER depending on role
    });
  }

  /// Check if biometric is available (mock)
  Future<bool> checkBiometricAvailability() async {
    // In a real app, use local_auth package
    // final LocalAuthentication auth = LocalAuthentication();
    // return await auth.canCheckBiometrics;
    
    // Mock: Always return true for demo
    return true;
  }
}

