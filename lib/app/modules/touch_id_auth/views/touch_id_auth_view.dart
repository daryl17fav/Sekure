import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/touch_id_auth_controller.dart';
import '../../../../widgets/common_widgets.dart';
import '../../../../utils/colors.dart';

class TouchIdAuthView extends GetView<TouchIdAuthController> {
  const TouchIdAuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return SekureBackground(
      child: Column(
        children: [
          const SizedBox(height: 100),
          const SekureLogo(size: 50),
          const Spacer(),
          
          // White Bottom Sheet
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              children: [
                Text(
                  "Touch ID",
                  style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textDark),
                ),
                const SizedBox(height: 15),
                Text(
                  "Autorisez l'accès à Touch ID pour un\nune connexion plus sécurisé et rapide.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(fontSize: 14, color: AppColors.textDark),
                ),
                const SizedBox(height: 40),
                
                // Fingerprint Icon (Tappable)
                GestureDetector(
                  onTap: controller.authorizeTouchId,
                  child: Container(
                     padding: const EdgeInsets.all(10),
                     child: const Icon(
                       Icons.fingerprint, 
                       size: 80, 
                       color: AppColors.textDark,
                     ),
                  ),
                ),
                const SizedBox(height: 30),
                
                // Skip Button
                TextButton(
                  onPressed: controller.skipTouchId,
                  child: Text(
                    "Plus tard",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],

            ),
          ),
        ],
      ),
    );
  }
}