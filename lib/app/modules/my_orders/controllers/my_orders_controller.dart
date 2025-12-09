import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MyOrdersController extends GetxController {
  // All orders
  final allOrders = <Order>[].obs;
  
  // Grouped orders by date
  final groupedOrders = <String, List<Order>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadMockOrders();
  }

  /// Load mock orders
  void loadMockOrders() {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));
    final lastWeek = now.subtract(const Duration(days: 10));
    final lastMonth = now.subtract(const Duration(days: 40));

    allOrders.value = [
      // Today's orders
      Order(
        id: '1',
        productName: "Nom de l'article",
        clientName: 'Nom du client',
        price: 12000,
        date: now,
        image: 'https://i.pravatar.cc/150?img=30',
      ),
      Order(
        id: '2',
        productName: "Nom de l'article",
        clientName: 'Nom du client',
        price: 12000,
        date: now,
        image: 'https://i.pravatar.cc/150?img=31',
      ),
      Order(
        id: '3',
        productName: "Nom de l'article",
        clientName: 'Nom du client',
        price: 12000,
        date: now,
        image: 'https://i.pravatar.cc/150?img=32',
      ),
      
      // Yesterday's order
      Order(
        id: '4',
        productName: "Nom de l'article",
        clientName: 'Nom du client',
        price: 12000,
        date: yesterday,
        image: 'https://i.pravatar.cc/150?img=33',
      ),
      
      // Last week orders
      Order(
        id: '5',
        productName: "Nom de l'article",
        clientName: 'Nom du client',
        price: 12000,
        date: lastWeek,
        image: 'https://i.pravatar.cc/150?img=34',
      ),
      Order(
        id: '6',
        productName: "Nom de l'article",
        clientName: 'Nom du client',
        price: 12000,
        date: lastWeek,
        image: 'https://i.pravatar.cc/150?img=35',
      ),
      Order(
        id: '7',
        productName: "Nom de l'article",
        clientName: 'Nom du client',
        price: 12000,
        date: lastWeek,
        image: 'https://i.pravatar.cc/150?img=36',
      ),
      
      // Last month order
      Order(
        id: '8',
        productName: "Nom de l'article",
        clientName: 'Nom du client',
        price: 12000,
        date: lastMonth,
        image: 'https://i.pravatar.cc/150?img=37',
      ),
    ];
    
    groupOrdersByDate();
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
    loadMockOrders();
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

