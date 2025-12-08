import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/verification_controller.dart';
import '../../../../widgets/common_widgets.dart';
import '../../../../utils/colors.dart';
import '../../../routes/app_pages.dart';

class VerificationView extends GetView<VerificationController> {
  const VerificationView({super.key});

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
          const SizedBox(height: 100),
          const SekureLogo(size: 50),
          const Spacer(),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              children: [
                Text("Vérification", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text("Veuillez entrer le code envoyé à\nl'adresse abc...xyz@gmail.com", textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 13)),
                Text("C'est bien vous, n'est-ce pas ?", textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold)),
                const SizedBox(height: 25),
                
                // OTP Boxes
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(5, (index) => _otpBox()),
                ),
                
                const SizedBox(height: 20),
                Text("Vous n'avez pas reçu de mail ? Renvoyer (00:59)", style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12, decoration: TextDecoration.underline)),
                const SizedBox(height: 20),
                 const SizedBox(height: 20),
                PrimaryButton(
                  text: "Vérifier", 
                  onPressed: () {
                    // Pass the role argument forward
                    final String? role = Get.arguments as String?;
                    Get.toNamed(Routes.CREATE_PASSWORD, arguments: role);
                  },
                ),
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

  Widget _otpBox() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(color: AppColors.inputFill, borderRadius: BorderRadius.circular(8)),
      alignment: Alignment.center,
      child: const Text("--", style: TextStyle(fontSize: 18, color: Colors.grey)),
    );
  }
}