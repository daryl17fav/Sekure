import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateSubmissionController extends GetxController {
  // Text controllers
  final productNameController = TextEditingController();
  final priceController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  
  // Observable states
  final isLoading = false.obs;
  final selectedBuyer = Rxn<String>(); // Nullable observable
  final selectedImage = Rxn<String>(); // Image path
  
  // List of buyers (mock data)
  final buyers = <String>[
    'M. Martins AZEMIN',
    'Mme. Sophie DURAND',
    'M. Jean KOUASSI',
    'Mme. Marie TOURE',
  ].obs;

  @override
  void onClose() {
    productNameController.dispose();
    priceController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.onClose();
  }

  /// Select buyer from dropdown
  void selectBuyer(String? buyer) {
    selectedBuyer.value = buyer;
  }

  /// Pick image (mock)
  void pickImage() {
    // In real app, use image_picker package
    // For now, just set a mock image
    selectedImage.value = 'mock_image.jpg';
    
    Get.snackbar(
      'Succès',
      'Image sélectionnée',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 1),
    );
  }

  /// Validate email
  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  /// Validate phone (Benin format)
  bool isValidPhone(String phone) {
    // Remove spaces and check format
    final cleaned = phone.replaceAll(' ', '');
    return RegExp(r'^\+229\d{8}$').hasMatch(cleaned) || RegExp(r'^01\d{8}$').hasMatch(cleaned);
  }

  /// Create submission
  void createSubmission() {
    final productName = productNameController.text.trim();
    final price = priceController.text.trim();
    final phone = phoneController.text.trim();
    final email = emailController.text.trim();

    // Validate product name
    if (productName.isEmpty) {
      Get.snackbar(
        'Erreur',
        'Veuillez entrer le nom du produit',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Validate price
    if (price.isEmpty) {
      Get.snackbar(
        'Erreur',
        'Veuillez entrer le prix du produit',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Validate buyer selection
    if (selectedBuyer.value == null) {
      Get.snackbar(
        'Erreur',
        'Veuillez sélectionner un acheteur',
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
        'Veuillez entrer le numéro de téléphone',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (!isValidPhone(phone)) {
      Get.snackbar(
        'Erreur',
        'Numéro de téléphone invalide. Format: +229 01 XXX XXX XX',
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
        'Veuillez entrer l\'adresse email',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (!isValidEmail(email)) {
      Get.snackbar(
        'Erreur',
        'Adresse email invalide',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Mock submission creation
    isLoading.value = true;
    
    // Simulate API call
    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false;
      
      Get.snackbar(
        'Succès',
        'Soumission créée avec succès!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      
      // Navigate back after short delay
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.back();
      });
    });
  }
}

