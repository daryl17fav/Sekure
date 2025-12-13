import 'package:get/get.dart';

class SubmissionsController extends GetxController {
   final selectedTab = 0.obs;
  
   final allSubmissions = <Submission>[].obs;
  
   final filteredSubmissions = <Submission>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadMockSubmissions();
  }

   void loadMockSubmissions() {
    allSubmissions.value = [
      Submission(
        id: '1',
        productName: "Nom de l'article",
        buyerName: 'M. Martins AZEMIN',
        price: 12000,
        status: SubmissionStatus.pending,
        image: 'https://i.pravatar.cc/150?img=20',
      ),
      Submission(
        id: '2',
        productName: "Nom de l'article",
        buyerName: 'M. Martins AZEMIN',
        price: 12000,
        status: SubmissionStatus.pending,
        image: 'https://i.pravatar.cc/150?img=21',
      ),
      Submission(
        id: '3',
        productName: "Nom de l'article",
        buyerName: 'M. Martins AZEMIN',
        price: 12000,
        status: SubmissionStatus.pending,
        image: 'https://i.pravatar.cc/150?img=22',
      ),
      Submission(
        id: '4',
        productName: "Nom de l'article",
        buyerName: 'M. Martins AZEMIN',
        price: 12000,
        status: SubmissionStatus.paid,
        image: 'https://i.pravatar.cc/150?img=23',
      ),
      Submission(
        id: '5',
        productName: "Nom de l'article",
        buyerName: 'M. Martins AZEMIN',
        price: 12000,
        status: SubmissionStatus.paid,
        image: 'https://i.pravatar.cc/150?img=24',
      ),
      Submission(
        id: '6',
        productName: "Nom de l'article",
        buyerName: 'M. Martins AZEMIN',
        price: 12000,
        status: SubmissionStatus.expired,
        image: 'https://i.pravatar.cc/150?img=25',
      ),
      Submission(
        id: '7',
        productName: "Nom de l'article",
        buyerName: 'M. Martins AZEMIN',
        price: 12000,
        status: SubmissionStatus.expired,
        image: 'https://i.pravatar.cc/150?img=26',
      ),
    ];
    
    // Initially show all
    filterSubmissions();
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
    loadMockSubmissions();
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

