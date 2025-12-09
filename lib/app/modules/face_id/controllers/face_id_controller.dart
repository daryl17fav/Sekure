import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class FaceIdController extends GetxController {
  // Observable states
  final isScanning = false.obs;
  final scanSuccess = false.obs;
  final scanFailed = false.obs;
  final biometricEnabled = false.obs;

  /// Start Face ID scan
  void startFaceIdScan() {
    isScanning.value = true;
    scanSuccess.value = false;
    scanFailed.value = false;

    // Simulate Face ID scan (2 seconds)
    Future.delayed(const Duration(seconds: 2), () {
      // Mock: 90% success rate
      final success = DateTime.now().second % 10 != 0;
      
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

    Get.snackbar(
      'Succès',
      'Face ID vérifié avec succès!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );

    // Navigate to home after short delay
    Future.delayed(const Duration(seconds: 2), () {
      Get.offAllNamed(Routes.HOME_BUYER); // Buyers use Face ID
    });
  }

  /// Handle failed scan
  void handleFailure() {
    isScanning.value = false;
    scanFailed.value = true;

    Get.snackbar(
      'Erreur',
      'Face ID non reconnu. Veuillez réessayer.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );

    // Auto-retry after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (!scanSuccess.value) {
        startFaceIdScan();
      }
    });
  }

  /// Skip Face ID setup
  void skipFaceId() {
    Get.snackbar(
      'Information',
      'Vous pouvez activer Face ID plus tard dans les paramètres',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );

    // Navigate to home
    Future.delayed(const Duration(milliseconds: 500), () {
      Get.offAllNamed(Routes.HOME_BUYER);
    });
  }

  /// Check if biometric is available (mock)
  Future<bool> checkBiometricAvailability() async {
    // In a real app, use local_auth package
    // Mock: Always return true for demo
    return true;
  }
}

