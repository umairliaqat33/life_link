import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:life_link/UI/screens/incoming_patients_screen/incoming_patients_screen.dart';
import 'package:life_link/constants/constants.dart';
import 'package:life_link/controllers/firestore_controller.dart';
import 'package:life_link/utils/enums.dart';

void backgroundMessageHandler(NotificationResponse response) {
  log("Notification id: ${response.id}");
}

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
        onDidReceiveBackgroundNotificationResponse: backgroundMessageHandler
        // (response) {
        //   debugPrint(response.payload.toString());
        // },
        );
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

  Future<void> sendNotification({
    required String body,
    required String receiverUid,
    required UserType userType,
  }) async {
    FirestoreController firestoreController = FirestoreController();
    String fcmToken = await firestoreController.getReceiverFCMTokenViaUid(
      receiverUid,
      userType,
    );
    try {
      http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$cloudMessagingApi',
        },
        body: jsonEncode(
          <String, dynamic>{
            "to": fcmToken,
            "priority": 'high',
            "notification": <String, dynamic>{
              'body': body,
              "title": "New Message !"
            },
            'data': <String, String>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
            }
          },
        ),
      );
    } catch (e) {
      log(e.toString());
    }
  }

  void firebaseNotification(context) {
    initLocalNotification();
    //background notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      Get.to(IncomingPatientsScreen());
    });
    //foreground notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await _showNotification(message);
    });
  }
}
