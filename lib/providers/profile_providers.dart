import 'dart:async';
import 'dart:convert';

import 'package:ajari/config/firebase_reference.dart';
import 'package:ajari/model/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ProfileProvider extends ChangeNotifier {
  Profile _profile = Profile.blankProfile();
  Profile get profile => _profile;

  void setProfile(Profile profile){
    _profile = profile;
    notifyListeners();
  }

  Future<void> createProfile({
    required String userid,
    required String role,
  }) async {
    try {
      Map<String, dynamic> data = <String, dynamic>{
        "role": role,
        "code_kelas": '-'
      };

      await FirebaseReference.user.doc(userid).set(data);
    } catch (e) {
      if (kDebugMode) {
        print("createProfile: Error");
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

  Future<Profile?> getProfile({required userUid}) async {
    try {
      if (userUid == "") throw Exception("Error");

      final DocumentSnapshot data = await FirebaseReference.user.doc(userUid).get();

      final Profile profile = profileFromJson(jsonEncode(data.data()));

      setProfile(profile);

      return profile;
    } catch (e, r) {
      if (kDebugMode) {
        print("getProfile: Error : $e");
        print("$r");
      }
    }
  }

  Future<String> chekRole({required userUid}) async {
    try {
      DocumentSnapshot data = await FirebaseReference.user.doc(userUid).get();

      if (!data.exists) throw Exception("Error");

      await createProfile(role: '', userid: userUid);

      return data.get("role");
    } catch (e) {
      if (kDebugMode) {
        print("chekRole: Not Found");
      }
      return "Tidak ada";
    }
  }
}
