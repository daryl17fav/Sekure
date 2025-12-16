import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth_service.dart';


class RegisterSellerController extends GetxController {
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

  // Mock registration function
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

    // Mock registration - always succeed for demo
    isLoading.value = true;
    
    // Simulate API call
    Future.delayed(const Duration(seconds: 1), () {
      isLoading.value = false;
      
      Get.snackbar(
        'Succès',
        'Inscription réussie! Vérifiez votre email.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      
      // Navigate to verification page
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.toNamed(
          Routes.VERIFICATION,
          arguments: {
            'role': 'seller',
            'email': email,
          },
        );
      });
    });
  }


  // Real file picker
  Future<void> pickFile() async {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Sélectionner une source",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSourceOption(
                  icon: Icons.camera_alt,
                  label: "Caméra",
                  onTap: () => _pickImage(ImageSource.camera),
                ),
                _buildSourceOption(
                  icon: Icons.photo_library,
                  label: "Galerie",
                  onTap: () => _pickImage(ImageSource.gallery),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSourceOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () {
        Get.back(); // Close bottom sheet
        onTap();
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey[200],
            child: Icon(icon, size: 30, color: Colors.blue),
          ),
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);
      
      if (image != null) {
        selectedFile.value = image.path;
      }
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Impossible de sélectionner l\'image',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
