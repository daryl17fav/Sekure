import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import '../controllers/home_controller.dart';
import '../../../../widgets/core_widgets.dart'; // Import core widgets
import '../../../../utils/colors.dart';

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

              // Total Sales
              Center(
                child: Column(
                  children: [
                    Text("Bilan des ventes", style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
                    Obx(() => Text(
                      controller.formattedSales,
                      style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.primaryBlue),
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Chart Card
              Container(
                height: 220,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Volume des ventes", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Expanded(
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(show: true, drawVerticalLine: false),
                          titlesData: FlTitlesData(show: false),
                          borderData: FlBorderData(show: false),
                          minX: 0, maxX: 6, minY: 0, maxY: 6,
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
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              
              // Transactions List
              Obx(() => Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Dernières transactions", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text("tout voir", style: GoogleFonts.poppins(color: AppColors.primaryRed, fontSize: 12)),
                    ],
                  ),
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