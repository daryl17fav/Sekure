import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import '../controllers/home_controller.dart';
import '../../../../widgets/core_widgets.dart'; // Import core widgets
import '../../../../utils/colors.dart';
import '../../../../composants/home_composants.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.background,
      drawer: const SekureDrawer(),
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

              // Total Sales
              Obx(() => BalanceDisplay(
                label: "Bilan des ventes",
                amount: controller.formattedSales,
              )),
              const SizedBox(height: 20),

              // Chart Card
              ChartCard(
                title: "Volume des ventes",
                lineBarsData: [
                  LineChartBarData(
                    spots: [const FlSpot(0, 3), const FlSpot(1, 1), const FlSpot(2, 4), const FlSpot(3, 2), const FlSpot(4, 5), const FlSpot(5, 3)],
                    isCurved: true,
                    color: AppColors.primaryRed,
                    barWidth: 2,
                    dotData: FlDotData(show: false),
                  ),
                  LineChartBarData(
                    spots: [const FlSpot(0, 1), const FlSpot(1, 3), const FlSpot(2, 3), const FlSpot(3, 5), const FlSpot(4, 2), const FlSpot(5, 4)],
                    isCurved: true,
                    color: AppColors.primaryBlue,
                    barWidth: 2,
                    dotData: FlDotData(show: false),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              
              // Transactions List
              Obx(() => Column(
                children: [
                  const SectionHeader(title: "Dernières transactions"),
                  const SizedBox(height: 15),
                  
                  ...controller.transactions.map((transaction) {
                    return ItemCard(
                      title: transaction.name,
                      subtitle: transaction.date,
                      price: transaction.formattedAmount,
                      isNegative: transaction.isNegative,
                    );
                  }).toList(),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}