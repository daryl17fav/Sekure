import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth_service.dart';

class RegisterController extends GetxController {
  // Services
  final AuthService _authService = Get.find<AuthService>();

  // Text controllers
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final locationController = TextEditingController();
  
  // Observable for file selection
  final selectedFile = Rxn<String>();
  final isLoading = false.obs;

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    locationController.dispose();
    super.onClose();
  }

  // Email validation
  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // Phone validation (Benin format: +229 XX XXX XXX)
  bool isValidPhone(String phone) {
    // Remove spaces and check format
    final cleanPhone = phone.replaceAll(' ', '');
    return RegExp(r'^\+229\d{8}$').hasMatch(cleanPhone) || 
           RegExp(r'^229\d{8}$').hasMatch(cleanPhone) ||
           RegExp(r'^\d{8}$').hasMatch(cleanPhone);
  }

  // Registration function
  Future<void> register() async {
    final name = nameController.text.trim();
    final phone = phoneController.text.trim();
    final email = emailController.text.trim();
    final location = locationController.text.trim();

    // Validate name
    if (name.isEmpty) {
      Get.snackbar(
        'Erreur',
        'Veuillez entrer votre nom complet',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Validate phone
    if (phone.isEmpty) {
      Get.snackbar(
        'Erreur',
        'Veuillez entrer votre numéro de téléphone',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (!isValidPhone(phone)) {
      Get.snackbar(
        'Erreur',
        'Veuillez entrer un numéro de téléphone valide (format: +229 XX XXX XXX)',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

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

    // Validate location
    if (location.isEmpty) {
      Get.snackbar(
        'Erreur',
        'Veuillez entrer votre localisation',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Validate file
    if (selectedFile.value == null) {
      Get.snackbar(
        'Erreur',
        'Veuillez ajouter votre pièce d\'identité',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Call real API
    isLoading.value = true;
    
    try {
      final userData = {
        'name': name,
        'phone': phone,
        'email': email,
        'location': location,
        // Note: File upload will need multipart/form-data handling
        // For now, we'll just send the filename
        'identityDocument': selectedFile.value,
      };

      final user = await _authService.register(userData);
      
      isLoading.value = false;
      
      Get.snackbar(
        'Succès',
        'Inscription réussie! Vérifiez votre email pour le code OTP.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      
      // Navigate to OTP verification screen
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.toNamed(
          Routes.VERIFICATION,
          arguments: {
            'role': 'buyer',
            'email': email,
          },
        );
      });
    } catch (e) {
      isLoading.value = false;
      
      Get.snackbar(
        'Erreur',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
      );
    }
  }

  // Mock file picker
  void pickFile() {
    // In a real app, use file_picker package
    selectedFile.value = 'mock_identity_document.pdf';
    Get.snackbar(
      'Succès',
      'Fichier sélectionné: ${selectedFile.value}',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }
}
