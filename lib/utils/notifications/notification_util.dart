import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationUtil {
  final pushNotifications = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await pushNotifications.requestPermission();
    // check in shared preferences if fcm token exists
    // if true {do not call  final fcmToken = await pushNotifications.getToken();}

    // if false { call this final fcmToken = await pushNotifications.getToken();} and
    // 1.Call POST API :
    // url : -https://api.toolkitx.com/api/common/saveuserdevice
    //{
    //   "hashcode": "okjh+5Bd0X6pP58cPSvDG/qAaxg9XtHmDbAGb9Bko2OKMQJSpw2qxnJPUnp7aBIb|3|2|1|cet_3",
    //   "deviceid": "xxx",
    //   "token": "fcmToken"
    // }

    // 2.and on success of the above api save it in the preferences
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  log('Notification title ${message.notification!.title}');
  log('Notification body ${message.notification!.body}');
}
