import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/submissions_controller.dart';
import '../../../../widgets/core_widgets.dart';
import '../../../../utils/colors.dart';
import '../../../routes/app_pages.dart';

class SubmissionsView extends GetView<SubmissionsController> {
  const SubmissionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const SekureAppBar(title: "Mes soumissions"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            // Create Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                onPressed: () => Get.toNamed(Routes.CREATE_SUBMISSION),
                icon: const Icon(Icons.add_box_outlined, color: Colors.white),
                label: Text("Créer une soumission", style: GoogleFonts.poppins(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 20),

            // Tabs
            Row(
              children: [
                _tab("Tous (05)", true),
                _tab("En attente (02)", false),
                _tab("Payés (03)", false),
              ],
            ),
            const SizedBox(height: 20),

            // List
            Expanded(
              child: ListView(
                children: const [
                  ItemCard(title: "Nom de l'article", subtitle: "M. Martins AZEMIN", price: "12.000 Fcfa", status: "En attente"),
                  ItemCard(title: "Nom de l'article", subtitle: "M. Martins AZEMIN", price: "12.000 Fcfa", status: "En attente"),
                  ItemCard(title: "Nom de l'article", subtitle: "M. Martins AZEMIN", price: "12.000 Fcfa", status: "En attente"),
                  ItemCard(title: "Nom de l'article", subtitle: "M. Martins AZEMIN", price: "12.000 Fcfa", status: "Payées"),
                  ItemCard(title: "Nom de l'article", subtitle: "M. Martins AZEMIN", price: "12.000 Fcfa", status: "Payées"),
                  ItemCard(title: "Nom de l'article", subtitle: "M. Martins AZEMIN", price: "12.000 Fcfa", status: "Expirées"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tab(String text, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryBlue.withOpacity(0.1) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          color: isSelected ? AppColors.primaryBlue : Colors.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}