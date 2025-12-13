import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../services/biometric_service.dart';

class TouchIdVerifyController extends GetxController {
  final BiometricService _biometricService = BiometricService();
  
  // Observable states
  final isScanning = false.obs;
  final scanSuccess = false.obs;
  final scanFailed = false.obs;
  final scanMessage = ''.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Auto-start scanning when page loads
    Future.delayed(const Duration(milliseconds: 500), () {
      startScan();
    });
  }

  /// Start biometric scan
  Future<void> startScan() async {
    isScanning.value = true;
    scanSuccess.value = false;
    scanFailed.value = false;
    scanMessage.value = 'Authentification en cours...';
    errorMessage.value = '';

    // Perform biometric authentication
    final result = await _biometricService.authenticate(
      localizedReason: 'Veuillez vous authentifier pour continuer',
      biometricOnly: true,
    );

    if (result.success) {
      handleSuccess();
    } else {
      handleFailure(result.errorMessage ?? 'Authentification échouée');
    }
  }

  /// Handle successful scan
  void handleSuccess() {
    isScanning.value = false;
    scanSuccess.value = true;
    scanMessage.value = 'Authentification réussie!';

    Get.snackbar(
      'Succès',
      'Authentification biométrique réussie!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );

    // Navigate to home after short delay
    Future.delayed(const Duration(seconds: 1), () {
      Get.offAllNamed(Routes.HOME); // or Routes.HOME_BUYER based on user role
    });
  }

  /// Handle failed scan
  void handleFailure(String message) {
    isScanning.value = false;
    scanFailed.value = true;
    scanMessage.value = 'Échec de l\'authentification';
    errorMessage.value = message;

    Get.snackbar(
      'Erreur',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
    );
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

