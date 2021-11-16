import 'dart:convert';

import 'package:ajari/config/firebase_reference.dart';
import 'package:ajari/model/kelas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class KelasProvider extends ChangeNotifier {
  Kelas _dataKelas = Kelas.blankKelas();

  Kelas get kelas => _dataKelas;

  void setKelas(kelas) {
    _dataKelas = kelas;
    notifyListeners();
  }

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

      return _code;
    } catch (e) {
      if (kDebugMode) {
        print("createKelas: Error");
      }
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

      return codeKelas;
    } catch (e) {
      if (kDebugMode) {
        print("joinKelas: Error");
      }
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
    } catch (e) {
      if (kDebugMode) {
        print("sendMessage: Error");
      }
    }
  }

  Future<Kelas?> getKelas({required String codeKelas}) async {
    try {
      var data = await FirebaseReference.getKelas(codeKelas).get();

      if (!data.exists) throw throw Exception("Error");

      Kelas kelas = kelasFromJson(jsonEncode(data.data()));
      setKelas(kelas);

      return kelas;
    } catch (e) {
      if (kDebugMode) {
        print("getKelas: Error");
      }
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

  static Future<int> fetchMassage({
    required uid,
    required codeKelas,
    required nomorJilid,
    required nomorHalaman,
  }) async {
    try {
      var data = await FirebaseReference.getHalaman(
              codeKelas, uid, nomorJilid, nomorHalaman)
          .collection('message')
          .get();
      return data.size;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return 0;
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
    } catch (e) {
      if (kDebugMode) {
        print("setGrade: Error");
      }
    }
  }

  Future<int> createAbsen({required DateTime date}) async {
    try {
      Map<String, dynamic> data = {"datetime": date};
      await FirebaseReference.getAbsen(_dataKelas.kelasId, date).set(data);
    } catch (e) {
      if (kDebugMode) {
        print("createAbsen: Error");
      }
      return 400;
    }
    return 200;
  }

  Future<int> deleteAbsen({
    required DateTime date,
  }) async {
    try {
      await FirebaseReference.getAbsen(_dataKelas.kelasId, date)
          .delete();
    } catch (e) {
      if (kDebugMode) {
        print("deleteAbsen: Error");
      }
      return 400;
    }
    return 200;
  }

  Stream<QuerySnapshot> getsAbsen() {
    return FirebaseReference.kelas
        .doc(_dataKelas.kelasId)
        .collection("absen")
        .orderBy("datetime", descending: false)
        .snapshots();
  }
}
