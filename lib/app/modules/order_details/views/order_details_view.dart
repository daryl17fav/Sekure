import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/order_details_controller.dart';
import '../../../../widgets/core_widgets.dart';
import '../../../../utils/colors.dart';

class OrderDetailsView extends GetView<OrderDetailsController> {
  const OrderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Obx(() => SekureAppBar(
          title: "Commande ${controller.orderNumber.value}",
        )),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Articles Section
            Text(
              "Articles",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            
            // Product Card
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  // Product Image
                  Obx(() => Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: NetworkImage(controller.productImage.value),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )),
                  const SizedBox(width: 12),
                  
                  // Product Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() => Text(
                          controller.productName.value,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        )),
                        Obx(() => Text(
                          controller.clientName.value,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        )),
                      ],
                    ),
                  ),
                  
                  // Price
                  Obx(() => Text(
                    controller.formattedPrice,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  )),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Transaction Details
            Text(
              "Détails de la transaction",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Date",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      "Transaction ID",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Obx(() => Text(
                      controller.transactionDate.value,
                      style: GoogleFonts.poppins(fontSize: 13),
                    )),
                    Obx(() => Text(
                      controller.transactionId.value,
                      style: GoogleFonts.poppins(fontSize: 13),
                    )),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Delivery Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Livraison",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                Obx(() => Text(
                  controller.deliveryStatus.value,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ],
            ),
            const SizedBox(height: 10),
            
            // Delivery Address
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.green,
                    size: 24,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Adresse de livraison",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        Obx(() => Text(
                          controller.deliveryAddress.value,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.grey[700],
                          ),
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Order Tracking Timeline
            Text(
              "Suivi de commande",
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 15),
            
            // Timeline Stages
            Obx(() => Column(
              children: [
                _buildTimelineStage(0, controller.isStageCurrent(0)),
                _buildTimelineStage(1, controller.isStageCurrent(1)),
                _buildTimelineStage(2, controller.isStageCurrent(2)),
                _buildTimelineStage(3, controller.isStageCurrent(3)),
                _buildTimelineStage(4, controller.isStageCurrent(4)),
                if (controller.currentStage.value >= 5)
                  _buildTimelineStage(5, controller.isStageCurrent(5)),
              ],
            )),
            
            const SizedBox(height: 30),

            // Action Button (only show if in Payée stage)
            Obx(() {
              if (controller.currentStage.value == 1) {
                return SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: controller.isProcessing.value
                        ? null
                        : controller.showLivraisonDialog,
                    child: Text(
                      controller.isProcessing.value
                          ? "Traitement..."
                          : "Colis expédié",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              } else if (controller.currentStage.value == 2) {
                return SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: controller.isProcessing.value
                        ? null
                        : controller.markAsDelivered,
                    child: Text(
                      controller.isProcessing.value
                          ? "Traitement..."
                          : "Commande livrée",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }

  /// Build timeline stage
  Widget _buildTimelineStage(int stage, bool isCurrent) {
    final isCompleted = controller.isStageCompleted(stage);
    final isActive = isCurrent || isCompleted;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stage Indicator
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: isActive ? AppColors.primaryBlue : Colors.grey[300],
                  shape: BoxShape.circle,
                ),
              ),
              if (stage < 5)
                Container(
                  width: 2,
                  height: 40,
                  color: isCompleted ? AppColors.primaryBlue : Colors.grey[300],
                ),
            ],
          ),
          const SizedBox(width: 15),
          
          // Stage Content
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isCurrent ? const Color(0xFFF5F5F5) : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.getStageTitle(stage),
                    style: GoogleFonts.poppins(
                      fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                      fontSize: 14,
                      color: isActive ? Colors.black : Colors.grey,
                    ),
                  ),
                  if (isCurrent) ...[
                    const SizedBox(height: 5),
                    Text(
                      controller.getStageDescription(stage),
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}