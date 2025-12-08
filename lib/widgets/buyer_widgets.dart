import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';
import '../app/routes/app_pages.dart';

class SekureDrawerBuyer extends StatelessWidget {
  const SekureDrawerBuyer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primaryBlue,
      child: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Get.back(),
              ),
            ),
            // Profile
            const CircleAvatar(
              radius: 45,
              backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=8'), // Different avatar for buyer
            ),
            const SizedBox(height: 15),
            Text("John Evian Sultan DEMAGU", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
            Text("@joevisul_demagu", style: GoogleFonts.poppins(color: Colors.white70, fontSize: 12)),
            const SizedBox(height: 30),
            
            // Menu Container
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  _drawerItem(Icons.person_outline, "Profil", () {}),
                  _drawerItem(Icons.receipt_long, "Mes bons de commande", () => Get.toNamed(Routes.BUYER_ORDERS_LIST)),
                  _drawerItem(Icons.shopping_bag_outlined, "Mes commandes", () => Get.toNamed(Routes.MY_ORDERS)),
                  _drawerItem(Icons.star, "Mes points & Avantages", () => Get.toNamed(Routes.LOYALTY_POINTS)),
                  _drawerItem(Icons.gavel, "Litiges", () => Get.toNamed(Routes.DISPUTES)),
                ],
              ),
            ),
            const Spacer(),
            // Logout
            Container(
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryRed.withOpacity(0.8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                icon: const Icon(Icons.logout, color: Colors.white),
                label: Text("Se déconnecter", style: GoogleFonts.poppins(color: Colors.white)),
                onPressed: () => Get.offAllNamed(Routes.LOGIN),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white, size: 22),
      title: Text(title, style: GoogleFonts.poppins(color: Colors.white, fontSize: 14)),
      onTap: onTap,
    );
  }
}