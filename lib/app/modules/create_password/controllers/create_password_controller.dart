import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

  // Mock password creation function
  void createPassword() {
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

    // Mock password creation - always succeed for demo
    isLoading.value = true;
    
    // Simulate API call
    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false;
      
      Get.snackbar(
        'Succès',
        'Mot de passe créé avec succès!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      
      // Navigation will be handled by the view
    });
  }
}
