import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import '../controllers/home_buyer_controller.dart';
import '../../../../widgets/core_widgets.dart';  
import '../../../../widgets/buyer_widgets.dart'; 
import '../../../../utils/colors.dart';

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
              Row(
                children: [
                  Obx(() => CircleAvatar(
                    backgroundImage: NetworkImage(controller.userAvatar.value),
                  )),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Salut", style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
                      Obx(() => Text(
                        controller.userName.value,
                        style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14),
                      )),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () => scaffoldKey.currentState?.openDrawer(),
                  )
                ],
              ),
              const SizedBox(height: 20),

              // Total Purchases
              Center(
                child: Column(
                  children: [
                    Text("Bilan des achats", style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
                    Obx(() => Text(
                      controller.formattedBalance,
                      style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.primaryBlue),
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Chart
              Container(
                height: 220,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Volume des achats", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Expanded(
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(show: true, drawVerticalLine: false),
                          titlesData: FlTitlesData(show: false),
                          borderData: FlBorderData(show: false),
                          minX: 0, maxX: 6, minY: 0, maxY: 6,
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
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              
              // Validated Orders List
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Bon de commandes validés", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text("tout voir", style: GoogleFonts.poppins(color: AppColors.primaryRed, fontSize: 12)),
                ],
              ),
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