import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/create_order_controller.dart';
import '../../../../widgets/core_widgets.dart';
import '../../../../widgets/common_widgets.dart';
import '../../../../utils/colors.dart';

class CreateOrderView extends GetView<CreateOrderController> {
  const CreateOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const SekureAppBar(title: "Nouveau bon de commande"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                hint: "Nom du produit*",
                controller: controller.productNameController,
              ),
              CustomTextField(
                hint: "Prix du produit*",
                controller: controller.priceController,
                keyboardType: TextInputType.number,
              ),
              
              // Vendor Dropdown
              Obx(() => GestureDetector(
                onTap: () => _showVendorPicker(context),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 55,
                  decoration: BoxDecoration(
                    color: AppColors.inputFill,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controller.selectedVendor.value ?? "Vendeur*",
                        style: GoogleFonts.poppins(
                          color: controller.selectedVendor.value != null
                              ? Colors.black
                              : Colors.grey[400],
                        ),
                      ),
                      const Icon(Icons.keyboard_arrow_down, color: AppColors.primaryBlue),
                    ],
                  ),
                ),
              )),

              CustomTextField(
                hint: "+ 229  01 XXX XXX XX",
                controller: controller.phoneController,
                keyboardType: TextInputType.phone,
              ),
              CustomTextField(
                hint: "Adresse mail du vendeur*",
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              CustomTextField(
                hint: "Lien du produit*",
                controller: controller.productLinkController,
              ),

              // Image Upload
              GestureDetector(
                onTap: controller.pickImage,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDDE1EF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "Ajouter une image",
                    style: GoogleFonts.poppins(
                      color: AppColors.primaryBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Obx(() => Text(
                controller.selectedImage.value ?? "Aucune image sélectionnée",
                style: GoogleFonts.poppins(fontSize: 11),
              )),
              
              const SizedBox(height: 50),
              Obx(() => PrimaryButton(
                text: controller.isLoading.value ? "Envoi..." : "Envoyer",
                onPressed: controller.isLoading.value ? null : controller.createOrder,
              )),
            ],
          ),
        ),
      ),
    );
  }

  /// Show vendor picker bottom sheet
  void _showVendorPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Sélectionner un vendeur",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ...controller.vendors.map((vendor) {
                return ListTile(
                  title: Text(vendor, style: GoogleFonts.poppins()),
                  onTap: () {
                    controller.selectVendor(vendor);
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }
}