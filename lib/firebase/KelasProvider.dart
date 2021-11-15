import 'dart:convert';

import 'package:ajari/config/FirebaseReference.dart';
import 'package:ajari/config/globals.dart' as globals;
import 'package:ajari/model/Kelas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class KelasProvider extends ChangeNotifier {
  Kelas? dataKelas;
  User? user;

  Future<String> createKelas({
    required namaKelas,
    required User user,
  }) async {
    try {
      String _code = FirebaseReference.getRandomString(5);

      Map<String, dynamic> dataKelas = <String, dynamic>{
        "nama": namaKelas,
        "pengajar": user.displayName,
        "pengajar_id": user.uid,
        "jumlah_santri": 0,
        "kelas_id": _code
      };

      Map<String, dynamic> dataUser = <String, dynamic>{"code_kelas": _code};

      await FirebaseReference.getKelas(_code).update(dataUser);
      await FirebaseReference.getUser(user.uid).set(dataKelas);

      print("createKelas: Success");
      return _code;
    } catch (e) {
      print("createKelas: Error");
      return "-";
    }
  }

  Future<String> joinKelas({
    required codeKelas,
    required User user,
  }) async {
    try {
      var kelas = await FirebaseReference.getKelas(codeKelas).get();

      Map<String, dynamic> newDataUser = <String, dynamic>{
        "code_kelas": codeKelas,
      };

      Map<String, dynamic> newDataKelas = <String, dynamic>{
        "jumlah_santri": kelas.get('jumlah_santri') + 1
      };

      Map<String, dynamic> newUserInKelas = <String, dynamic>{
        "uid": user.uid,
        'name': user.displayName,
        'number': user.phoneNumber,
        'email': user.email,
        'photo': user.photoURL
      };

      var dataKelas = await FirebaseReference.kelas.doc(codeKelas).get();
      if (!dataKelas.exists) throw Exception("Error");

      await FirebaseReference.getUserInKelas(codeKelas, user.uid)
          .set(newUserInKelas);
      await FirebaseReference.getKelas(codeKelas).update(newDataKelas);
      await FirebaseReference.getUser(user.uid).update(newDataUser);

      print("joinKelas: Success");
      return codeKelas;
    } catch (e) {
      print("joinKelas: Error");
      return "-";
    }
  }

  Future<void> sendMessage({
    required uid,
    required codeKelas,
    required nomorJilid,
    required nomorHalaman,
    required message,
    required role,
  }) async {
    try {
      String _messageId = FirebaseReference.getRandomString(22);

      Map<String, dynamic> data = <String, dynamic>{
        "message": message,
        "role": role,
        "dateTime": DateTime.now()
      };

      await FirebaseReference.getMassageUser(
        codeKelas,
        uid,
        nomorJilid,
        nomorHalaman,
        _messageId,
      ).set(data);

      print("sendMessage: Success");
    } catch (e) {
      print("sendMessage: Error");
    }
  }

  Future<Kelas?> getKelas({required String codeKelas}) async {
    try {
      var data = await FirebaseReference.getKelas(codeKelas).get();

      if (!data.exists) throw throw Exception("Error");

      Kelas kelas = kelasFromJson(jsonEncode(data.data()));
      globals.Set.kls(kelas);

      print("getKelas: Success");
      return kelas;
    } catch (e) {
      print("getKelas: Error");
    }
  }

  Stream<QuerySnapshot> getSantri({required codeKelas}) {
    return FirebaseReference.getKelas(codeKelas)
        .collection('santri')
        .snapshots();
  }

  Stream<QuerySnapshot> getMassage({
    required uid,
    required codeKelas,
    required nomorJilid,
    required nomorHalaman,
  }) {
    return FirebaseReference.getHalaman(
            codeKelas, uid, nomorJilid, nomorHalaman)
        .collection('message')
        .orderBy("dateTime", descending: false)
        .snapshots();
  }

  Stream<QuerySnapshot> getGrade({
    required uid,
    required codeKelas,
    required nomorJilid,
  }) {
    return FirebaseReference.getUserInKelas(codeKelas, uid)
        .collection("jilid" + nomorJilid)
        .snapshots();
  }

  Future<void> setGrade({
    required uid,
    required grade,
    required codeKelas,
    required nomorJilid,
    required nomorHalaman,
  }) async {
    try {
      Map<String, dynamic> data = {'grade': grade, 'halaman': nomorHalaman};

      await FirebaseReference.getHalaman(
        codeKelas,
        uid,
        nomorJilid,
        nomorHalaman,
      ).set(data);

      print("setGrade: Success");
    } catch (e) {
      print("setGrade: Error");
    }
  }

  Future<int> createAbsen({
    required DateTime date,
  }) async {
    try {
      Map<String, dynamic> data = {"datetime": date};

      await FirebaseReference.getAbsen(globals.Get.kls().kelasId, date)
          .set(data);

      print("createAbsen: Success");
    } catch (e) {
      print("createAbsen: Error");
      return 400;
    }
    return 200;
  }

  Future<int> deleteAbsen({
    required DateTime date,
  }) async {
    try {
      await FirebaseReference.getAbsen(globals.Get.kls().kelasId, date).delete();

      print("deleteAbsen: Success");
    } catch (e) {
      print("deleteAbsen: Error");
      return 400;
    }
    return 200;
  }

  Stream<QuerySnapshot> getsAbsen() {
    return FirebaseReference.kelas
        .doc(globals.Get.kls().kelasId)
        .collection("absen")
        .orderBy("datetime", descending: false)
        .snapshots();
  }
}
