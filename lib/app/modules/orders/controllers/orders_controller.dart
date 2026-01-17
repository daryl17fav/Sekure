import 'package:get/get.dart';
import '../../../services/orders_service.dart';


class OrdersController extends GetxController {
  final OrdersService _ordersService = Get.find<OrdersService>();
  
  // Loading state
  final isLoading = false.obs;
  
  // Selected tab index
  final selectedTab = 0.obs;
  
  // All orders
  final allOrders = <OrderCommand>[].obs;
  
  // Filtered orders based on selected tab
  final filteredOrders = <OrderCommand>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }

  /// Fetch orders from API
  Future<void> fetchOrders() async {
    isLoading.value = true;
    try {
      final ordersData = await _ordersService.getAllOrders();
      
      allOrders.value = ordersData.map((data) => OrderCommand(
        id: data['id']?.toString() ?? '',
        productName: data['productName'] ?? 'Produit inconnu',
        clientName: data['clientName'] ?? 'Client inconnu',
        // Handle price parsing safely
        price: int.tryParse(data['price']?.toString() ?? '0') ?? 0,
        status: _parseStatus(data['status']),
        image: data['image'] ?? '',
      )).toList();
      
      // Apply current filter
      filterOrders();
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Impossible de charger les commandes: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Get.theme.colorScheme.onError,
      );
    } finally {
      isLoading.value = false;
    }
  }

  OrderStatus _parseStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'paid':
      case 'payé':
        return OrderStatus.paid;
      case 'refused':
      case 'refusé':
        return OrderStatus.refused;
      case 'pending':
      case 'en attente':
      default:
        return OrderStatus.pending;
    }
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
    fetchOrders();
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

