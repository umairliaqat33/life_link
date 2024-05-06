import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final _localNotification = FlutterLocalNotificationsPlugin();
  Future<void> initLocalNotification() async {
    const iOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestCriticalPermission: true,
      requestSoundPermission: true,
    );
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const setting = InitializationSettings(
      android: android,
      iOS: iOS,
    );
    await _localNotification.initialize(setting,
        onDidReceiveBackgroundNotificationResponse: (response) {
      debugPrint(response.payload.toString());
    });
  }

  Future<void> _showNotification(RemoteMessage remoteMessage) async {
    final styleInformation = BigTextStyleInformation(
      remoteMessage.notification!.body.toString(),
      htmlFormatBigText: true,
      contentTitle: remoteMessage.notification!.title,
      htmlFormatTitle: true,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
    );

    final androidDetails = AndroidNotificationDetails(
      'com.example.life_link.urgent',
      'my_channelid',
      importance: Importance.high,
      styleInformation: styleInformation,
      priority: Priority.max,
    );

    final notificationDetails = NotificationDetails(
      iOS: iosDetails,
      android: androidDetails,
    );

    await _localNotification.show(
      0,
      remoteMessage.notification!.title,
      remoteMessage.notification!.body,
      notificationDetails,
      payload: remoteMessage.data['body'],
    );
  }

  Future<void> requestPermission() async {
    final messaging = FirebaseMessaging.instance;

    final settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint("User granted notification permission");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint("User granted provisional notification permission");
    } else {
      debugPrint("User declined notification permission");
    }
  }

  Future<String?> getToken() async {
    final fCMToken = await FirebaseMessaging.instance.getToken();
    return fCMToken;
  }
}
