import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/payment_controller.dart';
import '../../../../widgets/core_widgets.dart';
import '../../../../utils/colors.dart';

class PaymentView extends GetView<PaymentController> {
  // Use GetxController for state management in real app, using ValueNotifier for brevity here
  final ValueNotifier<int> _selectedPaymentIndex = ValueNotifier<int>(0);

  PaymentView({super.key});

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
            Container(
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
                      Text("Nom de l'article", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                      Text("M. Martins AZEMIN", style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
                    ],
                  ),
                  const Spacer(),
                  Text("12K Fcfa", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
                ],
              ),
            ),
            const SizedBox(height: 25),
            
            _sectionTitle("Moyen de paiement"),
            
            ValueListenableBuilder<int>(
              valueListenable: _selectedPaymentIndex,
              builder: (context, selectedIndex, _) {
                return Column(
                  children: [
                    _paymentOption(0, "Mobile Money", Icons.money, Colors.yellow[700]!, selectedIndex),
                    _paymentOption(1, "Moov Money", Icons.monetization_on, Colors.orange, selectedIndex),
                    _paymentOption(2, "Mastercard", Icons.credit_card, Colors.red, selectedIndex),
                    _paymentOption(3, "VISA", Icons.credit_card, Colors.blue, selectedIndex),
                    _paymentOption(4, "Paypal", Icons.paypal, Colors.blue[800]!, selectedIndex),
                  ],
                );
              },
            ),

            const Spacer(),
            
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Total", style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12)),
                    Text("25.000 Fcfa", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18)),
                  ],
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                      onPressed: () {}, // Process Payment
                      child: Text("Suivant", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ),
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
      onTap: () => _selectedPaymentIndex.value = index,
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