import 'dart:async';
import 'dart:convert';

import 'package:ajari/config/firebase_reference.dart';
import 'package:ajari/model/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class ProfileProvider extends ChangeNotifier {
  Profile _profile = Profile.blankProfile();
  Profile get profile => _profile;

  void setProfile(Profile profile){
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
        "username" : username ?? "-",
        "password" : password ?? "-",
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
      if(_profile.codeKelas != "-") {
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

  Future<Profile> getProfile({required String uid}) async {
    try {
      if(uid == "-") throw Exception("User is null : $uid");

      final DocumentSnapshot documentSnapshot = await FirebaseReference.user.doc(uid).get();
      var data  = documentSnapshot.data() as Map<String, dynamic>?;

      if(data == null) throw Exception("Data is $data");

      final Profile profile = profileFromJson(jsonEncode(data));

      setProfile(profile);

      return profile;
    } catch (e, r) {
      if (kDebugMode) {
        print("getProfile: $e");
        print("$r");
      }
    }
    return Profile.blankProfile();
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
}
