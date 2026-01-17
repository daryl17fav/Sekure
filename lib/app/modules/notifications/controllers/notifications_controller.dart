import 'package:get/get.dart';
import '../../../services/notifications_service.dart';

class NotificationsController extends GetxController {
  // Loading state
  final isLoading = false.obs;
  
  // Grouped notifications
  final groupedNotifications = <String, List<NotificationItem>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  final NotificationsService _notificationsService = Get.find<NotificationsService>();

  /// Load notifications from API
  Future<void> fetchNotifications() async {
    isLoading.value = true;
    try {
      final data = await _notificationsService.getNotifications();
      
      final notifications = data.map((item) {
        return NotificationItem(
          id: item['id']?.toString() ?? '',
          title: item['title'] ?? 'Notification',
          description: item['description'] ?? '',
          hasButton: item['hasButton'] ?? false,
          date: DateTime.tryParse(item['date'] ?? '') ?? DateTime.now(),
        );
      }).toList();

      groupNotificationsByDate(notifications);
    } catch (e) {
      Get.snackbar('Erreur', 'Impossible de charger les notifications');
    } finally {
      isLoading.value = false;
    }
  }

  /// Group notifications by date
  void groupNotificationsByDate(List<NotificationItem> notifications) {
    groupedNotifications.clear();
    
    for (var item in notifications) {
      final dateKey = getDateLabel(item.date);
      
      if (groupedNotifications.containsKey(dateKey)) {
        groupedNotifications[dateKey]!.add(item);
      } else {
        groupedNotifications[dateKey] = [item];
      }
    }
  }

  /// Get date label for grouping
  String getDateLabel(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final itemDate = DateTime(date.year, date.month, date.day);

    if (itemDate == today) {
      return "Aujourd'hui";
    } else if (itemDate == yesterday) {
      return "Hier";
    } else {
      // Simple date format fallback if intl not available or manual
      return "${date.day}/${date.month}/${date.year}";
    }
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

