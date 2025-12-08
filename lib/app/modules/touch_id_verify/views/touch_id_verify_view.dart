import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/touch_id_verify_controller.dart';
import '../../../../widgets/common_widgets.dart';
import '../../../../utils/colors.dart';

class TouchIdVerifyView extends GetView<TouchIdVerifyController> {
  const TouchIdVerifyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
           const Positioned(
            right: -100,
            top: 150,
            child: Opacity(
              opacity: 0.05,
              child: Icon(Icons.lock, size: 500, color: AppColors.primaryBlue),
            ),
          ),
          
          const Column(
            children: [
              SizedBox(height: 100),
              Center(child: SekureLogo(size: 50)),
            ],
          ),

          // 2. The Center Scanning Box
          Center(
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: const Color(0xFFE8EAF1), // The light grey/gradient box
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  )
                ],
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFF6F7F9),
                    Color(0xFFDDE1EF),
                  ],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Fingerprint Icon
                  const Icon(Icons.fingerprint, size: 70, color: Colors.grey),
                  const SizedBox(height: 10),
                  // Text
                  Text(
                    "Touch ID",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}