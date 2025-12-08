import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/create_order_controller.dart';
import '../../../../widgets/core_widgets.dart';
import '../../../../widgets/common_widgets.dart'; // For CustomTextField
import '../../../../utils/colors.dart';

class CreateOrderView extends GetView<CreateOrderController> {
  const CreateOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const SekureAppBar(title: "Nouveau bon de commande"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomTextField(hint: "Nom du produit*"),
              const CustomTextField(hint: "Prix du produit*"),
              
              // Vendor Dropdown
              Container(
                margin: const EdgeInsets.only(bottom: 15),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 55,
                decoration: BoxDecoration(color: AppColors.inputFill, borderRadius: BorderRadius.circular(12)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Vendeur*", style: GoogleFonts.poppins(color: Colors.grey[400])),
                    const Icon(Icons.keyboard_arrow_down, color: AppColors.primaryBlue)
                  ],
                ),
              ),

              const CustomTextField(hint: "+ 229  01 XXX XXX XX"),
              const CustomTextField(hint: "Adresse mail du vendeur*"),
              const CustomTextField(hint: "Lien du produit*"), // Extra field from screenshot

              // Image Upload
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(color: const Color(0xFFDDE1EF), borderRadius: BorderRadius.circular(8)),
                child: Text("Ajouter une image", style: GoogleFonts.poppins(color: AppColors.primaryBlue, fontWeight: FontWeight.bold, fontSize: 12)),
              ),
              const SizedBox(height: 5),
              Text("Aucune image sélectionnée", style: GoogleFonts.poppins(fontSize: 11)),
              
              const SizedBox(height: 50), 
              PrimaryButton(
                text: "Envoyer", 
                onPressed: () => _showSuccessDialog(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Succès", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),
              Text(
                "Votre bon de commande a été transmis\navec succès au vendeur. Veuillez\npatienter en attendant sa réponse.",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 13),
              ),
              const SizedBox(height: 25),
              SizedBox(
                height: 40,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.primaryBlue),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                  ),
                  onPressed: () {
                    Get.back(); // Close dialog
                    Get.back(); // Go back to list
                  },
                  child: Text("Fermer", style: GoogleFonts.poppins(color: AppColors.primaryBlue)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}