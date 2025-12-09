import 'package:get/get.dart';

class NotificationsController extends GetxController {
  // Grouped notifications
  final groupedNotifications = <String, List<NotificationItem>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  /// Load mock notifications
  void loadNotifications() {
    groupedNotifications.value = {
      'Aujourd\'hui': [
        NotificationItem(
          id: '1',
          title: 'Titre de la notification',
          description: 'Lorem ipsum dolor sit amet consectetur. Aliquet turpis lobortis dolor laoreet nunc ac. Auctor sem lorem felis pulvinar morbi.',
          hasButton: true,
          date: DateTime.now(),
        ),
        NotificationItem(
          id: '2',
          title: 'Titre de la notification',
          description: 'Lorem ipsum dolor sit amet consectetur. Aliquet turpis lobortis dolor laoreet nunc ac. Auctor sem lorem felis pulvinar morbi.',
          hasButton: false,
          date: DateTime.now(),
        ),
      ],
      'Hier': [
        NotificationItem(
          id: '3',
          title: 'Titre de la notification',
          description: 'Lorem ipsum dolor sit amet consectetur. Aliquet turpis lobortis dolor laoreet nunc ac. Auctor sem lorem felis pulvinar morbi.',
          hasButton: true,
          date: DateTime.now().subtract(const Duration(days: 1)),
        ),
        NotificationItem(
          id: '4',
          title: 'Titre de la notification',
          description: 'Lorem ipsum dolor sit amet consectetur. Aliquet turpis lobortis dolor laoreet nunc ac. Auctor sem lorem felis pulvinar morbi.',
          hasButton: false,
          date: DateTime.now().subtract(const Duration(days: 1)),
        ),
      ],
      'Lundi 23 Décembre 2024': [
        NotificationItem(
          id: '5',
          title: 'Titre de la notification',
          description: 'Lorem ipsum dolor sit amet consectetur. Aliquet turpis lobortis dolor laoreet nunc ac. Auctor sem lorem felis pulvinar morbi.',
          hasButton: false,
          date: DateTime(2024, 12, 23),
        ),
      ],
    };
  }

  /// Handle notification action
  void handleNotificationAction(String notificationId) {
    Get.snackbar(
      'Action',
      'Action pour notification $notificationId',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

/// Notification Item model
class NotificationItem {
  final String id;
  final String title;
  final String description;
  final bool hasButton;
  final DateTime date;

  NotificationItem({
    required this.id,
    required this.title,
    required this.description,
    required this.hasButton,
    required this.date,
  });
}

