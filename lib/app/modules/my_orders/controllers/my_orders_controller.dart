import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../services/orders_service.dart';


class MyOrdersController extends GetxController {
  final OrdersService _ordersService = Get.find<OrdersService>();
  
  // All orders
  final allOrders = <Order>[].obs;
  
  // Grouped orders by date
  final groupedOrders = <String, List<Order>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  /// Load orders from API
  Future<void> fetchOrders() async {
    try {
      final ordersData = await _ordersService.getAllOrders();
      
      allOrders.value = ordersData.map((data) {
        // Safe parsing
        return Order(
          id: data['id']?.toString() ?? '',
          productName: data['productName'] ?? 'Article Inconnu',
          clientName: data['clientName'] ?? data['vendorName'] ?? 'Vendeur Inconnu',
          price: int.tryParse(data['price']?.toString() ?? '0') ?? 0,
          date: DateTime.tryParse(data['date'] ?? '') ?? DateTime.now(),
          image: data['image'] ?? '', // No more fake avatars
        );
      }).toList();
      
      groupOrdersByDate();
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de charger vos commandes');
    }
  }

  /// Group orders by date
  void groupOrdersByDate() {
    groupedOrders.clear();
    
    for (var order in allOrders) {
      final dateKey = getDateLabel(order.date);
      
      if (groupedOrders.containsKey(dateKey)) {
        groupedOrders[dateKey]!.add(order);
      } else {
        groupedOrders[dateKey] = [order];
      }
    }
  }

  /// Get date label for grouping
  String getDateLabel(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final orderDate = DateTime(date.year, date.month, date.day);

    if (orderDate == today) {
      return "Aujourd'hui";
    } else if (orderDate == yesterday) {
      return "Hier";
    } else {
      // Format: "Vendredi 17 Août 2025"
      return DateFormat('EEEE d MMMM y', 'fr_FR').format(date);
    }
  }

  /// Refresh orders
  void refreshOrders() {
    fetchOrders();
  }
}

/// Order model
class Order {
  final String id;
  final String productName;
  final String clientName;
  final int price;
  final DateTime date;
  final String image;

  Order({
    required this.id,
    required this.productName,
    required this.clientName,
    required this.price,
    required this.date,
    required this.image,
  });

  String get formattedPrice => '${price ~/ 1000}K Fcfa';
}
