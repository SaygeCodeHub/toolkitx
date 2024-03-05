import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:toolkit/blocs/chat/chat_bloc.dart';
import 'package:toolkit/blocs/chat/chat_event.dart';
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
        ChatBloc().add(RebuildChatMessagingScreen(employeeDetailsMap: {
          "employee_id": message.data['rid'],
          "employee_name": ''
        }));
      }
    });
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<void> _storeMessageInDatabase(RemoteMessage message) async {
    List<Map<String, dynamic>> allEmployees =
        await _databaseHelper.getEmployees();
    String employeeName = '';
    for (var item in allEmployees) {
      if (item['id'] == message.data['rid']) {
        employeeName = item['name'];
      }
    }
    Map<String, dynamic> messageData = {
      'employee_id': message.data['rid'],
      'msg': message.data['chatmsg'],
      'msg_time': DateTime.parse(message.data['time']).toIso8601String(),
      'isReceiver': 1,
      'msg_id': message.data['id'],
      'rtype': message.data['rtype'],
      'quote_msg_id': message.data['quotemsg'],
      'sid': message.data['sid'],
      'employee_name': employeeName
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
    List<Map<String, dynamic>> allEmployees =
        await DatabaseHelper().getEmployees();
    String employeeName = '';
    for (var item in allEmployees) {
      if (item['id'] == message.data['rid']) {
        employeeName = item['name'];
      }
    }
    Map<String, dynamic> messageData = {
      'employee_id': message.data['rid'],
      'msg': message.data['chatmsg'],
      'msg_time': DateTime.parse(message.data['time']).toIso8601String(),
      'isReceiver': 1,
      'msg_id': message.data['id'],
      'rtype': message.data['rtype'],
      'quote_msg_id': message.data['quotemsg'],
      'sid': message.data['sid'],
      'employee_name': employeeName
    };
    await DatabaseHelper().insertMessage(messageData);
  } catch (e) {
    log('Error storing message in database: $e');
  }
}
