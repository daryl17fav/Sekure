import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/create_password_controller.dart';
import '../../../../widgets/common_widgets.dart';
import '../../../../utils/colors.dart';

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
                  Obx(() => CustomTextField(
                    hint: "Mot de passe*",
                    controller: controller.passwordController,
                    isPassword: !controller.isPasswordVisible.value,
                    suffixIcon: controller.isPasswordVisible.value ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    onSuffixIconTap: controller.togglePasswordVisibility,
                  )),
                  Obx(() => CustomTextField(
                    hint: "Confirmer le mot de passe*",
                    controller: controller.confirmPasswordController,
                    isPassword: !controller.isConfirmPasswordVisible.value,
                    suffixIcon: controller.isConfirmPasswordVisible.value ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    onSuffixIconTap: controller.toggleConfirmPasswordVisibility,
                  )),
                  const SizedBox(height: 10),
                  Obx(() => PrimaryButton(
                    text: controller.isLoading.value ? "Sécurisation..." : "Sécuriser",
                    onPressed: controller.isLoading.value ? null : () async {
                      // Call createPassword - it will handle validation
                      await controller.createPassword();
                      // Only navigate if password creation was successful
                      // The controller will show error snackbars if validation fails
                    },
                  )),
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