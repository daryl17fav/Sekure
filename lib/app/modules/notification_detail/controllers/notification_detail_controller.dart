import 'package:get/get.dart';

class NotificationDetailController extends GetxController {
  // Notification details
  final title = 'Titre de la notification'.obs;
  final date = 'Lundi 23 Décembre 2024'.obs;
  final description = 'Lorem ipsum dolor sit amet consectetur. Eleifend nibh consectetur sed varius pharetra pharetra nam. Augue enim ipsum massa sed adipiscing. Amet volutpat hendrerit aliquet vel iaculis tellus congue faucibus ipsum. Pulvinar at aliquam morbi urna amet volutpat tristique. Quam quis.'.obs;
  final link = 'https://loremipsumdolorsitamet.com'.obs;

  @override
  void onInit() {
    super.onInit();
    
    // Get notification from arguments if available
    if (Get.arguments != null && Get.arguments is Map) {
      final args = Get.arguments as Map;
      title.value = args['title'] ?? title.value;
      date.value = args['date'] ?? date.value;
      description.value = args['description'] ?? description.value;
      link.value = args['link'] ?? link.value;
    }
  }

  /// Handle action button
  void handleAction() {
    Get.snackbar(
      'Action',
      'Action effectuée',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

