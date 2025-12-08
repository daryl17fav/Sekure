import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/my_orders_controller.dart';
import '../../../../widgets/core_widgets.dart'; // Uses the ItemCard we made earlier
import '../../../../utils/colors.dart';

class MyOrdersView extends GetView<MyOrdersController> {
  const MyOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const SekureAppBar(title: "Mes commandes"),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Section 1: Today
          _sectionHeader("Aujourd'hui"),
          const ItemCard(title: "Nom de l'article", subtitle: "Nom du client", price: "12K Fcfa"),
          const ItemCard(title: "Nom de l'article", subtitle: "Nom du client", price: "12K Fcfa"),
          const ItemCard(title: "Nom de l'article", subtitle: "Nom du client", price: "12K Fcfa"),
          
          const SizedBox(height: 10),

          // Section 2: Yesterday
          _sectionHeader("Hier"),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: const Color(0xFFF0F2F6), borderRadius: BorderRadius.circular(16)), // The slightly darker background one in the image
            child: Row(
              children: [
                 Container(
                   width: 50, height: 50,
                   decoration: BoxDecoration(color: const Color(0xFFE4D4C8), borderRadius: BorderRadius.circular(10)),
                   child: const Icon(Icons.inventory_2_outlined, color: Colors.brown),
                 ),
                 const SizedBox(width: 15),
                 Expanded(
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text("Nom de l'article", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                       Text("Nom du client", style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
                     ],
                   ),
                 ),
                 Text("12K Fcfa", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          
          const SizedBox(height: 20),

          // Section 3: Specific Date
          _sectionHeader("Vendredi 17 Août 2025"),
          const ItemCard(title: "Nom de l'article", subtitle: "Nom du client", price: "12K Fcfa"),
          const ItemCard(title: "Nom de l'article", subtitle: "Nom du client", price: "12K Fcfa"),
          const ItemCard(title: "Nom de l'article", subtitle: "Nom du client", price: "12K Fcfa"),

           const SizedBox(height: 20),

          // Section 4: Another Date
          _sectionHeader("Lundi 23 Décembre 2024"),
          const ItemCard(title: "Nom de l'article", subtitle: "Nom du client", price: "12K Fcfa"),
        ],
      ),
    );
  }

  Widget _sectionHeader(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 5),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: Colors.grey,
        ),
      ),
    );
  }
}