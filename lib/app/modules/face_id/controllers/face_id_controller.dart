import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../services/biometric_service.dart';

class FaceIdController extends GetxController {
  final BiometricService _biometricService = BiometricService();
  
  // Observable states
  final isScanning = false.obs;
  final scanSuccess = false.obs;
  final scanFailed = false.obs;
  final biometricEnabled = false.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Check biometric availability on init
    checkBiometricAvailability();
  }

  /// Start Face ID scan
  Future<void> startFaceIdScan() async {
    isScanning.value = true;
    scanSuccess.value = false;
    scanFailed.value = false;
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

    Get.snackbar(
      'Succès',
      'Authentification réussie!',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );

    // Navigate to home after short delay
    Future.delayed(const Duration(seconds: 1), () {
      Get.offAllNamed(Routes.HOME_BUYER); // Buyers use Face ID
    });
  }

  /// Handle failed scan
  void handleFailure(String message) {
    isScanning.value = false;
    scanFailed.value = true;
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

  /// Skip Face ID setup
  void skipFaceId() {
    Get.snackbar(
      'Information',
      'Vous pouvez activer l\'authentification biométrique plus tard dans les paramètres',
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

  /// Check if biometric is available
  Future<void> checkBiometricAvailability() async {
    final canCheck = await _biometricService.canCheckBiometrics();
    final isSupported = await _biometricService.isDeviceSupported();
    biometricEnabled.value = canCheck && isSupported;

    if (!biometricEnabled.value) {
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

  /// Check if Face ID is specifically available
  Future<bool> hasFaceID() async {
    return await _biometricService.hasFaceID();
  }
}

