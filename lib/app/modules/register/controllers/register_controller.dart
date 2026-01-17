import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
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
    if (isLoading.value) return; // Prevent rage taps
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
      Get.toNamed(
        Routes.VERIFICATION,
        arguments: {
          'role': 'buyer',
          'email': email,
        },
      );
    } catch (e) {
      isLoading.value = false;
      
      // Handle "Email already registered" (409) specifically
      if (e.toString().contains('Email already registered') || e.toString().contains('Conflict')) {
         Get.snackbar(
          'Compte existant',
          'Cet email est déjà enregistré. Veuillez vous connecter.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          mainButton: TextButton(
            onPressed: () => Get.offNamed(Routes.LOGIN),
            child: const Text('Se connecter', style: TextStyle(color: Colors.white)),
          ),
          duration: const Duration(seconds: 5),
        );
        // Clean state just in case
        _authService.forceClearAuth();
      } else {
        // General error
        Get.snackbar(
          'Erreur',
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
      }

      // If it's a rate limit error, we also clear state to be safe as requested
      if (e.toString().contains('Too many')) {
         _authService.forceClearAuth();
      }
    }
  }

  // Real file picker
  Future<void> pickFile() async {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
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
              const SizedBox(height: 20),
              TextButton(
                onPressed: () => Get.back(),
                child: const Text("Annuler", style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
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
