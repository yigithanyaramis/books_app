abstract class NotificationService {
  Future<void> scheduleNotification(
    int? id,
    String title,
    String body,
    DateTime scheduledTime,
  );
  Future<void> cancelNotification(int? id);
  Future<bool> hasNotification(int? id);
}
