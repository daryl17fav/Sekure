import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentController extends GetxController {
  // Selected payment method index
  final selectedPaymentMethod = 0.obs;
  
  // Order details
  final productName = "Nom de l'article".obs;
  final vendorName = 'M. Martins AZEMIN'.obs;
  final amount = 12000.obs;
  final totalAmount = 25000.obs;
  
  // Loading state
  final isProcessing = false.obs;
  
  // Payment methods
  final paymentMethods = <PaymentMethod>[
    PaymentMethod(
      id: 0,
      name: 'Mobile Money',
      icon: Icons.money,
      iconColor: const Color(0xFFFBC02D), // Yellow
    ),
    PaymentMethod(
      id: 1,
      name: 'Moov Money',
      icon: Icons.monetization_on,
      iconColor: Colors.orange,
    ),
    PaymentMethod(
      id: 2,
      name: 'Mastercard',
      icon: Icons.credit_card,
      iconColor: Colors.red,
    ),
    PaymentMethod(
      id: 3,
      name: 'VISA',
      icon: Icons.credit_card,
      iconColor: Colors.blue,
    ),
    PaymentMethod(
      id: 4,
      name: 'Paypal',
      icon: Icons.paypal,
      iconColor: const Color(0xFF0070BA), // Paypal blue
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    
    // Get order details from arguments if available
    if (Get.arguments != null && Get.arguments is Map) {
      final args = Get.arguments as Map;
      productName.value = args['productName'] ?? productName.value;
      vendorName.value = args['vendorName'] ?? vendorName.value;
      amount.value = args['amount'] ?? amount.value;
      totalAmount.value = args['totalAmount'] ?? totalAmount.value;
    }
  }

  /// Select payment method
  void selectPaymentMethod(int index) {
    selectedPaymentMethod.value = index;
  }

  /// Get formatted amount
  String get formattedAmount => '${amount.value ~/ 1000}K Fcfa';

  /// Get formatted total
  String get formattedTotal => '${totalAmount.value.toStringAsFixed(0)} Fcfa';

  /// Process payment
  void processPayment() {
    final selectedMethod = paymentMethods[selectedPaymentMethod.value];
    
    isProcessing.value = true;
    
    // Simulate payment processing
    Future.delayed(const Duration(seconds: 2), () {
      isProcessing.value = false;
      
      Get.snackbar(
        'Succès',
        'Paiement effectué avec ${selectedMethod.name}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      
      // Navigate back or to success page
      Future.delayed(const Duration(milliseconds: 500), () {
        Get.back();
      });
    });
  }
}

/// Payment Method model
class PaymentMethod {
  final int id;
  final String name;
  final IconData icon;
  final Color iconColor;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.icon,
    required this.iconColor,
  });
}

