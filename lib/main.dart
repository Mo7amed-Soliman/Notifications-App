import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notifications_app/firebase_options.dart';
import 'package:notifications_app/services/push_notifications_service.dart';
import 'package:notifications_app/views/puth_notifications_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await PushNotificationsService.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Notifications App',
      debugShowCheckedModeBanner: false,
      home: PuthNotificationsView(),
    );
  }
}
