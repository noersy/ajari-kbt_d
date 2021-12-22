
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
