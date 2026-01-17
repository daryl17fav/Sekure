import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../services/submissions_service.dart';
import '../../../services/users_service.dart';

class CreateSubmissionController extends GetxController {
  final SubmissionsService _submissionsService = Get.find<SubmissionsService>();
  
  // Text controllers
  final productNameController = TextEditingController();
  final priceController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  
  // Observable states
  final isLoading = false.obs;
  final selectedBuyer = Rxn<String>(); 
  final selectedImage = Rxn<String>();  
  
  final UsersService _usersService = Get.find<UsersService>();

  @override
  void onInit() {
    super.onInit();
    fetchBuyers();
  }
  
  // List of buyers
  final buyers = <String>[].obs;
  
  /// Fetch buyers from API
  Future<void> fetchBuyers() async {
    try {
      final users = await _usersService.getAllUsers();
      // Filter logic if needed
      buyers.value = users.map<String>((u) {
        return u['name']?.toString() ?? u['email']?.toString() ?? 'Inconnu';
      }).toList();
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de charger les acheteurs');
    }
  }

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

  /// Pick image with Modal
  Future<void> pickImage() async {
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
              "Sélectionner une image",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSourceOption(
                  icon: Icons.camera_alt,
                  label: "Caméra",
                  onTap: () => _pickImageFromSource(ImageSource.camera),
                ),
                _buildSourceOption(
                  icon: Icons.photo_library,
                  label: "Galerie",
                  onTap: () => _pickImageFromSource(ImageSource.gallery),
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
        Get.back();
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

  Future<void> _pickImageFromSource(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);
      
      if (image != null) {
        selectedImage.value = image.path;
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
  Future<void> createSubmission() async {
    final productName = productNameController.text.trim();
    final price = priceController.text.trim();
    final phone = phoneController.text.trim();
    final email = emailController.text.trim();

    // Validate product name
    if (productName.isEmpty) {
      Get.snackbar('Erreur', 'Veuillez entrer le nom du produit', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    // Validate price
    if (price.isEmpty) {
      Get.snackbar('Erreur', 'Veuillez entrer le prix du produit', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    // Validate buyer selection
    if (selectedBuyer.value == null) {
      Get.snackbar('Erreur', 'Veuillez sélectionner un acheteur', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    // Validate phone
    if (phone.isEmpty) {
      Get.snackbar('Erreur', 'Veuillez entrer le numéro de téléphone', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    if (!isValidPhone(phone)) {
      Get.snackbar('Erreur', 'Numéro de téléphone invalide.', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    // Validate email
    if (email.isEmpty) {
      Get.snackbar('Erreur', 'Veuillez entrer l\'adresse email', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    if (!isValidEmail(email)) {
      Get.snackbar('Erreur', 'Adresse email invalide', snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    isLoading.value = true;
    
    try {
      final submissionData = {
        'productName': productName,
        'price': int.parse(price),
        'buyerName': selectedBuyer.value,
        'phone': phone,
        'email': email,
        'image': selectedImage.value,
      };

      await _submissionsService.createSubmission(submissionData);
      
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
        // Refresh submissions list if controller is available
        if (Get.isRegistered<dynamic>(tag: 'SubmissionsController')) {
             // trigger refresh if possible
        }
      });
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Erreur lors de la création de la soumission: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}

