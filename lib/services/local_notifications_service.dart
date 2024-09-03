import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static StreamController<NotificationResponse> streamController =
      StreamController();

  static onTap(NotificationResponse notificationResponse) {
    streamController.add(notificationResponse);
  }

  static Future<void> init() async {
    InitializationSettings settings = const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    flutterLocalNotificationsPlugin.initialize(
      settings,
      onDidReceiveNotificationResponse: onTap,
      onDidReceiveBackgroundNotificationResponse: onTap,
    );
  }

  //* show basic Notification
  static Future<void> showBasicNotification(RemoteMessage message) async {
    StyleInformation? bigPictureStyleInformation =
        await fetchBigPictureStyleInfo(message);
    AndroidNotificationDetails android = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: bigPictureStyleInformation,
    );

    NotificationDetails details = NotificationDetails(
      android: android,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      message.data['title'],
      message.data['body'],
      details,
    );
  }

  static Future<StyleInformation?> fetchBigPictureStyleInfo(
      RemoteMessage message) async {
    BigPictureStyleInformation? bigPictureStyleInformation;

    try {
      final Dio dio = Dio();
      //? Make a GET request to the image URL, expecting a byte response
      await dio
          .get(
        message.data['image_url'],
        options: Options(responseType: ResponseType.bytes),
      )
          .then(
        // Process the response data
        (value) {
          //! Convert the byte data to a base64 string, then to a byte array
          //! for use in the BigPictureStyleInformation object

          bigPictureStyleInformation = BigPictureStyleInformation(
            ByteArrayAndroidBitmap.fromBase64String(
              base64Encode(value.data),
            ),
            largeIcon: ByteArrayAndroidBitmap.fromBase64String(
              base64Encode(value.data),
            ),
          );
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }

    return bigPictureStyleInformation;
  }
}
