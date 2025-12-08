import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/create_dispute_controller.dart';
import '../../../../widgets/core_widgets.dart';
import '../../../../widgets/common_widgets.dart';
import '../../../../utils/colors.dart';

class CreateDisputeView extends GetView<CreateDisputeController> {
  const CreateDisputeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Appears white in screenshot
      appBar: const SekureAppBar(title: "Contester la commande"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTextField(hint: "Numero de commande"),
            
            // TextArea
            Container(
              height: 120,
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.inputFill,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Quels problèmes rencontre-vous ?",
                  hintStyle: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 14),
                  border: InputBorder.none,
                ),
              ),
            ),

            Text("Preuves*", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 10),
            
            // File Uploader Row
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)),
                  child: Text("Importer des fichiers", style: GoogleFonts.poppins(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 10),
                Text("Aucun fichier sélectionné", style: GoogleFonts.poppins(fontSize: 11)),
              ],
            ),
            
            const SizedBox(height: 250), // Spacer to push button down
            
            PrimaryButton(text: "Envoyer", onPressed: () => Get.back()),
          ],
        ),
      ),
    );
  }
}