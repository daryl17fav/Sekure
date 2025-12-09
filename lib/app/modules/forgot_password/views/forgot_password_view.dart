import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/forgot_password_controller.dart';
import '../../../../widgets/common_widgets.dart'; 
import '../../../../utils/colors.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return SekureBackground(
      child: Column(
        children: [
           const SizedBox(height: 100),
           const SekureLogo(size: 50),    
           const Spacer(),
                    Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                Text(
                  "Mot de passe oublié",
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 10),
                
                // Description Text
                Text(
                  "Vous avez oublié votre mot de passe.\nVous recevrez un mail de\nréinitialisation !",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: AppColors.textDark,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 30),
                
                // Email Input
                CustomTextField(
                  hint: "Adresse mail*",
                  controller: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                ),
                
                const SizedBox(height: 20),
                
                // Send Button
                Obx(() => PrimaryButton(
                  text: controller.isLoading.value ? "Envoi..." : "Envoyer",
                  onPressed: controller.isLoading.value ? null : controller.sendResetEmail,
                )),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}