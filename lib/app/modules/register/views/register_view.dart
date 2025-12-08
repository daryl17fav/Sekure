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
                          const CustomTextField(hint: "Nom complet*"),
                          const CustomTextField(hint: "+ 229  01 XXX XXX XX"),
                          const CustomTextField(hint: "Adresse mail*"),
                          const CustomTextField(hint: "Localisation*"),
                          
                          Align(alignment: Alignment.centerLeft, child: Text("Pièce d'identité*", style: GoogleFonts.poppins(fontWeight: FontWeight.w500))),
                          const SizedBox(height: 5),
                          Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              children: [
                                 Container(
                                   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                   decoration: BoxDecoration(color: AppColors.buyerBlue, borderRadius: BorderRadius.circular(8)),
                                   child: Text("Ajouter un fichier", style: GoogleFonts.poppins(color: AppColors.primaryBlue, fontSize: 12)),
                                 ),
                                 const SizedBox(width: 10),
                                 Text("Aucun fichier sélectionné", style: GoogleFonts.poppins(fontSize: 12)),
                              ],
                            ),
                          ),

                          PrimaryButton(text: "S'inscrire", onPressed: () => Get.toNamed(Routes.VERIFICATION, arguments: 'buyer')),
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