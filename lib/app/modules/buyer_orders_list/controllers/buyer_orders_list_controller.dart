import 'package:get/get.dart';
import '../../../services/orders_service.dart';


class BuyerOrdersListController extends GetxController {
  final OrdersService _ordersService = Get.find<OrdersService>();
  
  // Loading state
  final isLoading = false.obs;
  
  // Selected tab index
  final selectedTabIndex = 0.obs;
  
  // Tab names
  final tabs = [
    'Tous',
    'En attente',
    'En cours',
    'Payés',
    'Refusés',
  ];

  // Orders list
  final allOrders = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrders();
  }
  
  /// Fetch orders from API
  Future<void> fetchOrders() async {
    isLoading.value = true;
    try {
      final orders = await _ordersService.getAllOrders();
      
      allOrders.value = orders.map((order) {
        // Map backend fields to UI fields
        return {
          'title': order['productName'] ?? 'Commande sans nom',
          'subtitle': order['date'] ?? '', // Format date properly if needed
          'price': '${order['price'] ?? 0} Fcfa',
          'status': _mapStatus(order['status'] ?? ''),
          'originalStatus': order['status'] ?? '',
        };
      }).toList();
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de charger les commandes');
    } finally {
      isLoading.value = false;
    }
  }

  String _mapStatus(String backendStatus) {
    // Simple mapping to match UI tabs
    switch (backendStatus.toLowerCase()) {
      case 'pending': return 'En attente';
      case 'processing': return 'En cours';
      case 'completed': 
      case 'paid': return 'Payés';
      case 'cancelled': 
      case 'rejected': return 'Refusés';
      default: return 'Inconnu';
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Change selected tab
  void selectTab(int index) {
    selectedTabIndex.value = index;
  }

  // Get filtered orders based on selected tab
  List<Map<String, dynamic>> get filteredOrders {
    if (selectedTabIndex.value == 0) {
      // Show all orders
      return allOrders;
    } else {
      // Filter by status
      final status = tabs[selectedTabIndex.value];
      return allOrders.where((order) => order['status'] == status).toList();
    }
  }

  // Get count for each tab
  int getTabCount(int index) {
    if (index == 0) {
      return allOrders.length;
    } else {
      final status = tabs[index];
      return allOrders.where((order) => order['status'] == status).length;
    }
  }
}
