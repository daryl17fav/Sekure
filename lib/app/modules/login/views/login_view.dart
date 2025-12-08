import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/login_controller.dart';
import '../../../../widgets/common_widgets.dart';
import '../../../../utils/colors.dart';
import '../../../routes/app_pages.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

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
                    const SekureLogo(size: 40),
                    const Spacer(),
                    // White Container
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Vous revoilà !!!", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)),
                          const SizedBox(height: 10),
                          Text("Prêt à poursuivre vos transactions ?\nVous y êtes presque...", 
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87)
                          ),
                          const SizedBox(height: 25),
                          const CustomTextField(hint: "Adresse mail*"),
                          const CustomTextField(hint: "****************", isPassword: true, suffixIcon: Icons.visibility_off_outlined),
                          
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text("Mot de passe oublié ?", style: GoogleFonts.poppins(color: AppColors.primaryRed, fontSize: 12, decoration: TextDecoration.underline)),
                          ),
                          Row(
                            children: [
                              Checkbox(value: false, onChanged: (v) {}),
                              Text("Se souvenir de moi", style: GoogleFonts.poppins(fontSize: 12, color: AppColors.primaryBlue)),
                            ],
                          ),
                          const SizedBox(height: 15),
                          PrimaryButton(text: "Se connecter", onPressed: () => Get.toNamed(Routes.HOME)),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const Expanded(child: Divider()),
                              Padding(padding: const EdgeInsets.symmetric(horizontal: 10), child: Text("ou avec", style: GoogleFonts.poppins(fontSize: 12))),
                              const Expanded(child: Divider()),
                            ],
                          ),
                          const SizedBox(height: 15),
                          const SocialLoginRow(),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Vous ne possédez pas de compte ? ", style: GoogleFonts.poppins(fontSize: 12)),
                              GestureDetector(
                                onTap: () => Get.toNamed(Routes.ROLE_SELECTION),
                                child: Text("Inscrivez-vous", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primaryBlue, decoration: TextDecoration.underline)),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
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