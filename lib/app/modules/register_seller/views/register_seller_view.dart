import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/register_seller_controller.dart';
import '../../../../widgets/common_widgets.dart'; 
import '../../../../utils/colors.dart';
import '../../../routes/app_pages.dart';

class RegisterSellerView extends GetView<RegisterSellerController> {
  const RegisterSellerView({super.key});

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
                    const SizedBox(height: 40),
                    const SekureLogo(),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                      ),
                      child: Column(
                        children: [
                          Text(
                            "Créez votre compte",
                            style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.textDark),
                          ),
                          const SizedBox(height: 20),
                          
                          // Form Fields
                          CustomTextField(
                            hint: "Nom complet*",
                            controller: controller.nameController,
                          ),
                          CustomTextField(
                            hint: "+ 229  01 XXX XXX XX",
                            controller: controller.phoneController,
                            keyboardType: TextInputType.phone,
                          ),
                          CustomTextField(
                            hint: "Adresse mail*",
                            controller: controller.emailController,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          CustomTextField(
                            hint: "Localisation*",
                            controller: controller.locationController,
                          ),
                          
                          // File Upload Section
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Pièce d'identité*", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 13, color: AppColors.textDark)),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            margin: const EdgeInsets.only(bottom: 25),
                            child: Row(
                              children: [
                                 InkWell(
                                   onTap: controller.pickFile,
                                   child: Container(
                                     padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                     decoration: BoxDecoration(
                                       color: AppColors.buyerBlue,
                                       borderRadius: BorderRadius.circular(8),
                                     ),
                                     child: Text(
                                       "Ajouter un fichier",
                                       style: GoogleFonts.poppins(color: AppColors.primaryBlue, fontSize: 12, fontWeight: FontWeight.w600),
                                     ),
                                   ),
                                 ),
                                 const SizedBox(width: 10),
                                 Expanded(
                                   child: Obx(() => Text(
                                     controller.selectedFile.value ?? "Aucun fichier sélectionné",
                                     style: GoogleFonts.poppins(
                                       fontSize: 12,
                                       color: controller.selectedFile.value != null ? AppColors.primaryBlue : AppColors.textDark,
                                       fontWeight: controller.selectedFile.value != null ? FontWeight.w600 : FontWeight.normal,
                                     ),
                                     overflow: TextOverflow.ellipsis,
                                   )),
                                 ),
                              ],
                            ),
                          ),

                          // Submit Button
                          Obx(() => PrimaryButton(
                            text: controller.isLoading.value ? "Inscription..." : "S'inscrire",
                            onPressed: controller.isLoading.value ? null : () {
                              controller.register();
                              // After successful registration, navigate with email
                              Future.delayed(const Duration(milliseconds: 1500), () {
                                if (!controller.isLoading.value) {
                                  Get.toNamed(
                                    Routes.VERIFICATION,
                                    arguments: {
                                      'role': 'seller',
                                      'email': controller.emailController.text,
                                    },
                                  );
                                }
                              });
                            },
                          )),
                          
                          const SizedBox(height: 20),
                          
                          // Divider
                          Row(
                            children: [
                              const Expanded(child: Divider()),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Text("ou avec", style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
                              ),
                              const Expanded(child: Divider()),
                            ],
                          ),
                          const SizedBox(height: 15),
                          
                          // Social Icons
                          const SocialLoginRow(),
                          
                          const SizedBox(height: 20),
                          
                          // Login Link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Vous possédez déjà un compte ? ", style: GoogleFonts.poppins(fontSize: 12)),
                              GestureDetector(
                                onTap: () => Get.offNamed(Routes.LOGIN),
                                child: Text(
                                  "Connectez-vous",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryBlue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ],
                          )
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