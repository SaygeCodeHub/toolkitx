import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:toolkit/utils/chat_database_util.dart';
import '../../data/cache/customer_cache.dart';
import '../../di/app_module.dart';
import '../../data/cache/cache_keys.dart';

class NotificationUtil {
  final pushNotifications = FirebaseMessaging.instance;
  final CustomerCache _customerCache = getIt<CustomerCache>();

  Future<void> initNotifications() async {
    await pushNotifications.requestPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      log('Notification title ${message.data}');
      await _storeMessageInDatabase(message);
    });

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<void> _storeMessageInDatabase(RemoteMessage message) async {
    Map<String, dynamic> messageData = {
      'employee_id': message.data['rid'],
      'msg': message.data['chatmsg'],
      'msg_time': message.data['time']
    };

    await DatabaseHelper().insertMessage(messageData);
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
  log('Notification background title ${message.data}');
}
