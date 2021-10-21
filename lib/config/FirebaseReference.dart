

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseReference{

  static String _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static Random _rnd = Random();

  static String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));


  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static CollectionReference user = firestore.collection('user');
  static CollectionReference kelas = firestore.collection('kelas');
}


