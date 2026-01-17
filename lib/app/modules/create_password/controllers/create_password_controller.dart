import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth_service.dart';

class CreatePasswordController extends GetxController {
  // Text controllers
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  
  // Observable for loading state
  final isLoading = false.obs;
  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;

  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  // Password validation
  bool isValidPassword(String password) {
    // At least 8 characters, one uppercase, one number, one special character
    return password.length >= 8 &&
           RegExp(r'[A-Z]').hasMatch(password) &&
           RegExp(r'[0-9]').hasMatch(password) &&
           RegExp(r'[!@#$%^&*(),.?":{}|<>_]').hasMatch(password);
  }

  // Create password function
  Future<void> createPassword() async {
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    // Validate password
    if (password.isEmpty) {
      Get.snackbar(
        'Erreur',
        'Veuillez entrer un mot de passe',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (!isValidPassword(password)) {
      Get.snackbar(
        'Erreur',
        'Le mot de passe doit contenir au minimum 8 caractères, au moins une lettre MAJUSCULE, un chiffre et un caractère spécial (@#_...)',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
      return;
    }

    // Validate confirm password
    if (confirmPassword.isEmpty) {
      Get.snackbar(
        'Erreur',
        'Veuillez confirmer votre mot de passe',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Check if passwords match
    if (password != confirmPassword) {
      Get.snackbar(
        'Erreur',
        'Les mots de passe ne correspondent pas',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Real password creation
    isLoading.value = true;
    
    try {
      // Assuming user is authenticated from previous steps (Verification)
      await Get.find<AuthService>().resetPassword(password, null);
      
      Get.snackbar(
        'Succès',
        'Mot de passe créé avec succès!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      
      // Navigate to biometric setup based on role
      Future.delayed(const Duration(milliseconds: 500), () {
        final String? role = Get.arguments as String?;
        if (role == 'seller') {
          Get.toNamed(Routes.TOUCH_ID_AUTH);
        } else {
          Get.toNamed(Routes.FACE_ID);
        }
      });
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Échec de la création du mot de passe: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
