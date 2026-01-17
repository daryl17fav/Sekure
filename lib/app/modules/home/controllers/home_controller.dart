import 'package:get/get.dart';
import '../../../services/dashboard_service.dart';


class HomeController extends GetxController {
  final DashboardService _dashboardService = Get.find<DashboardService>();
  
  // User info
  final userName = 'John Evian Sultan'.obs;
  final userAvatar = ''.obs;
  
  // Sales data
  final totalSales = 9950.obs; // in Fcfa
  
  // Observable list of transactions
  final transactions = <Transaction>[].obs;
  
  // Chart data points
  final chartData = <ChartPoint>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDashboardData();
  }

  /// Fetch dashboard data from API
  Future<void> fetchDashboardData() async {
    try {
      final stats = await _dashboardService.getStats();
      final recentTransactions = await _dashboardService.getRecentTransactions();

      // Update sales
      totalSales.value = int.tryParse(stats['totalRevenue']?.toString() ?? '0') ?? 0;

      // Update transactions
      transactions.value = (recentTransactions as List).map((t) => Transaction(
        name: t['name'] ?? 'Inconnu',
        date: t['date'] ?? '',
        amount: int.tryParse(t['amount']?.toString() ?? '0') ?? 0,
        avatar: t['avatar'] ?? '',
      )).toList();

      // Update chart data if available in stats
      // For now, we might keep chart data empty or parse if structure is known
      // chartData.value = ...
      
    } catch (e) {
      print("Error loading dashboard data: $e");
    }
  }

  /// Refresh data
  void refreshData() {
    fetchDashboardData();
  }

  /// Get formatted sales amount
  String get formattedSales {
    return '${totalSales.value.toStringAsFixed(0)} Fcfa';
  }
}

/// Transaction model
class Transaction {
  final String name;
  final String date;
  final int amount; // Negative for expenses, positive for income
  final String avatar;

  Transaction({
    required this.name,
    required this.date,
    required this.amount,
    required this.avatar,
  });

  bool get isNegative => amount < 0;

  String get formattedAmount {
    final abs = amount.abs();
    final sign = isNegative ? '-' : '+';
    return '$sign${abs ~/ 1000}K Fcfa';
  }
}

/// Chart data point model
class ChartPoint {
  final double x;
  final double y1; // First line (red)
  final double y2; // Second line (blue)

  ChartPoint({
    required this.x,
    required this.y1,
    required this.y2,
  });
}

