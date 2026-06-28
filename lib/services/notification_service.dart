import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final plugin = FlutterLocalNotificationsPlugin();
  static Future<void> init() async => plugin.initialize(const InitializationSettings(android: AndroidInitializationSettings('@mipmap/ic_launcher'), iOS: DarwinInitializationSettings()));
  static Future<void> notify(String title, String body) => plugin.show(1, title, body, const NotificationDetails(android: AndroidNotificationDetails('reports', 'Reports')));
}
