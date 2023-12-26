import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  log('Title========>${message.notification!.title}');
  log('body========>${message.notification!.body}');
  log('Payload========>${message.data}');
}

class FirebaseApi {
  final _firebasemessaging = FirebaseMessaging.instance;

  void handleMessage(RemoteMessage? message) async {
    if (message == null) return;
    // MyApp.navigatorKey.currentState?.push(MaterialPageRoute(builder: (context) => NotificationScreen(message: message,),));
  }

  Future<void> initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
        alert: true, badge: true, sound: true);
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<void> initNotifications() async {
    await _firebasemessaging.requestPermission();
    final fCMToken = await _firebasemessaging.getToken();
    log('token===========>$fCMToken');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    initNotifications();
  }
}
