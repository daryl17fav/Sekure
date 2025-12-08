import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/create_password_controller.dart';
import '../../../../widgets/common_widgets.dart';
import '../../../../utils/colors.dart';
import '../../../routes/app_pages.dart';

class CreatePasswordView extends GetView<CreatePasswordController> {
  const CreatePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SekureBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
              ),
              child: IntrinsicHeight(
                child: Column(
        children: [
          const SizedBox(height: 60),
          const SekureLogo(),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
                children: [
                  Text("Mot de passe", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text("Protégeons votre compte et vos sous.\nEt c'est terminé.", textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 13)),
                  const SizedBox(height: 15),
                  Text("Votre mot de passe doit contenir au minimum 8 caractères, au moins une lettre MAJUSCULE, un chiffre et un caractère spécial (@#_...)", 
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(color: AppColors.primaryRed, fontSize: 11)
                  ),
                  const SizedBox(height: 20),
                  const CustomTextField(hint: "Mot de passe*", isPassword: true, suffixIcon: Icons.visibility_outlined),
                  const CustomTextField(hint: "Confirmer le mot de passe*", isPassword: true, suffixIcon: Icons.visibility_outlined),
                  const SizedBox(height: 10),
                  PrimaryButton(
                    text: "Sécuriser", 
                    onPressed: () {
                      // Get the role from arguments passed through navigation
                      final String? role = Get.arguments as String?;
                      
                      // Navigate based on role
                      if (role == 'seller') {
                        Get.toNamed(Routes.TOUCH_ID_AUTH);
                      } else {
                        // Default to Face ID for buyers
                        Get.toNamed(Routes.FACE_ID);
                      }
                    },
                  ),
                ],
              ),
          ),
        ],
      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}