import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/orders_controller.dart';
import '../../../../widgets/core_widgets.dart'; // For AppBar
import '../../../../utils/colors.dart';
import '../../../routes/app_pages.dart';

class OrdersView extends GetView<OrdersController> {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const SekureAppBar(title: "Bons de commandes"),
      body: Column(
        children: [
          const SizedBox(height: 10),
          // Horizontal Tabs
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                _tab("Tous (05)", false), // Example state
                _tab("En attente (02)", true), // Selected state example
                _tab("Payés (02)", false),
                _tab("Refusés (01)", false),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Grid Content
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              childAspectRatio: 0.75, // Adjusts height/width ratio
              children: [
                _buildGridCard("Nom de l'article", "Nom du client", "12.000 Fcfa", 0), // Pending
                _buildGridCard("Nom de l'article", "Nom du client", "12.000 Fcfa", 0), // Pending
                _buildGridCard("Nom de l'article", "Nom du client", "12.000 Fcfa", 1), // Paid
                _buildGridCard("Nom de l'article", "Nom du client", "12.000 Fcfa", 1), // Paid
                _buildGridCard("Nom de l'article", "Nom du client", "12.000 Fcfa", 2), // Rejected/Expired
                _buildGridCard("Nom de l'article", "Nom du client", "12.000 Fcfa", 2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper for Tabs
  Widget _tab(String text, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryBlue.withOpacity(0.1) : Colors.white,
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

  // 0 = Pending, 1 = Paid, 2 = Rejected
  Widget _buildGridCard(String title, String subtitle, String price, int status) {
    Color statusColor;
    IconData statusIcon;

    switch (status) {
      case 1:
        statusColor = AppColors.successGreen;
        statusIcon = Icons.check_circle;
        break;
      case 2:
        statusColor = AppColors.primaryRed;
        statusIcon = Icons.cancel;
        break;
      case 0:
      default:
        statusColor = AppColors.pendingOrange;
        statusIcon = Icons.access_time_filled;
        break;
    }

    return GestureDetector(
      onTap: () => Get.toNamed(Routes.ORDER_DETAILS),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Area
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                  image: const DecorationImage(
                    image: NetworkImage('https://i.pravatar.cc/150?img=5'), // Placeholder
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Text Area
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 13)),
                        Text(subtitle, style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(price, style: GoogleFonts.poppins(color: statusColor, fontWeight: FontWeight.bold, fontSize: 13)),
                        Icon(statusIcon, color: statusColor, size: 16),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}