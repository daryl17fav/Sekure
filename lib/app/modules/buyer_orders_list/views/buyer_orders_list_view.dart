import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/buyer_orders_list_controller.dart';
import '../../../../widgets/core_widgets.dart';
import '../../../../utils/colors.dart';
import '../../../routes/app_pages.dart';
import '../../../../composants/list_composants.dart';

class BuyerOrdersListView extends GetView<BuyerOrdersListController> {
  const BuyerOrdersListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const SekureAppBar(title: "Mes bons de commandes"),
      body: Column(
        children: [
          const SizedBox(height: 20),
          // Create New Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                onPressed: () => Get.toNamed(Routes.CREATE_ORDER),
                icon: const Icon(Icons.add_box_outlined, color: Colors.white, size: 20),
                label: Text("Nouveau bon de commande", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Horizontal Tabs
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            clipBehavior: Clip.none,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Obx(() => Row(
              children: [
                ...List.generate(
                  controller.tabs.length,
                  (index) => TabWidget(
                    text: "${controller.tabs[index]} (${controller.getTabCount(index).toString().padLeft(2, '0')})",
                    isSelected: controller.selectedTabIndex.value == index,
                    onTap: () => controller.selectTab(index),
                  ),
                ),
                const SizedBox(width: 20), // Extra space at the end to prevent overflow
              ],
            )),
          ),
          const SizedBox(height: 20),

          // List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const ListShimmerLoader(itemCount: 5, itemHeight: 100);
              }
              
              final orders = controller.filteredOrders;
              
              if (orders.isEmpty) {
                return Center(
                  child: Text(
                    "Aucune commande",
                    style: GoogleFonts.poppins(color: Colors.grey, fontSize: 16),
                  ),
                );
              }
              
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return ItemCard(
                    title: order['title']!,
                    subtitle: order['subtitle']!,
                    price: order['price']!,
                    status: order['status']!,
                  );
                },
              );
            }),
          )
        ],
      ),
    );
  }