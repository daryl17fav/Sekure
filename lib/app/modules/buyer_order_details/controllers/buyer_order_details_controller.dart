import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/orders_service.dart';


class BuyerOrderDetailsController extends GetxController {
  final OrdersService _ordersService = Get.find<OrdersService>();
  
  // Order details
  final orderNumber = 'n°165TYFHJG'.obs;
  final productName = "Nom de l'article".obs;
  final vendorName = 'M. Martins AZEMIN'.obs;
  final amount = 12000.obs;
  final productImage = 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400'.obs;
  
  // Transaction details
  final transactionDate = 'Mardi 17 Septembre 2025'.obs;
  final transactionId = '#678YUIHFGCJ876TY'.obs;
  
  // Delivery details
  final deliveryAddress = '22 Rue du Chinks, Malibu, ETAT'.obs;
  
  // Order status
  final currentStatus = 'Créée'.obs; // Créée, Payée, Livraison, etc.
  
  // Loading states
  final isValidating = false.obs;
  final isCancelling = false.obs;

  @override
  void onInit() {
    super.onInit();
    
    // Get order from arguments if available
    if (Get.arguments != null && Get.arguments is Map) {
      final args = Get.arguments as Map;
      orderNumber.value = args['orderNumber'] ?? orderNumber.value;
      productName.value = args['productName'] ?? productName.value;
      vendorName.value = args['vendorName'] ?? vendorName.value;
      amount.value = args['amount'] ?? amount.value;
      productImage.value = args['image'] ?? productImage.value;
      currentStatus.value = args['status'] ?? currentStatus.value;
    }
  }

  /// Get formatted amount
  String get formattedAmount => '${amount.value ~/ 1000}K Fcfa';

  /// Show cancellation dialog
  void showCancellationDialog() {
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
                "Annulation",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "Vous êtes sur le point d'annuler la livraison votre commande. Veuillez noter que vous ne pourrez pas annuler si le vendeur a déjà procédé au paiement ou poursuivre cette action ?",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () => Get.back(),
                      child: const Text(
                        "Non",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  TextButton(
                    onPressed: () {
                      Get.back();
                      cancelOrder();
                    },
                    child: const Text(
                      "Oui",
                      style: TextStyle(
                        color: Color(0xFF4E5FFF),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Cancel order
  void cancelOrder() {
    isCancelling.value = true;
    
    // Simulate API call
    Future.delayed(const Duration(seconds: 1), () {
      isCancelling.value = false;
      
      Get.snackbar(
        'Annulée',
        'Commande annulée avec succès',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      
      // Navigate back
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.back();
      });
    });
  }

  /// Show validation dialog
  void showValidationDialog() {
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
                "Validation",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "Vous êtes sur le point de déclarer avoir\nreçu votre commande et qu'elle est\nconforme. Êtes vous sûr de vouloir\npoursuivre cette action ?",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 13),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    height: 40,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () => Get.back(),
                      child: const Text(
                        "Non",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  TextButton(
                    onPressed: () {
                      Get.back();
                      validateOrder();
                    },
                    child: const Text(
                      "Oui",
                      style: TextStyle(
                        color: Color(0xFF4E5FFF),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Validate order (mark as received)
  void validateOrder() {
    isValidating.value = true;
    
    // Simulate API call
    Future.delayed(const Duration(seconds: 1), () {
      isValidating.value = false;
      
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
                "La livraison a été annulée avec succès.",
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
                  child: const Text(
                    "Fermer",
                    style: TextStyle(color: Color(0xFF4E5FFF)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

