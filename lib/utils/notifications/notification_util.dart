import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:toolkit/blocs/chat/chat_bloc.dart';
import 'package:toolkit/blocs/chat/chat_event.dart';

import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../di/app_module.dart';
import '../database/database_util.dart';

class NotificationUtil {
  final FirebaseMessaging pushNotifications = FirebaseMessaging.instance;
  final CustomerCache _customerCache = getIt<CustomerCache>();
  final DatabaseHelper _databaseHelper = getIt<DatabaseHelper>();

  Future<void> initNotifications() async {
    try {
      await Firebase.initializeApp();

      await requestPermission();

      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        try {
          if (message.data['ischatmsg'] == '1') {
            await _storeMessageInDatabase(message);
            if (_isMessageForCurrentChat(message)) {
              ChatBloc().add(RebuildChatMessagingScreen(employeeDetailsMap: {
                'sid': message.data['sid'] ?? '',
                'rid': message.data['rid'] ?? '',
                'rtype': message.data['rtype'] ?? '',
                'stype': message.data['stype'] ?? '',
                "employee_name": message.data['username'],
                'showCount': 0,
                'currentSenderId': message.data['sid'] ?? '',
                'currentReceiverId': message.data['rid'] ?? '',
                'isGroup': (message.data['rtype'] == '3') ? true : false,
                'isCurrentUser': true
              }));
            } else {
              ChatBloc().add(RebuildChatMessagingScreen(employeeDetailsMap: {
                'sid': ChatBloc().chatDetailsMap['sid'] ?? message.data['sid'],
                'rid': ChatBloc().chatDetailsMap['rid'] ?? message.data['rid'],
                'rtype': message.data['rtype'] ?? '',
                'stype': message.data['stype'] ?? '',
                "employee_name": message.data['username'],
                'showCount': 0,
                'currentSenderId':
                    ChatBloc().chatDetailsMap['sid'] ?? message.data['sid'],
                'currentReceiverId':
                    ChatBloc().chatDetailsMap['rid'] ?? message.data['rid'],
                'isGroup': (message.data['rtype'] == '3') ? true : false,
                'isCurrentUser': false
              }));
            }
          }
          if (message.data['ischatgrouprequest'] == '1') {
            ChatBloc().add(FetchGroupInfo(groupId: message.data['group_id']));
          }
        } catch (e) {
          rethrow;
        }
      });

      FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    } catch (e) {
      print('Error initializing notifications: $e');
    }
  }

  Future<void> requestPermission() async {
    NotificationSettings settings = await pushNotifications.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  bool _isMessageForCurrentChat(RemoteMessage message) {
    try {
      if (message.data.isNotEmpty) {
        String senderId = message.data['sid'];
        bool isMessageForCurrentChat =
            senderId == ChatBloc().chatDetailsMap['sid'];
        return isMessageForCurrentChat;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> _storeMessageInDatabase(RemoteMessage message) async {
    try {
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
        'msg_status': '1',
        'showCount': 0,
        'isGroup': (message.data['rtype'] == '3') ? 1 : 0,
        'attachementExtension': 'pdf'
      };

      await _databaseHelper.insertMessage(messageData);
    } catch (e) {}
  }

  Future<bool> ifTokenExists() async {
    try {
      String? fcmToken = await _customerCache.getFCMToken(CacheKeys.fcmToken);
      return fcmToken != null;
    } catch (e) {
      return false;
    }
  }

  Future<String?> getToken() async {
    try {
      return await pushNotifications.getToken();
    } catch (e) {
      return null;
    }
  }
}

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  try {
    await _storeBackgroundMessageInDatabase(message);
  } catch (e) {
    rethrow;
  }
}

Future<void> _storeBackgroundMessageInDatabase(RemoteMessage message) async {
  try {
    Map<String, dynamic> messageData = {
      'rid': message.data['rid'],
      'msg': message.data['chatmsg'] ?? '',
      'msg_time': DateTime.parse(message.data['time']).toIso8601String(),
      'isReceiver': 1,
      'msg_id': message.data['id'],
      'rtype': message.data['rtype'],
      'quote_msg_id': message.data['quotemsg'] ?? '',
      'sid': message.data['sid'],
      'stype': message.data['stype'],
      'employee_name': message.data['username'] ?? '',
      'msg_type': message.data['type'],
      'msg_status': '1',
      'showCount': 0,
      'isGroup': (message.data['rtype'] == '3') ? 1 : 0,
      'attachementExtension': 'pdf'
    };
    await DatabaseHelper().insertMessage(messageData);
  } catch (e) {
    rethrow;
  }
}
