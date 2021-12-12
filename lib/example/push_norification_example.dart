import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class PushNotification extends StatefulWidget {
  const PushNotification({Key? key}) : super(key: key);

  @override
  _PushNotificationState createState() => _PushNotificationState();
}

class _PushNotificationState extends State<PushNotification> {
  String messageTitle = "Empty";
  String notificationAlert = " test";
  String _toke = "token";

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

@override
  void initState() {

  FirebaseMessaging.onMessage.listen((event) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${event.data}');

    if (event.notification != null) {
      print('Message also contained a notification: ${event.notification?.title}');
      setState(() => messageTitle = event.data["test"]);
    }
  });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(messageTitle),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(23.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () async {
                String token = await _firebaseMessaging.getToken(vapidKey: "AIzaSyAFpqwZywZYDBxyGH_QJ3vqQsm5xwpFvds") ?? "null";
                String text = await _firebaseMessaging.getToken(vapidKey: "AIzaSyAFpqwZywZYDBxyGH_QJ3vqQsm5xwpFvds") ?? "null";

                print(token);
                setState(() {
                  _toke = token;
                });
              },
                child: Text(notificationAlert),
            ),
            Text(_toke),
          ],
        ),
      ),
    );
  }
}
