import 'package:get/get.dart';

class HomeController extends GetxController {
  // User info
  final userName = 'John Evian Sultan'.obs;
  final userAvatar = 'https://i.pravatar.cc/150?img=11'.obs;
  
  // Sales data
  final totalSales = 9950.obs; // in Fcfa
  
  // Observable list of transactions
  final transactions = <Transaction>[].obs;
  
  // Chart data points
  final chartData = <ChartPoint>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadMockData();
  }

  /// Load mock data for demo
  void loadMockData() {
    // Mock transactions
    transactions.value = [
      Transaction(
        name: 'John DOE',
        date: '01/09/25 à 19h48',
        amount: -12000,
        avatar: 'https://i.pravatar.cc/150?img=12',
      ),
      Transaction(
        name: 'John DOE',
        date: '01/09/25 à 19h48',
        amount: 12000,
        avatar: 'https://i.pravatar.cc/150?img=13',
      ),
      Transaction(
        name: 'John DOE',
        date: '01/09/25 à 19h48',
        amount: -12000,
        avatar: 'https://i.pravatar.cc/150?img=14',
      ),
      Transaction(
        name: 'John DOE',
        date: '01/09/25 à 19h48',
        amount: 12000,
        avatar: 'https://i.pravatar.cc/150?img=15',
      ),
    ];

    // Mock chart data (for the line chart)
    chartData.value = [
      ChartPoint(x: 0, y1: 3, y2: 1),
      ChartPoint(x: 1, y1: 1, y2: 3),
      ChartPoint(x: 2, y1: 4, y2: 3),
      ChartPoint(x: 3, y1: 2, y2: 5),
      ChartPoint(x: 4, y1: 5, y2: 2),
      ChartPoint(x: 5, y1: 3, y2: 4),
    ];
  }

  /// Refresh data
  void refreshData() {
    loadMockData();
    // In real app, fetch from API
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

