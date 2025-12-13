import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import '../controllers/home_buyer_controller.dart';
import '../../../../widgets/core_widgets.dart';  
import '../../../../widgets/buyer_widgets.dart'; 
import '../../../../utils/colors.dart';
import '../../../../composants/home_composants.dart';

// Ensure you import the Buyer Drawer
// import '../../../../widgets/buyer_widgets.dart'; 

class HomeBuyerView extends GetView<HomeBuyerController> {
  const HomeBuyerView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.background,
      drawer: const SekureDrawerBuyer(), // Use the Buyer Drawer
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Obx(() => UserHeader(
                userAvatar: controller.userAvatar.value,
                userName: controller.userName.value,
                onMenuTap: () => scaffoldKey.currentState?.openDrawer(),
              )),
              const SizedBox(height: 20),

              // Total Purchases
              Obx(() => BalanceDisplay(
                label: "Bilan des achats",
                amount: controller.formattedBalance,
              )),
              const SizedBox(height: 20),

              // Chart
              ChartCard(
                title: "Volume des achats",
                lineBarsData: [
                  // Blue line for Purchases
                  LineChartBarData(
                    spots: [const FlSpot(0, 2), const FlSpot(1, 4), const FlSpot(2, 3), const FlSpot(3, 5), const FlSpot(4, 2), const FlSpot(5, 6)],
                    isCurved: true,
                    color: AppColors.primaryBlue,
                    barWidth: 2,
                    dotData: FlDotData(show: false),
                  ),
                  // Red line (Optional comparison)
                  LineChartBarData(
                    spots: [const FlSpot(0, 5), const FlSpot(1, 2), const FlSpot(2, 4), const FlSpot(3, 3), const FlSpot(4, 5), const FlSpot(5, 2)],
                    isCurved: true,
                    color: AppColors.primaryRed.withOpacity(0.5),
                    barWidth: 1,
                    dotData: FlDotData(show: false),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              
              // Validated Orders List
              const SectionHeader(title: "Bon de commandes validés"),
              const SizedBox(height: 15),
              
              Obx(() => Column(
                children: controller.validatedOrders.map((order) {
                  return ItemCard(
                    title: order.name,
                    subtitle: order.date,
                    price: order.formattedAmount,
                  );
                }).toList(),
              )),
            ],
          ),
        ),
      ),
    );
  }
}