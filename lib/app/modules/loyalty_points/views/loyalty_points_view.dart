import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/loyalty_points_controller.dart';
import '../../../../widgets/core_widgets.dart';
import '../../../../utils/colors.dart';

class LoyaltyPointsView extends GetView<LoyaltyPointsController> {
  const LoyaltyPointsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Gradient Background
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF2B3384), // Primary Blue
              Color(0xFF3F48CC), // Slightly Lighter Blue
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom AppBar
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    IconButton(icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18), onPressed: () => Get.back()),
                    const Expanded(
                      child: Center(
                        child: Text("Mes points & Avantages", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                    ),
                    const SizedBox(width: 40), // Balance the arrow
                  ],
                ),
              ),

              const Spacer(),

              // The Big Star
              SizedBox(
                width: 300,
                height: 300,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Background Glow/Stars
                    const Positioned(top: 20, left: 20, child: Icon(Icons.star, color: Colors.yellow, size: 30)),
                    const Positioned(top: 40, right: 30, child: Icon(Icons.star, color: Colors.yellow, size: 20)),
                    const Positioned(bottom: 50, left: 40, child: Icon(Icons.star, color: Colors.yellow, size: 25)),
                    const Positioned(bottom: 80, right: 20, child: Icon(Icons.star, color: Colors.yellow, size: 20)),

                    // Main Star (Using a large Icon with shadow/outline simulation)
                    // Note: Ideally use an SVG asset here. 
                    // Simulating outline with a stack of icons for code-only solution.
                    const Icon(Icons.star_rounded, size: 280, color: Colors.white), // Border
                    const Icon(Icons.star_rounded, size: 260, color: Color(0xFFFFEB3B)), // Main Yellow

                    // Text inside Star
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("350", style: GoogleFonts.poppins(fontSize: 48, fontWeight: FontWeight.bold, color: AppColors.primaryBlue, height: 1.0)),
                        Text("Points", style: GoogleFonts.poppins(fontSize: 16, color: AppColors.primaryBlue, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Bottom Button
              Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {},
                    child: Text("Mes avantages", style: GoogleFonts.poppins(color: AppColors.primaryBlue, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}