import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/disputes_controller.dart';
import '../../../../widgets/core_widgets.dart';
import '../../../../utils/colors.dart';

class DisputesView extends GetView<DisputesController> {
  const DisputesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const SekureAppBar(title: "Litiges"),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Tabs
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _tab("Tous (05)", true),
                _tab("En attente (02)", false),
                _tab("Réglées (02)", false),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Grid
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 0.75,
              children: List.generate(6, (index) => _buildDisputeCard()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tab(String text, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFDDE1EF) : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          color: isSelected ? AppColors.primaryBlue : Colors.grey,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 13
        ),
      ),
    );
  }

  Widget _buildDisputeCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                image: const DecorationImage(
                  image: NetworkImage('https://i.pravatar.cc/150?img=33'), // Placeholder
                  fit: BoxFit.cover
                ),
              ),
            ),
          ),
          // Info
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Nom de l'article", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 13)),
                  Text("M. Martins AZEMIN", style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey)),
                  const SizedBox(height: 5),
                  Text("12.000 Fcfa", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}