import 'package:get/get.dart';
import '../../../services/submissions_service.dart';

class SubmissionsController extends GetxController {
   final selectedTab = 0.obs;
  
   final allSubmissions = <Submission>[].obs;
  
   final filteredSubmissions = <Submission>[].obs;

  final SubmissionsService _submissionsService = Get.put(SubmissionsService());

  @override
  void onInit() {
    super.onInit();
    fetchSubmissions();
  }

   Future<void> fetchSubmissions() async {
    try {
      final data = await _submissionsService.getSubmissions();
      allSubmissions.value = data.map((item) => Submission(
        id: item['id']?.toString() ?? '',
        productName: item['productName'] ?? 'Inconnu',
        buyerName: item['buyerName'] ?? 'Inconnu',
        price: int.tryParse(item['price']?.toString() ?? '0') ?? 0,
        status: _parseStatus(item['status']),
        image: item['image'] ?? '',
      )).toList();
      
      // Initially show all
      filterSubmissions();
    } catch (e) {
      print("Error fetching submissions: $e");
    }
  }

  SubmissionStatus _parseStatus(String? status) {
    switch (status?.toLowerCase()) {
      case 'paid':
        return SubmissionStatus.paid;
      case 'expired':
        return SubmissionStatus.expired;
      case 'pending':
      default:
        return SubmissionStatus.pending;
    }
  }

  /// Filter submissions based on selected tab
  void filterSubmissions() {
    switch (selectedTab.value) {
      case 0: // Tous
        filteredSubmissions.value = allSubmissions.value;
        break;
      case 1: // En attente
        filteredSubmissions.value = allSubmissions.value
            .where((s) => s.status == SubmissionStatus.pending)
            .toList();
        break;
      case 2: // Payés
        filteredSubmissions.value = allSubmissions.value
            .where((s) => s.status == SubmissionStatus.paid)
            .toList();
        break;
      case 3: // Expirées
        filteredSubmissions.value = allSubmissions.value
            .where((s) => s.status == SubmissionStatus.expired)
            .toList();
        break;
    }
  }

  /// Select tab and filter
  void selectTab(int index) {
    selectedTab.value = index;
    filterSubmissions();
  }

  /// Get tab label with count
  String getTabLabel(int index) {
    int count;
    switch (index) {
      case 0:
        count = allSubmissions.value.length;
        return 'Tous ($count)';
      case 1:
        count = allSubmissions.value.where((s) => s.status == SubmissionStatus.pending).length;
        return 'En attente ($count)';
      case 2:
        count = allSubmissions.value.where((s) => s.status == SubmissionStatus.paid).length;
        return 'Payés ($count)';
      case 3:
        count = allSubmissions.value.where((s) => s.status == SubmissionStatus.expired).length;
        return 'Expirées ($count)';
      default:
        return '';
    }
  }

  /// Refresh submissions
  void refreshSubmissions() {
    fetchSubmissions();
  }
}

/// Submission model
class Submission {
  final String id;
  final String productName;
  final String buyerName;
  final int price;
  final SubmissionStatus status;
  final String image;

  Submission({
    required this.id,
    required this.productName,
    required this.buyerName,
    required this.price,
    required this.status,
    required this.image,
  });

  String get formattedPrice => '${price.toStringAsFixed(0)} Fcfa';

  String get statusText {
    switch (status) {
      case SubmissionStatus.pending:
        return 'En attente';
      case SubmissionStatus.paid:
        return 'Payées';
      case SubmissionStatus.expired:
        return 'Expirées';
    }
  }
}

/// Submission status enum
enum SubmissionStatus {
  pending,
  paid,
  expired,
}

