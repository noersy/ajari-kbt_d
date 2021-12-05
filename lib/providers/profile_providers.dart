import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ajari/config/firebase_reference.dart';
import 'package:ajari/model/profile.dart';
import 'package:ajari/view/ProfilePage/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

class ProfileProvider extends ChangeNotifier {
  Profile _profile = Profile.blankProfile();

  Profile get profile => _profile;

  void setProfile(Profile profile) {
    _profile = profile;
    notifyListeners();
  }

  Future<void> createProfile({
    required String role,
    required User user,
    String? username,
    String? password,
  }) async {
    try {
      Map<String, dynamic> data = <String, dynamic>{
        "uid": user.uid,
        "name": user.displayName,
        "email": user.email,
        "username": username ?? "-",
        "password": password ?? "-",
        "urlImage": user.photoURL,
        "role": role,
        "code_kelas": '-'
      };

      await FirebaseReference.user.doc(user.uid).set(data);
    } catch (e) {
      if (kDebugMode) {
        print("createProfile: Error");
      }
    }
  }

  Future<void> deleteProfile({
    required String userid,
  }) async {
    try {
      await FirebaseReference.user.doc(userid).delete();
      if (_profile.codeKelas != "-") {
        await FirebaseReference.getUserInKelas(_profile.codeKelas, userid).delete();
      }
    } catch (e) {
      if (kDebugMode) {
        print("deleteProfile: Error");
      }
    }
  }

  Future<void> updateProflie({
    required String userid,
    required String role,
  }) async {
    try {
      Map<String, dynamic> data = <String, dynamic>{
        "role": role,
      };

      await FirebaseReference.user.doc(userid).update(data);
    } catch (e) {
      if (kDebugMode) {
        print("updateProflie: Error");
      }
    }
  }

  Future<Map<String, dynamic>> getProfile({required String uid}) async {
    try {
      if (uid == "-") throw Exception("User is null : $uid");

      final DocumentSnapshot documentSnapshot =
          await FirebaseReference.user.doc(uid).get();
      var data = documentSnapshot.data() as Map<String, dynamic>?;

      if (data == null) throw Exception("Data is $data");

      final Profile profile = profileFromJson(jsonEncode(data));

      setProfile(profile);

      return data;
    } catch (e, r) {
      if (kDebugMode) {
        print("getProfile: $e");
        print("$r");
      }
    }
    return {};
  }

  Future<String> chekRole({required User user}) async {
    try {
      DocumentSnapshot data = await FirebaseReference.user.doc(user.uid).get();

      if (!data.exists) throw Exception("Error");

      await createProfile(role: '', user: user);

      return data.get("role");
    } catch (e) {
      if (kDebugMode) {
        print("chekRole: Not Found");
      }
      return "Tidak ada";
    }
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

  void storeLocalProfile(Map<String, dynamic> profile) async {
    try {
      var store = StoreRef.main();
      if (db == null) return;
      await store.record('profile').put(db!, profile);
    } catch (e) {}
  }

  Future<Profile> getLocalProfile() async {
    try {
      var store = StoreRef.main();
      if (db == null) throw Exception("error");
      var data = await store.record('profile').get(db!);
      setProfile(profileFromJson(jsonEncode(data)));
      return profileFromJson(jsonEncode(data));
    } catch (e,r) {
      print(e);
      print(r);
    }
    return Profile.blankProfile();
  }
}
