import 'package:get/get.dart';

class OrdersController extends GetxController {
  // Selected tab index
  final selectedTab = 0.obs;
  
  // All orders
  final allOrders = <OrderCommand>[].obs;
  
  // Filtered orders based on selected tab
  final filteredOrders = <OrderCommand>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadMockOrders();
  }

  /// Load mock orders
  void loadMockOrders() {
    allOrders.value = [
      OrderCommand(
        id: '1',
        productName: "Nom de l'article",
        clientName: 'Nom du client',
        price: 12000,
        status: OrderStatus.pending,
        image: 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400',
      ),
      OrderCommand(
        id: '2',
        productName: "Nom de l'article",
        clientName: 'Nom du client',
        price: 12000,
        status: OrderStatus.pending,
        image: 'https://images.unsplash.com/photo-1567016432779-094069958ea5?w=400',
      ),
      OrderCommand(
        id: '3',
        productName: "Nom de l'article",
        clientName: 'Nom du client',
        price: 12000,
        status: OrderStatus.paid,
        image: 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=400',
      ),
      OrderCommand(
        id: '4',
        productName: "Nom de l'article",
        clientName: 'Nom du client',
        price: 12000,
        status: OrderStatus.paid,
        image: 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?w=400',
      ),
      OrderCommand(
        id: '5',
        productName: "Nom de l'article",
        clientName: 'Nom du client',
        price: 12000,
        status: OrderStatus.refused,
        image: 'https://images.unsplash.com/photo-1540574163026-643ea20ade25?w=400',
      ),
    ];
    
    // Initially show all
    filterOrders();
  }

  /// Filter orders based on selected tab
  void filterOrders() {
    switch (selectedTab.value) {
      case 0: // Tous
        filteredOrders.value = allOrders;
        break;
      case 1: // En attente
        filteredOrders.value = allOrders
            .where((o) => o.status == OrderStatus.pending)
            .toList();
        break;
      case 2: // Payés
        filteredOrders.value = allOrders
            .where((o) => o.status == OrderStatus.paid)
            .toList();
        break;
      case 3: // Refusés
        filteredOrders.value = allOrders
            .where((o) => o.status == OrderStatus.refused)
            .toList();
        break;
    }
  }

  /// Select tab and filter
  void selectTab(int index) {
    selectedTab.value = index;
    filterOrders();
  }

  /// Get tab label with count
  String getTabLabel(int index) {
    int count;
    switch (index) {
      case 0:
        count = allOrders.length;
        return 'Tous ($count)';
      case 1:
        count = allOrders.where((o) => o.status == OrderStatus.pending).length;
        return 'En attente ($count)';
      case 2:
        count = allOrders.where((o) => o.status == OrderStatus.paid).length;
        return 'Payés ($count)';
      case 3:
        count = allOrders.where((o) => o.status == OrderStatus.refused).length;
        return 'Refusés ($count)';
      default:
        return '';
    }
  }

  /// Refresh orders
  void refreshOrders() {
    loadMockOrders();
  }
}

/// Order Command model
class OrderCommand {
  final String id;
  final String productName;
  final String clientName;
  final int price;
  final OrderStatus status;
  final String image;

  OrderCommand({
    required this.id,
    required this.productName,
    required this.clientName,
    required this.price,
    required this.status,
    required this.image,
  });

  String get formattedPrice => '${price.toStringAsFixed(0)} Fcfa';
}

/// Order status enum
enum OrderStatus {
  pending,
  paid,
  refused,
}

