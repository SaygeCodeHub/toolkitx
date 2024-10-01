import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:toolkit/blocs/chat/chat_bloc.dart';
import 'package:toolkit/blocs/chat/chat_event.dart';
import 'package:toolkit/screens/chat/chat_messaging_screen.dart';
import 'package:toolkit/utils/global.dart';

import '../../data/cache/cache_keys.dart';
import '../../data/cache/customer_cache.dart';
import '../../di/app_module.dart';
import '../database/database_util.dart';

class NotificationUtil {
  final pushNotifications = FirebaseMessaging.instance;
  static final CustomerCache _customerCache = getIt<CustomerCache>();
  final DatabaseHelper _databaseHelper = getIt<DatabaseHelper>();
  final chatBloc = ChatBloc();

  Future<void> initNotifications() async {
    await pushNotifications.requestPermission();
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('notification message data ${message.data}');
      if (message.data['ischatmsg'] == '1') {
        await _storeMessageInDatabase(message).then((result) {
          if (chatScreenName == ChatMessagingScreen.routeName) {
            chatBloc.add(RebuildChatMessagingScreen(
                employeeDetailsMap: chatBloc.chatDetailsMap));
          } else {
            chatBloc.add(FetchChatsList());
          }
        }).catchError((error) {});
      }
      if (message.data['ischatgrouprequest'] == '1') {
        chatBloc.add(FetchGroupInfo(groupId: message.data['group_id']));
      }
    });
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
      'msg_status': '1',
      'isMessageUnread': 1,
      'isGroup': (message.data['rtype'] == '3') ? 1 : 0,
      'attachementExtension': 'pdf',
      'sender_name': message.data['sendername'],
      'clientid': message.data['clientid']
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
  if (message.data['ischatmsg'] == '1') {
    Map<String, dynamic> messageData = {
      'rid': message.data['rid'] ?? '',
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
      'isMessageUnread': 1,
      'isGroup': (message.data['rtype'] == '3') ? 1 : 0,
      'attachementExtension': 'pdf',
      'sender_name': message.data['sendername'],
      'clientid': message.data['clientid']
    };
    await DatabaseHelper().insertMessage(messageData);
  }
}
