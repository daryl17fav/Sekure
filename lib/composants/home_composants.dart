import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import '../utils/colors.dart';

/// User Header Component
/// Displays user avatar, greeting, and name with a menu button
class UserHeader extends StatelessWidget {
  final String userAvatar;
  final String userName;
  final VoidCallback onMenuTap;

  const UserHeader({
    super.key,
    required this.userAvatar,
    required this.userName,
    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(userAvatar),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Salut", style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
            Text(
              userName,
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          icon: const Icon(Icons.menu),
          onPressed: onMenuTap,
        )
      ],
    );
  }
}

/// Balance Display Component
/// Centered display of total balance/sales/purchases
class BalanceDisplay extends StatelessWidget {
  final String label;
  final String amount;

  const BalanceDisplay({
    super.key,
    required this.label,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(label, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
          Text(
            amount,
            style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.bold, color: AppColors.primaryBlue),
          ),
        ],
      ),
    );
  }
}

/// Chart Card Component
/// Container with line chart for displaying trends
class ChartCard extends StatelessWidget {
  final String title;
  final List<LineChartBarData> lineBarsData;
  final double? minY;
  final double? maxY;

  const ChartCard({
    super.key,
    required this.title,
    required this.lineBarsData,
    this.minY = 0,
    this.maxY = 6,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: true, drawVerticalLine: false),
                titlesData: FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: 6,
                minY: minY,
                maxY: maxY,
                lineBarsData: lineBarsData,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Section Header Component
/// Header with title and "voir tout" link
class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onViewAll;

  const SectionHeader({
    super.key,
    required this.title,
    this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
        if (onViewAll != null)
          GestureDetector(
            onTap: onViewAll,
            child: Text("tout voir", style: GoogleFonts.poppins(color: AppColors.primaryRed, fontSize: 12)),
          ),
      ],
    );
  }
}
