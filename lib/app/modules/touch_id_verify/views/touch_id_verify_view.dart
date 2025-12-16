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
            child: Obx(() => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                color: controller.scanSuccess.value 
                  ? Colors.green.withValues(alpha: 0.1)
                  : controller.scanFailed.value
                    ? Colors.red.withValues(alpha: 0.1)
                    : const Color(0xFFE8EAF1),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: controller.isScanning.value 
                      ? Colors.blue.withValues(alpha: 0.3)
                      : Colors.black.withValues(alpha: 0.05),
                    blurRadius: controller.isScanning.value ? 30 : 20,
                    offset: const Offset(0, 10),
                  )
                ],
                gradient: controller.scanSuccess.value
                  ? null
                  : controller.scanFailed.value
                    ? null
                    : const LinearGradient(
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
                  Obx(() => Icon(
                    Icons.fingerprint,
                    size: 70,
                    color: controller.scanSuccess.value
                      ? Colors.green
                      : controller.scanFailed.value
                        ? Colors.red
                        : controller.isScanning.value
                          ? Colors.blue
                          : Colors.grey,
                  )),
                  const SizedBox(height: 10),
                  // Text
                  Obx(() => Text(
                    controller.scanSuccess.value
                      ? "Succès!"
                      : controller.scanFailed.value
                        ? "Échec"
                        : controller.isScanning.value
                          ? "Scanning..."
                          : "Touch ID",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: controller.scanSuccess.value
                        ? Colors.green
                        : controller.scanFailed.value
                          ? Colors.red
                          : Colors.black,
                    ),
                  )),
                ],
              ),
            )),
          ),
        ],

      ),
    );
  }
}