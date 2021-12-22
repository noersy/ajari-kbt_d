import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';


class NotificationProvider extends ChangeNotifier{
  static List<RemoteNotification?> _listNotification = [];
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  List<RemoteNotification?> get notification => _listNotification;

  Future<void> instalizeMessaging() async {
    print('instalizeMessaging');
    print(await _firebaseMessaging.getToken());
    FirebaseMessaging.onMessage.listen((event) {
      if (event.notification != null) {
        print('received massage');
        _listNotification.add(event.notification);
        notifyListeners();
      }
    });
  }
  Future<void> dismissAtIndex(int index) async {
    _listNotification.removeAt(index);
    print('dismiss massage');
    notifyListeners();
  }
}