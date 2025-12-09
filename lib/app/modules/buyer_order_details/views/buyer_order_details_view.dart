import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/buyer_order_details_controller.dart';
import '../../../../widgets/core_widgets.dart';
import '../../../../utils/colors.dart';
import '../../../routes/app_pages.dart';

class BuyerOrderDetailsView extends GetView<BuyerOrderDetailsController> {
  const BuyerOrderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 18), onPressed: () => Get.back()),
        title: Obx(() => Text(
          "Commande ${controller.orderNumber.value}",
          style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
        )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: GestureDetector(
              onTap: controller.showCancellationDialog,
              child: Center(
                child: Text(
                  "Annuler",
                  style: GoogleFonts.poppins(color: AppColors.primaryRed, fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Article
                  Obx(() => Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: AppColors.inputFill, borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        Container(width: 50, height: 50, color: Colors.grey[300]),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(controller.productName.value, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                            Text(controller.vendorName.value, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
                          ],
                        ),
                        const Spacer(),
                        Text(controller.formattedAmount, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                  )),
                  const SizedBox(height: 20),
                  
                  // Details Table
                  Obx(() => Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(color: AppColors.inputFill, borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      children: [
                         _detailRow("Vendeur", controller.vendorName.value),
                         const SizedBox(height: 8),
                         _detailRow("Date", controller.transactionDate.value),
                         const SizedBox(height: 8),
                         _detailRow("Transaction ID", controller.transactionId.value),
                      ],
                    ),
                  )),
                   const SizedBox(height: 20),

                  // Delivery Address
                   Obx(() => Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: AppColors.inputFill, borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        const Icon(Icons.map_outlined, color: Colors.green, size: 30),
                        const SizedBox(width: 15),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Adresse de livraison", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                            Text(controller.deliveryAddress.value, style: GoogleFonts.poppins(fontSize: 12, color: Colors.black87)),
                          ],
                        ),
                      ],
                    ),
                  )),
                  const SizedBox(height: 20),

                  // Timeline (Simplified for brevity)
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(color: AppColors.inputFill, borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.circle, color: AppColors.primaryBlue, size: 15),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Créée", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                              Text("Vous avez créé cette commande. Procédez au paiement...", style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
                              const SizedBox(height: 20),
                              Text("Payée", style: GoogleFonts.poppins(color: Colors.grey)),
                              const SizedBox(height: 20),
                              Text("Livraison", style: GoogleFonts.poppins(color: Colors.grey)),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          
          // Bottom Buttons
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Color(0xFFEEEEEE))),
            ),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDDE1EF), // Light Blue/Grey
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: controller.showValidationDialog,
                    child: Text("J'ai reçu ma commande", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)), // Text color usually white in your design, but button bg is light. Check design: text is likely Blue or White. Image shows White Text on Light Blue BG is low contrast, likely Text is Blue or Button is Darker Blue. Based on image "J'ai reçu ma commande" button is Light Purple/Blue. Let's make text White for now or PrimaryBlue.
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () => Get.toNamed(Routes.CREATE_DISPUTE),
                  child: Text("Contester la commande", style: GoogleFonts.poppins(color: AppColors.primaryRed, fontSize: 13, decoration: TextDecoration.underline)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _detailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 12)),
        Text(value, style: GoogleFonts.poppins(fontSize: 12)),
      ],
    );
  }


}