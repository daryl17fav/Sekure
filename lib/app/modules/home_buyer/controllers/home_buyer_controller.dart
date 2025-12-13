import 'package:get/get.dart';
import '../../../services/dashboard_service.dart';
import '../../../services/orders_service.dart';


class HomeBuyerController extends GetxController {
  final DashboardService _dashboardService = Get.find<DashboardService>();
  final OrdersService _ordersService = Get.find<OrdersService>();
  
  // User info
  final userName = 'John Evian Sultan'.obs;
  final userAvatar = 'https://i.pravatar.cc/150?img=8'.obs;
  
  // Purchase balance
  final totalPurchases = 9950.obs; // in Fcfa
  
  // Validated orders list
  final validatedOrders = <ValidatedOrder>[].obs;
  
  // Chart data points
  final chartData = <ChartPoint>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadMockData();
  }

  /// Load mock data
  void loadMockData() {
    // Mock validated orders
    validatedOrders.value = [
      ValidatedOrder(
        name: 'John DOE',
        date: '01/09/25 à 19h48',
        amount: 12000,
        avatar: 'https://i.pravatar.cc/150?img=20',
      ),
      ValidatedOrder(
        name: 'John DOE',
        date: '01/09/25 à 19h48',
        amount: 12000,
        avatar: 'https://i.pravatar.cc/150?img=21',
      ),
      ValidatedOrder(
        name: 'John DOE',
        date: '01/09/25 à 19h48',
        amount: 12000,
        avatar: 'https://i.pravatar.cc/150?img=22',
      ),
    ];

    // Mock chart data
    chartData.value = [
      ChartPoint(x: 0, y1: 2, y2: 5),
      ChartPoint(x: 1, y1: 4, y2: 2),
      ChartPoint(x: 2, y1: 3, y2: 4),
      ChartPoint(x: 3, y1: 5, y2: 3),
      ChartPoint(x: 4, y1: 2, y2: 5),
      ChartPoint(x: 5, y1: 6, y2: 2),
    ];
  }

  /// Get formatted balance
  String get formattedBalance {
    return '${totalPurchases.value.toStringAsFixed(0)} Fcfa';
  }

  /// Refresh data
  void refreshData() {
    loadMockData();
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

