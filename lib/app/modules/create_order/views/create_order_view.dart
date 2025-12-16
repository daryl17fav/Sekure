import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/create_order_controller.dart';
import '../../../../widgets/core_widgets.dart';
import '../../../../widgets/common_widgets.dart';
import '../../../../utils/colors.dart';
import '../../../../composants/form_composants.dart';

class CreateOrderView extends GetView<CreateOrderController> {
  const CreateOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const SekureAppBar(title: "Nouveau bon de commande"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: FormContainer(
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
              Obx(() => VendorPickerField(
                selectedVendor: controller.selectedVendor.value,
                vendors: controller.vendors,
                onVendorSelected: controller.selectVendor,
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
              Obx(() => ImageUploadButton(
                selectedImageName: controller.selectedImage.value,
                onTap: controller.pickImage,
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
}