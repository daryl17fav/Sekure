import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class TouchIdVerifyController extends GetxController {
  // Observable states
  final isScanning = false.obs;
  final scanSuccess = false.obs;
  final scanFailed = false.obs;
  final scanMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Auto-start scanning when page loads
    Future.delayed(const Duration(milliseconds: 500), () {
      startScan();
    });
  }

  /// Start biometric scan
  void startScan() {
    isScanning.value = true;
    scanSuccess.value = false;
    scanFailed.value = false;
    scanMessage.value = 'Scanning...';

    // Simulate biometric scan (2 seconds)
    Future.delayed(const Duration(seconds: 2), () {
      // Mock: 80% success rate
      final success = DateTime.now().second % 5 != 0; // Fail every 5th attempt for demo
      
      if (success) {
        handleSuccess();
      } else {
        handleFailure();
      }
    });
  }

  /// Handle successful scan
  void handleSuccess() {
    isScanning.value = false;
    scanSuccess.value = true;
    scanMessage.value = 'Authentification réussie!';

    Get.snackbar(
      'Succès',
      'Touch ID vérifié avec succès!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );

    // Navigate to home after short delay
    Future.delayed(const Duration(seconds: 2), () {
      // TODO: Navigate based on user role
      Get.offAllNamed(Routes.HOME); // or Routes.HOME_BUYER
    });
  }

  /// Handle failed scan
  void handleFailure() {
    isScanning.value = false;
    scanFailed.value = true;
    scanMessage.value = 'Échec de l\'authentification';

    Get.snackbar(
      'Erreur',
      'Touch ID non reconnu. Veuillez réessayer.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );

    // Auto-retry after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (!scanSuccess.value) {
        startScan();
      }
    });
  }

  /// Manual retry
  void retry() {
    startScan();
  }

  /// Skip and go to home
  void skip() {
    Get.offAllNamed(Routes.HOME);
  }
}

