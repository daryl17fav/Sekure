import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

import '../../../services/auth_service.dart';

class VerificationController extends GetxController {
  // OTP Text Controllers (5 digits)
  final otp1Controller = TextEditingController();
  final otp2Controller = TextEditingController();
  final otp3Controller = TextEditingController();
  final otp4Controller = TextEditingController();
  final otp5Controller = TextEditingController();

  // Focus Nodes for auto-focus
  final otp1Focus = FocusNode();
  final otp2Focus = FocusNode();
  final otp3Focus = FocusNode();
  final otp4Focus = FocusNode();
  final otp5Focus = FocusNode();

  // Timer variables
  final remainingSeconds = 59.obs;
  final canResend = false.obs;
  Timer? _timer;

  // Email from registration (passed as argument)
  final userEmail = ''.obs;
  final maskedEmail = ''.obs;

  // Loading state
  final isVerifying = false.obs;

  @override
  void onInit() {
    super.onInit();
    
    // Get email from arguments if available
    if (Get.arguments != null && Get.arguments is Map) {
      userEmail.value = Get.arguments['email'] ?? '';
    }
    
    // Mask the email for display
    maskedEmail.value = _maskEmail(userEmail.value);
    
    // Start countdown timer
    startTimer();
    
    // Request focus on first field
    Future.delayed(const Duration(milliseconds: 300), () {
      otp1Focus.requestFocus();
    });
  }

  @override
  void onClose() {
    // Dispose controllers
    otp1Controller.dispose();
    otp2Controller.dispose();
    otp3Controller.dispose();
    otp4Controller.dispose();
    otp5Controller.dispose();

    // Dispose focus nodes
    otp1Focus.dispose();
    otp2Focus.dispose();
    otp3Focus.dispose();
    otp4Focus.dispose();
    otp5Focus.dispose();

    // Cancel timer
    _timer?.cancel();

    super.onClose();
  }

  /// Start countdown timer
  void startTimer() {
    remainingSeconds.value = 59;
    canResend.value = false;
    
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        canResend.value = true;
        timer.cancel();
      }
    });
  }

  final AuthService _authService = Get.find<AuthService>();

  /// Resend OTP code
  Future<void> resendOTP() async {
    if (!canResend.value) return;

    try {
      await _authService.resendOtp(userEmail.value);
      
      // Clear all OTP fields
      clearOTP();

      Get.snackbar(
        'Code envoyé',
        'Un nouveau code a été envoyé à ${maskedEmail.value}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );

      // Restart timer
      startTimer();

      // Focus first field
      otp1Focus.requestFocus();
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Impossible de renvoyer le code: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  /// Clear all OTP fields
  void clearOTP() {
    otp1Controller.clear();
    otp2Controller.clear();
    otp3Controller.clear();
    otp4Controller.clear();
    otp5Controller.clear();
  }

  /// Handle OTP input and auto-focus
  void onOTPChanged(String value, int index) {
    if (value.isEmpty) {
      // Handle backspace - move to previous field
      if (index > 1) {
        _focusField(index - 1);
      }
    } else if (value.length == 1) {
      // Move to next field
      if (index < 5) {
        _focusField(index + 1);
      } else {
        // Last field - unfocus keyboard
        FocusScope.of(Get.context!).unfocus();
      }
    }
  }

  /// Focus specific OTP field
  void _focusField(int index) {
    switch (index) {
      case 1:
        otp1Focus.requestFocus();
        break;
      case 2:
        otp2Focus.requestFocus();
        break;
      case 3:
        otp3Focus.requestFocus();
        break;
      case 4:
        otp4Focus.requestFocus();
        break;
      case 5:
        otp5Focus.requestFocus();
        break;
    }
  }

  /// Get complete OTP code
  String getOTPCode() {
    return otp1Controller.text +
        otp2Controller.text +
        otp3Controller.text +
        otp4Controller.text +
        otp5Controller.text;
  }

  /// Verify OTP code
  Future<void> verifyOTP() async {
    final code = getOTPCode();

    // Validate OTP length
    if (code.length != 5) {
      Get.snackbar(
        'Erreur',
        'Veuillez entrer le code complet (5 chiffres)',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Validate OTP is numeric
    if (!RegExp(r'^\d{5}$').hasMatch(code)) {
      Get.snackbar(
        'Erreur',
        'Le code doit contenir uniquement des chiffres',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    isVerifying.value = true;

    try {
      await _authService.verifyOtp(userEmail.value, code);

      Get.snackbar(
        'Succès',
        'Vérification réussie!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );

      // Navigate to password creation or dashboard depending on flow
      // Assuming register flow leads to role based dashboard or setup
      // User requested "verification send the otp to the email how hard is that" implying correct flow
      // Original code navigated to CREATE_PASSWORD. Keeping that flow if it's correct for the user app.
      
      Future.delayed(const Duration(milliseconds: 500), () {
        final String? role = Get.arguments is Map ? Get.arguments['role'] : Get.arguments as String?;
        // If the backend verification returns a token/user, we might be logged in now.
        // If the flow is Register -> Verify -> Create Password, then proceed.
        // If user is already created, maybe go home?
        // Sticking to original navigation but with real auth check pass
        Get.toNamed(Routes.CREATE_PASSWORD, arguments: role);
      });
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Échec de la vérification: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isVerifying.value = false;
    }
  }

  /// Mask email for privacy (abc...xyz@gmail.com)
  String _maskEmail(String email) {
    if (email.isEmpty) return 'abc...xyz@gmail.com';

    final parts = email.split('@');
    if (parts.length != 2) return 'abc...xyz@gmail.com';

    final username = parts[0];
    final domain = parts[1];

    if (username.length <= 3) {
      return '$username...@$domain';
    }

    final start = username.substring(0, 3);
    final end = username.substring(username.length - 3);
    
    return '$start...$end@$domain';
  }

  /// Format timer display (MM:SS)
  String get timerDisplay {
    final minutes = remainingSeconds.value ~/ 60;
    final seconds = remainingSeconds.value % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
