import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../services/orders_service.dart';
import '../../../services/users_service.dart';

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
  
  final UsersService _usersService = Get.find<UsersService>();

  @override
  void onInit() {
    super.onInit();
    fetchVendors();
  }

  // List of vendors
  final vendors = <String>[].obs;

  /// Fetch vendors from API
  Future<void> fetchVendors() async {
    try {
      final users = await _usersService.getAllUsers();
      // Filter for sellers/vendors if role is available, otherwise take all or specific mapping
      // Assuming user object has 'role' or similar, or just name
      // For now, mapping all users to names as fallback for "Remove All Mock Data"
      
      vendors.value = users.map<String>((u) {
        return u['name']?.toString() ?? u['email']?.toString() ?? 'Inconnu';
      }).toList();
      
      // If list is empty (no backend data), we might want to keep generic or handle empty
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de charger les vendeurs');
    }
  }

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

  /// Pick image (Real)
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
        selectedImage.value = image.path;
        Get.snackbar(
          'Succès',
          'Image sélectionnée',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: const Duration(seconds: 1),
        );
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
    final cleaned = phone.replaceAll(' ', '');
    return RegExp(r'^\+229\d{8}$').hasMatch(cleaned) || RegExp(r'^01\d{8}$').hasMatch(cleaned);
  }

  /// Create order
  Future<void> createOrder() async {
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

    // Real order creation
    isLoading.value = true;
    
    try {
      // Prepare data
      final orderData = {
        'productName': productName,
        'price': price,
        'vendorName': selectedVendor.value,
        'buyerPhone': phone,
        'buyerEmail': email,
        'productLink': productLink,
        'status': 'pending', // Default status
        'image': selectedImage.value,
      };

      await Get.find<OrdersService>().createOrder(orderData);
      
      // Show success dialog
      showSuccessDialog();
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Échec de la création de la commande: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
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

