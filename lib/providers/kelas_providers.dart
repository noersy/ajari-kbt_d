import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ajari/config/firebase_reference.dart';
import 'package:ajari/model/kelas.dart';
import 'package:ajari/model/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

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


  void clearData() {
    _kelas = Kelas.blankKelas();
    _listSantri = <Map<String, dynamic>>[];
    _listAbsen = <Map<String, dynamic>>[];
    _listDiskusi = <Map<String, dynamic>>[];
    _listMeet = <Map<String, dynamic>>[];

    notifyListeners();
  }

  void updateKelas(Kelas kelas) async {
    _kelas = kelas;
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

  static bool _isListenning = false;

  void closeKelasService() {
    _isListenning = false;
  }

  void instalizeKelasService(){
    try{

      if(_kelas.kelasId == "-") throw Exception("Not have kelas yet");
      _isListenning = true;

      final StreamController<QuerySnapshot> _streamSantri = StreamController();
      final StreamController<QuerySnapshot> _streamAbsen = StreamController();
      final StreamController<QuerySnapshot> _streamDiskusi = StreamController();
      final StreamController<QuerySnapshot> _streamMeet = StreamController();


      if(_listSantri.isEmpty){
        _streamSantri.addStream(FirebaseReference.getKelas(_kelas.kelasId).collection('santri').snapshots());
        _streamSantri.stream.listen((event) {
          _setSantri(event);

          if(!_isListenning){
            _streamSantri.close();
          }

        });
      }

      if(_listAbsen.isEmpty){
        _streamAbsen.addStream(FirebaseReference.kelas.doc(_kelas.kelasId).collection("absen").orderBy("datetime", descending: false).snapshots());
        _streamAbsen.stream.listen((event) {
          _setAbsens(event);

          if(!_isListenning){
            _streamAbsen.close();
          }


        });
      }

      if(_listDiskusi.isEmpty){
        _streamDiskusi.addStream(FirebaseReference.kelas.doc(_kelas.kelasId).collection("diskusi").orderBy("datetime", descending: false).snapshots());
        _streamDiskusi.stream.listen((event) {
          _setDiskues(event);

          if(!_isListenning){
            _streamDiskusi.close();
          }


        });
      }

      if(_listMeet.isEmpty){
        _streamMeet.addStream(FirebaseReference.kelas.doc(_kelas.kelasId).collection("meet").orderBy("datetime", descending: false).snapshots());
        _streamMeet.stream.listen((event) {
          _setMeets(event);

          if(!_isListenning){
            _streamMeet.close();
          }

        });
      }


    }catch(e){
      closeKelasService();
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<int> createKelas({
    required namaKelas,
    required Profile profile,
  }) async {
    try {
      if (profile.uid == "-") throw Exception("user has null");

      String _code = FirebaseReference.getRandomString(5);

      Map<String, dynamic> dataKelas = <String, dynamic>{
        "nama": namaKelas,
        "pengajar": profile.name,
        "pengajar_id": profile.uid,
        "jumlah_santri": 0,
        "kelas_id": _code
      };

      Map<String, dynamic> dataUser = <String, dynamic>{"code_kelas": _code};

      await FirebaseReference.getKelas(_code).set(dataKelas);
      await FirebaseReference.getUser(profile.uid).update(dataUser);

      updateKelas(kelasFromJson(jsonEncode(dataKelas)));

      getSantri();

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
      var data = dataKelas.data();


      await FirebaseReference.getUserInKelas(codeKelas, user.uid).set(newUserInKelas);
      await FirebaseReference.getKelas(codeKelas).update(newDataKelas);
      await FirebaseReference.getUser(user.uid).update(newDataUser);

      updateKelas(kelasFromJson(jsonEncode(data)));
      getSantri();

      return 200;
    } catch (e, r) {
      if (kDebugMode) {
        print("joinKelas: $e -- $r");
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

  Future<Map<String, dynamic>> getKelas({required String codeKelas}) async {
    try {
      var data = await FirebaseReference.getKelas(codeKelas).get();

      if (!data.exists && data.data() == null) throw throw Exception("Error");

      _kelas = kelasFromJson(jsonEncode(data.data()));

      updateKelas(kelas);

      return data.data() as Map<String, dynamic>;
    } catch (e) {
      if (kDebugMode) {
        print("getKelas: Error");
      }
      return {};
    }
  }

  Future<int> getSantri() async {
    try {
      var data = await FirebaseReference.getKelas(_kelas.kelasId).collection('santri').get();

      _setSantri(data);

      return 200;
    } catch (e) {
      if (kDebugMode) {
        print("getKelas: Error");
      }
      return 400;
    }
  }



  Stream<QuerySnapshot> getMassage({
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

  Stream<QuerySnapshot> getGrade({
    required String uid,
    required String codeKelas,
    required String nomorJilid,
  }) {
    try {
      if (codeKelas == "-")  throw Exception("Kelas blm ad");
      return FirebaseReference.getUserInKelas(codeKelas, uid)
          .collection("jilid" + nomorJilid)
          .snapshots();
    } catch (e) {
      if (kDebugMode) {
        print("getGrade: Error");
      }
      return const Stream.empty();
    }
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

  Future<int> createAbsen({
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

  Future<int> absent({
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

  Future<int> updateAbsen({
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

  Future<int> deleteAbsen({
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

  Future<int> getAbsents() async {
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

  Stream<QuerySnapshot> getsAbsenStudents(String id) {
    try {
      return FirebaseReference.kelas
          .doc(_kelas.kelasId)
          .collection("absen")
          .doc(id)
          .collection("santri")
          .orderBy("name", descending: false)
          .snapshots();
    } catch (e) {
      if (kDebugMode) {
        print("getsAbsenStudents: Error");
      }
      return const Stream.empty();
    }
  }

  Future<int> createMeet({
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

  Future<int> deleteMeet({required DateTime date}) async {
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

  Future<int> getsMeetings() async {
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

  Future<int> getsDiskusies() async {
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

  Stream<QuerySnapshot> getsMessagesInDiskusi({required id}) {
    return FirebaseReference.kelas
        .doc(_kelas.kelasId)
        .collection("diskusi")
        .doc(id)
        .collection('message')
        .orderBy("datetime", descending: false)
        .snapshots();
  }

  Future<int> createDiskusi({
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

  Future<int> sendMessageDiskusi({
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


  static const String dbPath = 'ajari.db';
  static final DatabaseFactory dbFactory = databaseFactoryIo;

  static Database? db;

  Future<void> setDatabase() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;
      db = await dbFactory.openDatabase(appDocPath + dbPath);
    } catch (e) {
      print(e);
    }
  }

  void storeLocalKelas(Map<String, dynamic> profile) async {
    try {
      var store = StoreRef.main();
      if (db == null) return;
      await store.record('kelas').put(db!, profile);
    } catch (e) {}
  }

  Future<Kelas> getLocalKelas() async {
    try {
      var store = StoreRef.main();
      if (db == null) throw Exception("error");
      var data = await store.record('kelas').get(db!);
      updateKelas(kelasFromJson(jsonEncode(data)));
      return kelasFromJson(jsonEncode(data));
    } catch (e,r) {
      print(e);
      print(r);
    }
    return Kelas.blankKelas();
  }

}
