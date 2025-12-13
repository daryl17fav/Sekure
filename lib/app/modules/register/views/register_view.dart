import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/register_controller.dart';
import '../../../../widgets/common_widgets.dart';
import '../../../../utils/colors.dart';
import '../../../routes/app_pages.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

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
                      padding: const EdgeInsets.all(24),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                      ),
                      child: Column(
                        children: [
                          Text("Créez votre compte", style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 20),
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
                          
                          Align(alignment: Alignment.centerLeft, child: Text("Pièce d'identité*", style: GoogleFonts.poppins(fontWeight: FontWeight.w500))),
                          const SizedBox(height: 5),
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              children: [
                                 InkWell(
                                   onTap: controller.pickFile,
                                   child: Container(
                                     padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                     decoration: BoxDecoration(color: AppColors.buyerBlue, borderRadius: BorderRadius.circular(8)),
                                     child: Text("Ajouter un fichier", style: GoogleFonts.poppins(color: AppColors.primaryBlue, fontSize: 12)),
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

                          Obx(() => PrimaryButton(
                            text: controller.isLoading.value ? "Inscription..." : "S'inscrire",
                            onPressed: controller.isLoading.value ? null : () async {
                              // Call register and only navigate on success
                              await controller.register();
                              // Navigation will be handled after successful API response
                              // For now, navigate to verification if no errors
                              if (!controller.isLoading.value) {
                                Get.toNamed(
                                  Routes.VERIFICATION,
                                  arguments: {
                                    'role': 'buyer',
                                    'email': controller.emailController.text,
                                  },
                                );
                              }
                            },
                          )),
                          const SizedBox(height: 20),
                          // ... Include "Ou avec" and SocialRow and "Connectez-vous" similar to LoginView
                          const SocialLoginRow(),
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