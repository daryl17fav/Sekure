import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth_service.dart';

class LoginController extends GetxController {
  // Services
  final AuthService _authService = Get.find<AuthService>();

  // Text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  
  // Observable states
  final isLoading = false.obs;
  final isPasswordVisible = false.obs;
  final rememberMe = false.obs;

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

   void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

   void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
  }

   void goToForgotPassword() {
    Get.toNamed(Routes.FORGOT_PASSWORD);
  }

   bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

   void login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

     if (email.isEmpty) {
      Get.snackbar(
        'Erreur',
        'Veuillez entrer votre adresse email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
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
        margin: const EdgeInsets.all(10),
      );
      return;
    }

    // Validate password
    if (password.isEmpty) {
      Get.snackbar(
        'Erreur',
        'Veuillez entrer votre mot de passe',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
      );
      return;
    }

    if (password.length < 6) {
      Get.snackbar(
        'Erreur',
        'Le mot de passe doit contenir au moins 6 caractères',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
      );
      return;
    }

    // Call real API
    isLoading.value = true;
    
    try {
      final user = await _authService.login(email, password);
      
      isLoading.value = false;
      
      Get.snackbar(
        'Succès',
        'Bienvenue ${user.name}!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 2),
      );
      
      // Navigate based on user role
      Future.delayed(const Duration(milliseconds: 500), () {
        // Navigate to appropriate home screen based on role
        // For now, navigate to default home
        Get.offAllNamed(Routes.HOME);
      });
    } catch (e) {
      isLoading.value = false;
      
      Get.snackbar(
        'Erreur',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 3),
      );
    }
  }
}
