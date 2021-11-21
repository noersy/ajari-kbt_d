import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseReference {
  static const String _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static final Random _rnd = Random();

  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static CollectionReference user = firestore.collection('user');
  static CollectionReference kelas = firestore.collection('kelas');

  static DocumentReference getUser(String uid) => user.doc(uid);

  static DocumentReference getKelas(String kelasId) => kelas.doc(kelasId);

  static DocumentReference getUserInKelas(String kelasId, String uid) {
    return kelas.doc(kelasId).collection('santri').doc(uid);
  }

  static DocumentReference getMassageUser(
    String kelasId,
    String uid,
    String jilidId,
    String halamanId,
    String messageId,
  ) {
    return getUserInKelas(kelasId, uid)
        .collection("jilid" + jilidId)
        .doc('halaman' + halamanId)
        .collection('message')
        .doc(messageId);
  }

  static DocumentReference getHalaman(
    String kelasId,
    String uid,
    String jilidId,
    String halamanId,
  ) {
    return getUserInKelas(kelasId, uid)
        .collection("jilid" + jilidId)
        .doc('halaman' + halamanId);
  }

  static DocumentReference getAbsen(
    String kelasId,
    DateTime date,
  ) {
    return kelas.doc(kelasId).collection("absen").doc("$date");
  }

  static DocumentReference getMeeting(
    String kelasId,
    DateTime date,
  ) {
    return kelas.doc(kelasId).collection("meet").doc("$date");
  }

  static String getRandomString(int length) {
    return String.fromCharCodes(
      Iterable.generate(
          length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))),
    );
  }
}
