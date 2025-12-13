import 'package:get/get.dart';
import '../../../services/disputes_service.dart';


class DisputesController extends GetxController {
  final DisputesService _disputesService = Get.find<DisputesService>();
  
  // Selected tab index
  final selectedTab = 0.obs;
  
  // All disputes
  final allDisputes = <Dispute>[].obs;
  
  // Filtered disputes
  final filteredDisputes = <Dispute>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadMockDisputes();
  }

  /// Load mock disputes
  void loadMockDisputes() {
    allDisputes.value = [
      Dispute(
        id: '1',
        productName: "Nom de l'article",
        vendorName: 'M. Martins AZEMIN',
        amount: 12000,
        status: DisputeStatus.pending,
        image: 'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400',
      ),
      Dispute(
        id: '2',
        productName: "Nom de l'article",
        vendorName: 'M. Martins AZEMIN',
        amount: 12000,
        status: DisputeStatus.pending,
        image: 'https://images.unsplash.com/photo-1567016432779-094069958ea5?w=400',
      ),
      Dispute(
        id: '3',
        productName: "Nom de l'article",
        vendorName: 'M. Martins AZEMIN',
        amount: 12000,
        status: DisputeStatus.resolved,
        image: 'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?w=400',
      ),
      Dispute(
        id: '4',
        productName: "Nom de l'article",
        vendorName: 'M. Martins AZEMIN',
        amount: 12000,
        status: DisputeStatus.resolved,
        image: 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?w=400',
      ),
      Dispute(
        id: '5',
        productName: "Nom de l'article",
        vendorName: 'M. Martins AZEMIN',
        amount: 12000,
        status: DisputeStatus.pending,
        image: 'https://images.unsplash.com/photo-1540574163026-643ea20ade25?w=400',
      ),
    ];
    
    filterDisputes();
  }

  /// Filter disputes based on selected tab
  void filterDisputes() {
    switch (selectedTab.value) {
      case 0: // Tous
        filteredDisputes.value = allDisputes;
        break;
      case 1: // En attente
        filteredDisputes.value = allDisputes
            .where((d) => d.status == DisputeStatus.pending)
            .toList();
        break;
      case 2: // Réglées
        filteredDisputes.value = allDisputes
            .where((d) => d.status == DisputeStatus.resolved)
            .toList();
        break;
    }
  }

  /// Select tab
  void selectTab(int index) {
    selectedTab.value = index;
    filterDisputes();
  }

  /// Get tab label with count
  String getTabLabel(int index) {
    int count;
    switch (index) {
      case 0:
        count = allDisputes.length;
        return 'Tous ($count)';
      case 1:
        count = allDisputes.where((d) => d.status == DisputeStatus.pending).length;
        return 'En attente ($count)';
      case 2:
        count = allDisputes.where((d) => d.status == DisputeStatus.resolved).length;
        return 'Réglées ($count)';
      default:
        return '';
    }
  }
}

/// Dispute model
class Dispute {
  final String id;
  final String productName;
  final String vendorName;
  final int amount;
  final DisputeStatus status;
  final String image;

  Dispute({
    required this.id,
    required this.productName,
    required this.vendorName,
    required this.amount,
    required this.status,
    required this.image,
  });

  String get formattedAmount => '${amount.toStringAsFixed(0)} Fcfa';
}

/// Dispute status enum
enum DisputeStatus {
  pending,
  resolved,
}

