import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/orders_controller.dart';
import '../../../../widgets/core_widgets.dart'; // For AppBar
import '../../../../utils/colors.dart';
import '../../../routes/app_pages.dart';
import '../../../../composants/list_composants.dart';

class OrdersView extends GetView<OrdersController> {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const SekureAppBar(title: "Bons de commandes"),
      body: Column(
        children: [
          const SizedBox(height: 10),
          // Horizontal Tabs
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Obx(() => Row(
              children: List.generate(4, (index) {
                return Obx(() => TabWidget(
                  text: controller.getTabLabel(index),
                  isSelected: controller.selectedTab.value == index,
                  onTap: () => controller.selectTab(index),
                  selectedColor: AppColors.primaryBlue.withOpacity(0.1),
                  unselectedColor: Colors.white,
                ));
              }),
            )),
          ),
          const SizedBox(height: 20),

          // Grid Content
          Expanded(
            child: Obx(() {
              if (controller.filteredOrders.isEmpty) {
                return Center(
                  child: Text(
                    'Aucune commande',
                    style: GoogleFonts.poppins(color: Colors.grey),
                  ),
                );
              }

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                  childAspectRatio: 0.75,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: controller.filteredOrders.length,
                itemBuilder: (context, index) {
                  final order = controller.filteredOrders[index];
                  
                  Color statusColor;
                  IconData statusIcon;

                  switch (order.status) {
                    case OrderStatus.paid:
                      statusColor = AppColors.successGreen;
                      statusIcon = Icons.check_circle;
                      break;
                    case OrderStatus.refused:
                      statusColor = AppColors.primaryRed;
                      statusIcon = Icons.cancel;
                      break;
                    case OrderStatus.pending:
                    default:
                      statusColor = AppColors.pendingOrange;
                      statusIcon = Icons.access_time_filled;
                      break;
                  }

                  return GridCard(
                    image: order.image,
                    productName: order.productName,
                    clientName: order.clientName,
                    price: order.formattedPrice,
                    statusColor: statusColor,
                    statusIcon: statusIcon,
                    onTap: () => Get.toNamed(Routes.ORDER_DETAILS, arguments: order),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }