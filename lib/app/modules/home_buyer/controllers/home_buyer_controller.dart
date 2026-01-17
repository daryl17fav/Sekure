import 'package:get/get.dart';
import '../../../services/dashboard_service.dart';
import '../../../services/orders_service.dart';


class HomeBuyerController extends GetxController {
  final DashboardService _dashboardService = Get.find<DashboardService>();
  final OrdersService _ordersService = Get.find<OrdersService>();
  
  // User info
  final userName = 'John Evian Sultan'.obs;
  final userAvatar = ''.obs;
  
  // Purchase balance
  final totalPurchases = 9950.obs; // in Fcfa
  
  // Validated orders list
  final validatedOrders = <ValidatedOrder>[].obs;
  
  // Chart data points
  final chartData = <ChartPoint>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  /// Load real data from API
  Future<void> fetchData() async {
    try {
      // Fetch stats
      final stats = await _dashboardService.getStats();
      
      // Update balance/purchases
      // Assuming stats returns 'totalPurchases' or 'totalSpend' for buyers
      // Fallback to 'totalRevenue' if generic, or 0
      totalPurchases.value = int.tryParse(stats['totalPurchases']?.toString() ?? stats['totalRevenue']?.toString() ?? '0') ?? 0;

      // Fetch recent transactions/orders
      final transactions = await _dashboardService.getRecentTransactions();
      
      // Map to ValidatedOrder (assuming these are the relevant items for this view)
      validatedOrders.value = (transactions as List).map((t) {
        return ValidatedOrder(
          name: t['name'] ?? 'Commande',
          date: t['date'] ?? '',
          amount: int.tryParse(t['amount']?.toString() ?? '0') ?? 0,
          avatar: t['avatar'] ?? '', // No more fake avatars
        );
      }).toList();

      
      chartData.clear();
      if (stats['chartData'] != null) {
         // Parse if exists
      }
      
    } catch (e) {
      // Handle error
    }
  }

  /// Get formatted balance
  String get formattedBalance {
    return '${totalPurchases.value.toStringAsFixed(0)} Fcfa';
  }

  /// Refresh data
  void refreshData() {
    fetchData();
  }
}

/// Validated Order model
class ValidatedOrder {
  final String name;
  final String date;
  final int amount;
  final String avatar;

  ValidatedOrder({
    required this.name,
    required this.date,
    required this.amount,
    required this.avatar,
  });

  String get formattedAmount => '${amount.toStringAsFixed(0)} Fcfa';
}

/// Chart data point model
class ChartPoint {
  final double x;
  final double y1; // Blue line (purchases)
  final double y2; // Red line (comparison)

  ChartPoint({
    required this.x,
    required this.y1,
    required this.y2,
  });
}
