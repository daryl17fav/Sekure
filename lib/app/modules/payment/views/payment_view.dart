import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/payment_controller.dart';
import '../../../../widgets/core_widgets.dart';
import '../../../../utils/colors.dart';

class PaymentView extends GetView<PaymentController> {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const SekureAppBar(title: "Paiement"),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle("Articles"),
              Obx(() => Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: AppColors.inputFill, borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    Container(
                      width: 50, height: 50,
                      decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(8)),
                      child: const Icon(Icons.image, color: Colors.grey),
                    ),
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
            const SizedBox(height: 25),
            
            
            Obx(() => Column(
              children: controller.paymentMethods.map((method) {
                return _paymentOption(
                  method.id,
                  method.name,
                  method.icon,
                  method.iconColor,
                  controller.selectedPaymentMethod.value,
                );
              }).toList(),
            )),

            const Spacer(),
            
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Total", style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12)),
                    Obx(() => Text(
                      controller.formattedTotal,
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18),
                    )),
                  ],
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Obx(() => SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: controller.isProcessing.value ? null : controller.processPayment,
                      child: Text(
                        controller.isProcessing.value ? "Traitement..." : "Suivant",
                        style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(title, style: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 12)),
    );
  }

  Widget _paymentOption(int index, String name, IconData icon, Color iconColor, int selectedIndex) {
    bool isSelected = index == selectedIndex;
    return GestureDetector(
      onTap: () => controller.selectPaymentMethod(index),
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFEBEBF5) : AppColors.inputFill,
          borderRadius: BorderRadius.circular(12),
          border: isSelected ? Border.all(color: AppColors.primaryBlue, width: 1) : null,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(color: iconColor, borderRadius: BorderRadius.circular(5)),
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 15),
            Text(name, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
            const Spacer(),
            if (isSelected)
              const Icon(Icons.check_circle, color: AppColors.primaryBlue, size: 20),
          ],
        ),
      ),
    );
  }
}