import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import '../../data/cache/customer_cache.dart';
import '../../di/app_module.dart';
import '../../data/cache/cache_keys.dart';

class NotificationUtil {
  final pushNotifications = FirebaseMessaging.instance;
  final CustomerCache _customerCache = getIt<CustomerCache>();

  Future<String?> initNotifications() async {
    await pushNotifications.requestPermission();
    String? fcmToken = await _customerCache.getFCMToken(CacheKeys.fcmToken);
    if (fcmToken == null) {
      fcmToken = await pushNotifications.getToken();
      return fcmToken;
    } else {
      return fcmToken;
    }
  }
}

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  log('Notification title ${message.notification!.title}');
  log('Notification body ${message.notification!.body}');
}
