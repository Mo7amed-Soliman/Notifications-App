import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsService {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Future init() async {
    //* permissions
    await messaging.requestPermission();

    //* fcm token
    await messaging.getToken().then(
      (token) async {
        if (token != null) {
          await sendTokenToServer(token);
          log(token);
        }
      },
    );

    //* background and killed
    FirebaseMessaging.onBackgroundMessage(handlebackgroundMessage);
  }

  static Future<void> handlebackgroundMessage(RemoteMessage message) async {}

  static Future<void> sendTokenToServer(String token) async {
    //* send token to api
    //* send token to firebase
  }
}
