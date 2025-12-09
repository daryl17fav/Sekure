import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/role_selection_controller.dart';
import '../../../../widgets/common_widgets.dart';
import '../../../../utils/colors.dart';
import '../../../routes/app_pages.dart';

class RoleSelectionView extends GetView<RoleSelectionController> {
  const RoleSelectionView({super.key});

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
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: Column(
              children: [
                Text("Créez votre compte", style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text("On sécurise vos transactions en ligne\nquelques soient votre profil.\nÊtes-vous prêt ?", textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 13)),
                const SizedBox(height: 20),
                Text("Quel est votre objectif sur\nSékurePay ?", textAlign: TextAlign.center, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 20),
                
                // Seller Button
                _buildRoleButton("Vendeur", AppColors.sellerPink, AppColors.primaryRed, onTap: controller.selectSellerRole),
                const SizedBox(height: 15),
                // Buyer Button
                _buildRoleButton("Acheteur", AppColors.buyerBlue, AppColors.primaryBlue, onTap: controller.selectBuyerRole),
                
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Vous possédez déjà un compte ? ", style: GoogleFonts.poppins(fontSize: 12)),
                    GestureDetector(
                      onTap: controller.goToLogin,
                      child: Text("Connectez-vous", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primaryBlue, decoration: TextDecoration.underline)),
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

  Widget _buildRoleButton(String label, Color bg, Color text, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
        alignment: Alignment.center,
        child: Text(label, style: GoogleFonts.poppins(color: text, fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }
}