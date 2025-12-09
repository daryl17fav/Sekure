import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/my_orders_controller.dart';
import '../../../../widgets/core_widgets.dart';
import '../../../../utils/colors.dart';

class MyOrdersView extends GetView<MyOrdersController> {
  const MyOrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const SekureAppBar(title: "Mes commandes"),
      body: Obx(() {
        if (controller.groupedOrders.isEmpty) {
          return Center(
            child: Text(
              'Aucune commande',
              style: GoogleFonts.poppins(color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(20),
          itemCount: controller.groupedOrders.length,
          itemBuilder: (context, index) {
            final dateKey = controller.groupedOrders.keys.elementAt(index);
            final orders = controller.groupedOrders[dateKey]!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Date Header
                _sectionHeader(dateKey),
                
                // Orders for this date
                ...orders.map((order) {
                  // Special styling for "Hier" section (darker background)
                  if (dateKey == "Hier") {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F2F6),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE4D4C8),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.inventory_2_outlined,
                              color: Colors.brown,
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  order.productName,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  order.clientName,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            order.formattedPrice,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  
                  // Regular ItemCard for other dates
                  return ItemCard(
                    title: order.productName,
                    subtitle: order.clientName,
                    price: order.formattedPrice,
                  );
                }).toList(),
                
                const SizedBox(height: 10),
              ],
            );
          },
        );
      }),
    );
  }

  Widget _sectionHeader(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 5),
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: Colors.grey,
        ),
      ),
    );
  }
}