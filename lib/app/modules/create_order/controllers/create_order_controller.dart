import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateOrderController extends GetxController {
  // Text controllers
  final productNameController = TextEditingController();
  final priceController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final productLinkController = TextEditingController();
  
  // Observable states
  final isLoading = false.obs;
  final selectedVendor = Rxn<String>(); // Nullable observable
  final selectedImage = Rxn<String>(); // Image path
  
  // List of vendors (mock data)
  final vendors = <String>[
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
    productLinkController.dispose();
    super.onClose();
  }

  /// Select vendor from dropdown
  void selectVendor(String? vendor) {
    selectedVendor.value = vendor;
  }

  /// Pick image (mock)
  void pickImage() {
    // In real app, use image_picker package
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
    final cleaned = phone.replaceAll(' ', '');
    return RegExp(r'^\+229\d{8}$').hasMatch(cleaned) || RegExp(r'^01\d{8}$').hasMatch(cleaned);
  }

  /// Create order
  void createOrder() {
    final productName = productNameController.text.trim();
    final price = priceController.text.trim();
    final phone = phoneController.text.trim();
    final email = emailController.text.trim();
    final productLink = productLinkController.text.trim();

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

    // Validate vendor selection
    if (selectedVendor.value == null) {
      Get.snackbar(
        'Erreur',
        'Veuillez sélectionner un vendeur',
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

    // Validate product link
    if (productLink.isEmpty) {
      Get.snackbar(
        'Erreur',
        'Veuillez entrer le lien du produit',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Mock order creation
    isLoading.value = true;
    
    // Simulate API call
    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false;
      
      // Show success dialog
      showSuccessDialog();
    });
  }

  /// Show success dialog
  void showSuccessDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Succès",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "Votre bon de commande a été transmis\navec succès au vendeur. Veuillez\npatienter en attendant sa réponse.",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 25),
              SizedBox(
                height: 40,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF4E5FFF)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Get.back(); // Close dialog
                    Get.back(); // Go back to list
                  },
                  child: Text(
                    "Fermer",
                    style: const TextStyle(color: Color(0xFF4E5FFF)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

