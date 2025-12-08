import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/create_submission_controller.dart';
import '../../../../widgets/core_widgets.dart';
import '../../../../widgets/common_widgets.dart'; // Reuse CustomTextField and PrimaryButton
import '../../../../utils/colors.dart';

class CreateSubmissionView extends GetView<CreateSubmissionController> {
  const CreateSubmissionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const SekureAppBar(title: "Création d'un soumission"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomTextField(hint: "Nom du produit*"),
                  const CustomTextField(hint: "Prix du produit*"),
                  
                  // Dropdown Mockup
                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 55,
                    decoration: BoxDecoration(color: AppColors.inputFill, borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Acheteur*", style: GoogleFonts.poppins(color: Colors.grey[400])),
                        const Icon(Icons.keyboard_arrow_down, color: AppColors.primaryBlue)
                      ],
                    ),
                  ),

                  const CustomTextField(hint: "+ 229  01 XXX XXX XX"),
                  const CustomTextField(hint: "Adresse mail du vendeur*"),
                  
                  // Image Upload
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(color: const Color(0xFFDDE1EF), borderRadius: BorderRadius.circular(8)),
                    child: Text("Ajouter une image", style: GoogleFonts.poppins(color: AppColors.primaryBlue, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 5),
                  Text("Aucune image sélectionnée", style: GoogleFonts.poppins(fontSize: 12)),
                  
                  const SizedBox(height: 100), // Space
                  PrimaryButton(text: "Envoyer", onPressed: () => Get.back()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}