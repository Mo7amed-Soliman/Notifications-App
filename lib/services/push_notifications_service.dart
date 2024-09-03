import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:notifications_app/services/local_notifications_service.dart';

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

    //* foreground
    handleForegroundMessage();
  }

  static Future<void> handlebackgroundMessage(RemoteMessage message) async {
    //* show local notification
    await LocalNotificationService.showBasicNotification(message);
  }

  static void handleForegroundMessage() {
    //* on message listen for notification when app is in foreground
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async {
        //* show local notification
        await LocalNotificationService.showBasicNotification(message);
      },
    );
  }

  static Future<void> sendTokenToServer(String token) async {
    //* send token to api
    //* send token to firebase
  }
}
 

//? Test push messages via Postman and Firebase Cloud Messaging API (V1)
//! Link: https://medium.com/@sekitafilovic/send-push-messages-via-postman-and-firebase-cloud-messaging-api-v1-3c63bc69fec8
