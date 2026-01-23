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
  final passwordController = TextEditingController();
  final locationController = TextEditingController();
  
  // Observable for file selection
  final selectedFile = Rxn<String>();
  final isLoading = false.obs;
  final isPasswordVisible = false.obs;


  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    locationController.dispose();
    super.onClose();
  }
  
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
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

    Future<void> register() async {
    final name = nameController.text.trim();
    final phone = phoneController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
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
    
    // Validate password
    if (password.isEmpty || password.length < 6) {
      Get.snackbar(
        'Erreur',
        'Le mot de passe doit contenir au moins 6 caractères',
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

    // Real registration
    if (isLoading.value) return; // Prevent rage taps
    isLoading.value = true;
    
    try {
      // Prepare data
      final sellerData = {
        'name': name,
        'phone': phone,
        'email': email,
        'password': password, // Sending real password
        'location': location,
        'role': 'seller',
        'idCardImage': selectedFile.value, 
      };

      await _authService.registerSeller(sellerData);
      
      Get.snackbar(
        'Succès',
        'Inscription réussie! Vérifiez votre email.\n(Note: Le téléchargement de la pièce d\'identité est temporairement désactivé par le serveur)',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
      
      // Navigate to verification page
      // Navigate to verification page
      Get.toNamed(
        Routes.VERIFICATION,
        arguments: {
          'role': 'seller',
          'email': email,
        },
      );
    } catch (e) {
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
        _authService.forceClearAuth();
      } else {
        Get.snackbar(
          'Erreur',
          'Échec de l\'inscription: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
      
      // If it's a rate limit error, we also clear state
      if (e.toString().contains('Too many')) {
         _authService.forceClearAuth();
      }
    } finally {
      isLoading.value = false;
    }
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
