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
      if (message.data['ischatmsg'] == '1') {
        var employeeDetailsMap = {
          'rid': message.data['sid'] ?? '',
          'rtype': message.data['stype'] ?? '',
          'employee_name': message.data['username']
        };
        await _storeMessageInDatabase(message).then((result) {
          if (!_isMessageForCurrentChat(message)) {
            employeeDetailsMap['rid'] =
                chatBloc.chatDetailsMap['rid'] ?? message.data['rid'];
            employeeDetailsMap['rtype'] =
                chatBloc.chatDetailsMap['rtype'] ?? message.data['rtype'];
            employeeDetailsMap['employee_name'] =
                chatBloc.chatDetailsMap['employee_name'] ??
                    message.data['username'];
          }
        }).catchError((error) {
          print('error storing message in db $error');
        }).then((result) {
          if (chatScreenName == ChatMessagingScreen.routeName) {
            chatBloc.add(RebuildChatMessagingScreen(
                employeeDetailsMap: employeeDetailsMap));
          } else {
            chatBloc.add(FetchChatsList());
          }
        }).catchError((error) {
          print('error calling the rebuild chat event $error');
        });
      }
      if (message.data['ischatgrouprequest'] == '1') {
        chatBloc.add(FetchGroupInfo(groupId: message.data['group_id']));
      }
    });
  }

  bool _isMessageForCurrentChat(RemoteMessage message) {
    if (message.data.isNotEmpty) {
      String senderId = message.data['rid'];
      String senderType = message.data['rid'];
      bool isMessageForCurrentChat =
          senderId == ChatBloc().chatDetailsMap['rid'] &&
              senderType == ChatBloc().chatDetailsMap['rid'];
      print('isMessageForCurrentChat $isMessageForCurrentChat');
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
      'msg_status': '1',
      'isMessageUnread': 1,
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
  if (message.data['ischatmsg'] == '1') {
    Map<String, dynamic> messageData = {
      'rid': message.data['rid'] ?? '',
      'msg': message.data['chatmsg'] ?? '',
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
      'attachementExtension': 'pdf'
    };
    await DatabaseHelper().insertMessage(messageData);
  }
}
