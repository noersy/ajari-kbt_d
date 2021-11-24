import 'dart:convert';

import 'package:ajari/config/firebase_reference.dart';
import 'package:ajari/model/kelas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class KelasProvider extends ChangeNotifier {
  static Kelas _kelas = Kelas.blankKelas();
  static List<Map<String, dynamic>> _listSantri = <Map<String, dynamic>>[];
  static List<Map<String, dynamic>> _listAbsen = <Map<String, dynamic>>[];
  static List<Map<String, dynamic>> _listDiskusi = <Map<String, dynamic>>[];
  static List<Map<String, dynamic>> _listMeet = <Map<String, dynamic>>[];

  Kelas get kelas => _kelas;
  List<Map<String, dynamic>> get listSantri => _listSantri;
  List<Map<String, dynamic>> get listAbsen => _listAbsen;
  List<Map<String, dynamic>> get listDiskusi => _listDiskusi;
  List<Map<String, dynamic>> get listMeet => _listMeet;

  void updateKelas(Kelas kelas) async {
    _kelas = kelas;
    notifyListeners();
  }

  void setJumlahSantri(int jumlah) async {
    _kelas.setJumlahSantri(jumlah);
    notifyListeners();
  }

  void _setSantri(QuerySnapshot snapshot){
    _listSantri = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    notifyListeners();
  }

  void _setAbsens(QuerySnapshot snapshot){
    _listAbsen = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    notifyListeners();
  }

  void _setDiskues(QuerySnapshot snapshot){
    _listDiskusi = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    notifyListeners();
  }

  void _setMeets(QuerySnapshot snapshot){
    _listMeet = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    notifyListeners();
  }

  Future<int> createKelas({
    required namaKelas,
    required User? user,
  }) async {
    try {
      if (user == null) throw Exception("user has null");

      String _code = FirebaseReference.getRandomString(5);

      Map<String, dynamic> dataKelas = <String, dynamic>{
        "nama": namaKelas,
        "pengajar": user.displayName,
        "pengajar_id": user.uid,
        "jumlah_santri": 0,
        "kelas_id": _code
      };

      Map<String, dynamic> dataUser = <String, dynamic>{"code_kelas": _code};

      await FirebaseReference.getKelas(_code).set(dataKelas);
      await FirebaseReference.getUser(user.uid).update(dataUser);

      updateKelas(kelasFromJson(jsonEncode(dataKelas)));

      return 200;
    } catch (e) {
      if (kDebugMode) {
        print("createKelas: $e");
      }
      return 400;
    }
  }

  Future<int> joinKelas({
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

      await FirebaseReference.getUserInKelas(codeKelas, user.uid).set(newUserInKelas);
      await FirebaseReference.getKelas(codeKelas).update(newDataKelas);
      await FirebaseReference.getUser(user.uid).update(newDataUser);

      //TODO:update data user
      updateKelas(kelasFromJson(jsonEncode(dataKelas)));

      return 200;
    } catch (e) {
      if (kDebugMode) {
        print("joinKelas: ${e.runtimeType}");
      }
      return 400;
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

  Future<int> getKelas({required String codeKelas}) async {
    try {
      var data = await FirebaseReference.getKelas(codeKelas).get();

      if (!data.exists && data.data() == null) throw throw Exception("Error");

      _kelas = kelasFromJson(jsonEncode(data.data()));

      updateKelas(kelas);

      return 200;
    } catch (e) {
      if (kDebugMode) {
        print("getKelas: Error");
      }
      return 400;
    }
  }

  Future<int>? getSantri({required codeKelas}) async {
    try {
      var data = await FirebaseReference.getKelas(codeKelas).collection('santri').get();

      _setSantri(data);

      return 200;
    } catch (e) {
      if (kDebugMode) {
        print("getKelas: Error");
      }
      return 400;
    }
  }



  Stream<QuerySnapshot> getMassage({ //TODO: Pisahkan ke provider lain
    required uid,
    required codeKelas,
    required nomorJilid,
    required nomorHalaman,
  }) {
    return FirebaseReference.getHalaman(
      codeKelas,
      uid,
      nomorJilid,
      nomorHalaman,)
        .collection('message')
        .orderBy("dateTime", descending: false)
        .snapshots();
  }

  Future<QuerySnapshot?> getGrade({ //TODO: Pisahkan ke provider lain
    required String uid,
    required String codeKelas,
    required String nomorJilid,
  }) async {
    try {
      if (codeKelas == "-")  throw Exception("Kelas blm ad");
      return await FirebaseReference.getUserInKelas(codeKelas, uid)
          .collection("jilid" + nomorJilid)
          .get();
    } catch (e) {
      if (kDebugMode) {
        print("getGrade: Error");
      }
      return null;
    }
  }

  Future<void> setGrade({ //TODO: Pisahkan ke provider lain
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

  Future<int> createAbsen({ //TODO: Pindah di kelas provider lain
    required DateTime date,
    required DateTime startAt,
    required DateTime endAt,
  }) async {
    try {

      if(_listSantri.isEmpty) throw Exception("_listSantri Empty");

      String random = FirebaseReference.getRandomString(21);

      Map<String, dynamic> data = {
        "id": random,
        "datetime": date,
        "start_at": startAt,
        "end_at": endAt,
      };

      await FirebaseReference.getAbsen(_kelas.kelasId, random).set(data);

      for (Map<String, dynamic> element in _listSantri) {

        Map<String, dynamic> _newData = {
          "name": element["name"],
          "uid": element["uid"],
          "photo": element["photo"],
          "kehadiran": false
        };

        await FirebaseReference.getAbsen(_kelas.kelasId, random).collection("santri").doc(element["uid"]).set(_newData);
      }

      await getAbsents();

      return 200;
    } catch (e) {
      if (kDebugMode) {
        print("createAbsen: $e");
      }
      return 400;
    }
  }

  Future<int> absent({//TODO: Pindah di kelas provider lain
    required String id,
    required String uid,
  }) async {
    try {
      Map<String, dynamic> _newData = {"kehadiran": true};

      await FirebaseReference.getAbsen(_kelas.kelasId, id)
          .collection("santri")
          .doc(uid)
          .update(_newData);

    } catch (e) {
      if (kDebugMode) {
        print("absent Error: ${e.runtimeType}");
        print(e);
      }
      return 400;
    }
    return 200;
  }

  Future<int> updateAbsen({//TODO: Pindah di kelas provider lain
    required String id,
    required DateTime date,
    required DateTime startAt,
    required DateTime endAt,
  }) async {
    try {
      Map<String, dynamic> newData = {
        "datetime": date,
        "start_at": startAt,
        "end_at": endAt,
      };

      await FirebaseReference.getAbsen(_kelas.kelasId, id).update(newData);
    } catch (e, r) {
      if (kDebugMode) {
        print("updateAbsen: ${e.runtimeType}");
        print("$e,\n$r");
      }
      return 400;
    }
    return 200;
  }

  Future<int> deleteAbsen({ //TODO: Pindah di kelas provider lain
    required String id,
  }) async {
    try {
      await FirebaseReference.getAbsen(_kelas.kelasId, id).delete();
      return 200;
    } catch (e) {
      if (kDebugMode) {
        print("deleteAbsen: Error");
      }
      return 400;
    }
  }

  Future<int> getAbsents() async { //TODO: Pindah di kelas provider lain
    try {
      var snap = await FirebaseReference.kelas
          .doc(_kelas.kelasId)
          .collection("absen")
          .orderBy("datetime", descending: false).get();

      _setAbsens(snap);

      return 200;
    } catch (e) {
      if (kDebugMode) {
        print("getAbsents: Error");
      }
      return 400;
    }
  }

  Future<QuerySnapshot?> getsAbsenStudents(String id) async { //TODO: Pindah di kelas provider lain
    try {
      return await FirebaseReference.kelas
          .doc(_kelas.kelasId)
          .collection("absen")
          .doc(id)
          .collection("santri")
          .orderBy("name", descending: false)
          .get();
    } catch (e) {
      if (kDebugMode) {
        print("getsAbsenStudents: Error");
      }
      return null;
    }
  }

  Future<int> createMeet({  //TODO: Pindah di kelas provider lain
    required DateTime date,
    required String subject,
  }) async {
    try {
      String codeMeet = FirebaseReference.getRandomString(12);
      String serverURL = "https://meet.jit.si/" + codeMeet;

      Map<String, dynamic> data = {
        "datetime": date,
        "subject": subject,
        "serverURL": serverURL,
        "codeMeet": codeMeet,
      };

      await FirebaseReference.getMeeting(_kelas.kelasId, date).set(data);
      await getsMeetings();
    } catch (e) {
      if (kDebugMode) {
        print("createMeet: ${e.runtimeType}");
        print(e);
        print(e);
      }
      return 400;
    }
    return 200;
  }

  Future<int> deleteMeet({required DateTime date}) async { //TODO: Pindah di kelas provider lain
    try {
      await FirebaseReference.getMeeting(_kelas.kelasId, date).delete();
      return 200;
    } catch (e) {
      if (kDebugMode) {
        print("deleteMeet: ${e.runtimeType}");
        print(e);
        print(e);
      }
      return 400;
    }
  }

  Future<int> getsMeetings() async { //TODO: Pindah di kelas provider lain
    try {
      var snap = await  FirebaseReference.kelas
          .doc(_kelas.kelasId)
          .collection("meet")
          .orderBy("datetime", descending: false)
          .get();

      _setMeets(snap);

      return 200;
    } catch (e) {
      if (kDebugMode) {
        print("getsMeetings: ${e.runtimeType}");
        print(e);
        print(e);
      }
      return 400;
    }
  }

  Future<int> getsDiskusies() async { //TODO: Pindah di kelas provider lain
    try {
      var snap = await FirebaseReference.kelas
          .doc(_kelas.kelasId)
          .collection("diskusi")
          .orderBy("datetime", descending: false)
          .get();

      _setDiskues(snap);

      return 200;
    } catch (e) {
      if (kDebugMode) {
        print("getsDiskusies: ${e.runtimeType}");
        print(e);
        print(e);
      }
      return 400;
    }
  }

  Stream<QuerySnapshot> getsMessagesInDiskusi({required id}) { //TODO: Pindah di kelas provider lain
    return FirebaseReference.kelas
        .doc(_kelas.kelasId)
        .collection("diskusi")
        .doc(id)
        .collection('message')
        .orderBy("datetime", descending: false)
        .snapshots();
  }

  Future<int> createDiskusi({ //TODO: Pindah di kelas provider lain
    required DateTime date,
    required String subject,
  }) async {
    try {
      String id = FirebaseReference.getRandomString(23);

      Map<String, dynamic> data = {
        "id": id,
        "datetime": date,
        "subject": subject,
      };

      await FirebaseReference.getDiskusi(_kelas.kelasId, id).set(data);
      await getsDiskusies();
    } catch (e) {
      if (kDebugMode) {
        print("createMeet: ${e.runtimeType}");
        print(e);
        print(e);
      }
      return 400;
    }
    return 200;
  }

  Future<int> sendMessageDiskusi({ //TODO: Pindah di kelas provider lain
    required String idDiskusi,
    required String message,
    required String role,
  }) async {
    try {
      String id = FirebaseReference.getRandomString(23);

      final user = FirebaseAuth.instance.currentUser;

      if (user == null) throw Exception("Error");

      Map<String, dynamic> data = {
        "id": id,
        "uid": user.uid,
        "name": user.displayName,
        "role": role,
        "datetime": DateTime.now(),
        "message": message,
      };

      await FirebaseReference.getDiskusi(_kelas.kelasId, idDiskusi)
          .collection("message")
          .doc(id)
          .set(data);
    } catch (e) {
      if (kDebugMode) {
        print("createMeet: ${e.runtimeType}");
        print(e);
        print(e);
      }
      return 400;
    }
    return 200;
  }
}
