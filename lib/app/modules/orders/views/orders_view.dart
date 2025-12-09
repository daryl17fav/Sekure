import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/orders_controller.dart';
import '../../../../widgets/core_widgets.dart'; // For AppBar
import '../../../../utils/colors.dart';
import '../../../routes/app_pages.dart';

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
                return GestureDetector(
                  onTap: () => controller.selectTab(index),
                  child: Obx(() => _tab(
                    controller.getTabLabel(index),
                    controller.selectedTab.value == index,
                  )),
                );
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
                  return _buildGridCard(order);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  // Helper for Tabs
  Widget _tab(String text, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryBlue.withOpacity(0.1) : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          color: isSelected ? AppColors.primaryBlue : Colors.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  // Build grid card from order
  Widget _buildGridCard(OrderCommand order) {
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

    return GestureDetector(
      onTap: () => Get.toNamed(Routes.ORDER_DETAILS, arguments: order),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Area
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                  image: DecorationImage(
                    image: NetworkImage(order.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Text Area
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          order.productName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        Text(
                          order.clientName,
                          style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          order.formattedPrice,
                          style: GoogleFonts.poppins(color: statusColor, fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                        Icon(statusIcon, color: statusColor, size: 16),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}