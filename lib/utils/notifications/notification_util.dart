import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:toolkit/blocs/chatBox/chat_box_bloc.dart';
import 'package:toolkit/blocs/chatBox/chat_box_event.dart';
import 'package:toolkit/utils/chat_database_util.dart';
import '../../data/cache/customer_cache.dart';
import '../../di/app_module.dart';
import '../../data/cache/cache_keys.dart';

class NotificationUtil {
  final pushNotifications = FirebaseMessaging.instance;
  final CustomerCache _customerCache = getIt<CustomerCache>();
  final DatabaseHelper _databaseHelper = getIt<DatabaseHelper>();

  Future<void> initNotifications() async {
    await pushNotifications.requestPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      log('Notification title ${message.data}');
      if (message.data['ischatmsg'] == '1') {
        await _storeMessageInDatabase(message);
        ChatBoxBloc().add(RebuildChat(employeeDetailsMap: {
          "employee_id": message.data['rid'],
          "employee_name": ''
        }));
      }
    });
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<void> _storeMessageInDatabase(RemoteMessage message) async {
    Map<String, dynamic> messageData = {
      'employee_id': message.data['rid'],
      'msg': message.data['chatmsg'],
      'msg_time': DateTime.parse(message.data['time']).toIso8601String(),
      'isReceiver': 1,
      'msg_id': message.data['id'],
      'rtype': message.data['rtype'],
      'quote_msg_id': message.data['quotemsg'],
      'sid': message.data['sid']
    };
    await _databaseHelper.insertMessage(messageData);
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
  await _storeBackgroundMessageInDatabase(message);
}

Future<void> _storeBackgroundMessageInDatabase(RemoteMessage message) async {
  try {
    Map<String, dynamic> messageData = {
      'employee_id': message.data['rid'],
      'msg': message.data['chatmsg'],
      'msg_time': DateTime.parse(message.data['time']).toIso8601String(),
      'isReceiver': 1,
      'msg_id': message.data['id'],
      'rtype': message.data['rtype'],
      'quote_msg_id': message.data['quotemsg'],
      'sid': message.data['sid']
    };
    await DatabaseHelper().insertMessage(messageData);
  } catch (e) {
    log('Error storing message in database: $e');
  }
}
