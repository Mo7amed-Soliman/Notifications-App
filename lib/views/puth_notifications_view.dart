import 'package:flutter/material.dart';

class PuthNotificationsView extends StatelessWidget {
  const PuthNotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
      ),
      body: const Center(
        child: Text(
          'Push Notifiations',
          style: TextStyle(
            fontSize: 22,
            color: Colors.blueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
