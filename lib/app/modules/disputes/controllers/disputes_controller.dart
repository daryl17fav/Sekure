import 'package:get/get.dart';
import '../../../services/disputes_service.dart';


class DisputesController extends GetxController {
  final DisputesService _disputesService = Get.find<DisputesService>();
  
  // Loading state
  final isLoading = false.obs;
  
  // Selected tab index
  final selectedTab = 0.obs;
  
  // All disputes
  final allDisputes = <Dispute>[].obs;
  
  // Filtered disputes
  final filteredDisputes = <Dispute>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDisputes();
  }

  /// Fetch disputes from API
  Future<void> fetchDisputes() async {
    isLoading.value = true;
    try {
      final disputesData = await _disputesService.getAllDisputes();
      
      allDisputes.value = disputesData.map((data) {
        return Dispute(
          id: data['id']?.toString() ?? '',
          productName: data['productName'] ?? 'Produit Inconnu',
          vendorName: data['vendorName'] ?? 'Vendeur Inconnu',
          amount: int.tryParse(data['amount']?.toString() ?? '0') ?? 0,
          status: _parseStatus(data['status']),
          image: data['image'] ?? '', // No fake images
        );
      }).toList();
      
      filterDisputes();
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de charger les litiges');
    } finally {
      isLoading.value = false;
    }
  }

  DisputeStatus _parseStatus(String? status) {
    if (status == null) return DisputeStatus.pending;
    switch (status.toLowerCase()) {
      case 'resolved':
      case 'closed':
        return DisputeStatus.resolved;
      default:
        return DisputeStatus.pending;
    }
  }
 
  /// Load mock disputes (Removed)

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

