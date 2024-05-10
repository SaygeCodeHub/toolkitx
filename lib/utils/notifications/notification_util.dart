import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:toolkit/blocs/chat/chat_bloc.dart';
import 'package:toolkit/blocs/chat/chat_event.dart';

import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../di/app_module.dart';
import '../database/database_util.dart';

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
        if (_isMessageForCurrentChat(message)) {
          print('ifffff');
          ChatBloc().add(RebuildChatMessagingScreen(employeeDetailsMap: {
            'sid': message.data['sid'] ?? '',
            'rid': message.data['rid'] ?? '',
            'rtype': message.data['rtype'] ?? '',
            'stype': message.data['stype'] ?? '',
            "employee_name": message.data['username'],
            'showCount': 0,
            'isGroup': (message.data['rtype'] == '3') ? true : false
          }));
        } else {
          print('elseeee ${ChatBloc().chatDetailsMap}');
          ChatBloc().add(RebuildChatMessagingScreen(employeeDetailsMap: {
            'sid': ChatBloc().chatDetailsMap['sid'] ?? '',
            'rid': ChatBloc().chatDetailsMap['rid'] ?? '',
            'rtype': message.data['rtype'] ?? '',
            'stype': message.data['stype'] ?? '',
            "employee_name": message.data['username'],
            'showCount': 0,
            'isGroup': (message.data['rtype'] == '3') ? true : false
          }));
        }
      }
      if (message.data['ischatgrouprequest'] == '1') {
        ChatBloc().add(FetchGroupInfo(groupId: message.data['group_id']));
      }
    });
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  bool _isMessageForCurrentChat(RemoteMessage message) {
    if (message.data.isNotEmpty) {
      String senderId = message.data['sid'];
      bool isMessageForCurrentChat =
          senderId == ChatBloc().chatDetailsMap['sid'];
      return isMessageForCurrentChat;
    }
    return false;
  }

  Future<void> _storeMessageInDatabase(RemoteMessage message) async {
    Map<String, dynamic> messageData = {
      'rid': message.data['rid'],
      'msg': message.data['chatmsg'],
      'msg_time': DateTime.parse(message.data['time']).toIso8601String(),
      'isReceiver': 1,
      'msg_id': message.data['id'],
      'rtype': message.data['rtype'],
      'quote_msg_id': message.data['quotemsg'],
      'sid': message.data['sid'],
      'stype': message.data['stype'],
      'employee_name': message.data['username'],
      'msg_type': message.data['type'],
      'showCount': 0,
      'isGroup': (message.data['rtype'] == '3') ? 1 : 0,
      'attachementExtension': 'pdf'
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
      'rid': message.data['rid'],
      'msg': message.data['chatmsg'],
      'msg_time': DateTime.parse(message.data['time']).toIso8601String(),
      'isReceiver': 1,
      'msg_id': message.data['id'],
      'rtype': message.data['rtype'],
      'quote_msg_id': message.data['quotemsg'] ?? '',
      'sid': message.data['sid'],
      'stype': message.data['stype'],
      'employee_name': message.data['username'],
      'msg_type': message.data['type'],
      'showCount': 0,
      'isGroup': (message.data['rtype'] == '3') ? 1 : 0,
      'attachementExtension': 'pdf'
    };
    await DatabaseHelper().insertMessage(messageData);
  } catch (e) {
    log('Error storing message in database: $e');
  }
}
