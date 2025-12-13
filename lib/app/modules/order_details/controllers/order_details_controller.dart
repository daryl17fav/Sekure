import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/orders_service.dart';


class OrderDetailsController extends GetxController {
  final OrdersService _ordersService = Get.find<OrdersService>();
  
  // Order data
  final orderNumber = 'n°165TYFHJG'.obs;
  final productName = "Nom de l'article".obs;
  final clientName = 'Nom du client'.obs;
  final price = 12000.obs;
  final productImage = 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400'.obs;
  
  // Transaction details
  final transactionDate = 'Mardi 17 Septembre 2025'.obs;
  final transactionId = '#678YUIHFGCj876TY'.obs;
  
  // Delivery details
  final deliveryStatus = 'En cours'.obs;
  final deliveryAddress = '22 Rue du Chinks, Malibu, ETAT'.obs;
  
  // Order stages
  final currentStage = 0.obs; 
  
  // Loading state
  final isProcessing = false.obs;

  @override
  void onInit() {
    super.onInit();
    
    // Get order from arguments if available
    if (Get.arguments != null && Get.arguments is Map) {
      final args = Get.arguments as Map;
      orderNumber.value = args['orderNumber'] ?? orderNumber.value;
      productName.value = args['productName'] ?? productName.value;
      clientName.value = args['clientName'] ?? clientName.value;
      price.value = args['price'] ?? price.value;
      productImage.value = args['image'] ?? productImage.value;
      currentStage.value = args['stage'] ?? currentStage.value;
    }
  }

  /// Get formatted price
  String get formattedPrice => '${price.value ~/ 1000}K Fcfa';

  /// Check if stage is completed
  bool isStageCompleted(int stage) => currentStage.value > stage;

  /// Check if stage is current
  bool isStageCurrent(int stage) => currentStage.value == stage;

  /// Get stage title
  String getStageTitle(int stage) {
    switch (stage) {
      case 0:
        return 'Créée';
      case 1:
        return 'Payée';
      case 2:
        return 'Livraison';
      case 3:
        return 'Validation';
      case 4:
        return 'Validation client';
      case 5:
        return 'Remboursements';
      default:
        return '';
    }
  }

  /// Get stage description
  String getStageDescription(int stage) {
    switch (stage) {
      case 0:
        return 'Le client a créé cette commande. Veuillez patienter la validation de la vente.';
      case 1:
        return 'Paiement effectué avec succès. Vous pouvez préparer la commande...';
      case 2:
        return 'Vous avez commencé la livraison de la commande';
      case 3:
        return 'Vous avez marqué comme livrée la commande. Veuillez patienter la validation du client pour être payé.';
      case 4:
        return 'Le client a validé la commande. Vous serez payé dans un instant.';
      case 5:
        return 'Un problème a été signalé par le client. Le support vous donnera une réponse dans quelques instants';
      default:
        return '';
    }
  }

  /// Show livraison confirmation dialog
  void showLivraisonDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Livraison',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                'Vous êtes sur le point de déclarer cette commande en cours de livraison. Êtes-vous sûr de vouloir poursuivre cette action ?',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => Get.back(),
                      child: const Text(
                        'Non',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {
                        Get.back();
                        markAsShipped();
                      },
                      child: const Text(
                        'Oui',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
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

  /// Mark order as shipped
  void markAsShipped() {
    isProcessing.value = true;
    
    // Simulate API call
    Future.delayed(const Duration(seconds: 1), () {
      isProcessing.value = false;
      currentStage.value = 2; // Move to Livraison stage
      
      Get.snackbar(
        'Succès',
        'Commande marquée comme expédiée',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    });
  }

  /// Mark order as delivered
  void markAsDelivered() {
    isProcessing.value = true;
    
    // Simulate API call
    Future.delayed(const Duration(seconds: 1), () {
      isProcessing.value = false;
      currentStage.value = 3; // Move to Validation stage
      
      Get.snackbar(
        'Succès',
        'Commande marquée comme livrée',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    });
  }
}
