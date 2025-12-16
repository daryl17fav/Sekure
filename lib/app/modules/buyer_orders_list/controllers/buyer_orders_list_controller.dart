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

  // Mock order data
  final allOrders = [
    {'title': 'John DOE', 'subtitle': '01/09/25 à 19h48', 'price': '12.000 Fcfa', 'status': 'En attente'},
    {'title': 'Jane SMITH', 'subtitle': '02/09/25 à 10h30', 'price': '25.000 Fcfa', 'status': 'En attente'},
    {'title': 'Bob MARTIN', 'subtitle': '03/09/25 à 14h15', 'price': '18.500 Fcfa', 'status': 'En cours'},
    {'title': 'Alice DURAND', 'subtitle': '04/09/25 à 16h20', 'price': '30.000 Fcfa', 'status': 'En cours'},
    {'title': 'Tom BERNARD', 'subtitle': '05/09/25 à 09h45', 'price': '15.000 Fcfa', 'status': 'Payés'},
    {'title': 'Sarah PETIT', 'subtitle': '06/09/25 à 11h00', 'price': '22.000 Fcfa', 'status': 'Payés'},
    {'title': 'Marc DUBOIS', 'subtitle': '07/09/25 à 13h30', 'price': '19.000 Fcfa', 'status': 'Refusés'},
    {'title': 'Emma LAURENT', 'subtitle': '08/09/25 à 15h45', 'price': '28.000 Fcfa', 'status': 'Refusés'},
  ];

  @override
  void onInit() {
    super.onInit();
    loadOrders();
  }
  
  /// Load orders with simulated delay
  Future<void> loadOrders() async {
    isLoading.value = true;
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    isLoading.value = false;
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
  List<Map<String, String>> get filteredOrders {
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
