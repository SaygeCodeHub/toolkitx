import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationUtil {
  final pushNotifications = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await pushNotifications.requestPermission();
    final fcmToken = await pushNotifications.getToken();
    log('FCM Token $fcmToken');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  log('Notification title ${message.notification!.title}');
  log('Notification body ${message.notification!.body}');
}
