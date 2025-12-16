import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/verification_controller.dart';
import '../../../../widgets/common_widgets.dart';
import '../../../../utils/colors.dart';


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
                Obx(() => Text(
                  "Veuillez entrer le code envoyé à\nl'adresse ${controller.maskedEmail.value}",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(fontSize: 13),
                )),
                Text("C'est bien vous, n'est-ce pas ?", textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold)),
                const SizedBox(height: 25),
                
                // OTP Boxes - Interactive
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _otpBox(controller.otp1Controller, controller.otp1Focus, 1),
                    _otpBox(controller.otp2Controller, controller.otp2Focus, 2),
                    _otpBox(controller.otp3Controller, controller.otp3Focus, 3),
                    _otpBox(controller.otp4Controller, controller.otp4Focus, 4),
                    _otpBox(controller.otp5Controller, controller.otp5Focus, 5),
                  ],
                ),
                
                const SizedBox(height: 20),
                Obx(() => GestureDetector(
                  onTap: controller.canResend.value ? controller.resendOTP : null,
                  child: Text(
                    controller.canResend.value
                        ? "Vous n'avez pas reçu de mail ? Renvoyer"
                        : "Vous n'avez pas reçu de mail ? Renvoyer (${controller.timerDisplay})",
                    style: GoogleFonts.poppins(
                      color: controller.canResend.value ? AppColors.primaryBlue : Colors.grey,
                      fontSize: 12,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )),
                const SizedBox(height: 20),
                Obx(() => PrimaryButton(
                  text: controller.isVerifying.value ? "Vérification..." : "Vérifier",
                  onPressed: controller.isVerifying.value ? null : () async {
                    // Call verifyOTP - it will handle validation
                    await controller.verifyOTP();
                    // Only navigate if OTP verification was successful
                    // The controller will show error snackbars if validation fails
                  },
                )),
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


  Widget _otpBox(TextEditingController textController, FocusNode focusNode, int index) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: textController,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        onChanged: (value) => controller.onOTPChanged(value, index),
      ),
    );
  }

}