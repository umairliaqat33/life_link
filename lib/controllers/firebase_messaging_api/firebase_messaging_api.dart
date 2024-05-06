import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:js_util';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:life_link/UI/screens/splash_screen/splash_screen.dart';
import 'package:life_link/main.dart';

class FirebaseMessagingApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final _localNotification = FlutterLocalNotificationsPlugin();
  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High_Importance_Notifications',
    description: "This Channel is used for important notifications",
    importance: Importance.defaultImportance,
  );

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    log("Token: $fCMToken");
    initPushNotifications();
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    navigatorKey.currentState!.pushNamed(
      SplashScreen.route,
      arguments: message,
    );
  }

  Future initLocalNotifications() async {
    const iOS = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const setting = InitializationSettings(
      android: android,
      iOS: iOS,
    );
    await _localNotification.initialize(
      setting,
    );
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      _localNotification.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@drawable/ic_launcher',
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });
  }
}

Future<void> handleBackgroundMessage(RemoteMessage remoteMessage) async {
  log("Title: ${remoteMessage.notification?.title}");
  log("Body: ${remoteMessage.notification?.body}");
  log("Payload: ${remoteMessage.data}");
}
