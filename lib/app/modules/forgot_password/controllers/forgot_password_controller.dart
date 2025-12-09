import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  // Text controller
  final emailController = TextEditingController();
  
  // Observable for loading state
  final isLoading = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  // Email validation
  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // Send password reset email
  void sendResetEmail() {
    final email = emailController.text.trim();

    // Validate email
    if (email.isEmpty) {
      Get.snackbar(
        'Erreur',
        'Veuillez entrer votre adresse email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (!isValidEmail(email)) {
      Get.snackbar(
        'Erreur',
        'Veuillez entrer une adresse email valide',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Mock sending reset email
    isLoading.value = true;
    
    // Simulate API call
    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false;
      
      Get.snackbar(
        'Succès',
        'Un email de réinitialisation a été envoyé à $email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
      
      // Navigate back to login after short delay
      Future.delayed(const Duration(seconds: 2), () {
        Get.back();
      });
    });
  }
}

