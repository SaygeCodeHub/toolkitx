import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import '../../data/cache/customer_cache.dart';
import '../../di/app_module.dart';
import '../../data/cache/cache_keys.dart';

class NotificationUtil {
  final pushNotifications = FirebaseMessaging.instance;
  final CustomerCache _customerCache = getIt<CustomerCache>();

  Future<void> initNotifications() async {
    await pushNotifications.requestPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Notification title ${message.notification!.title}');
      log('Notification body ${message.notification!.body}');
    });
  }

  ifTokenExists<bool>() async {
    String? fcmToken = await _customerCache.getFCMToken(CacheKeys.fcmToken);
    return fcmToken != null;
  }

  getToken<String>() async {
    return await pushNotifications.getToken();
  }
}

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  log('Notification title ${message.notification!.title}');
  log('Notification body ${message.notification!.body}');
}
