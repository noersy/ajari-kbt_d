import 'dart:async';
import 'dart:convert';

import 'package:ajari/config/FirebaseReference.dart';
import 'package:ajari/config/globals.dart' as globals;
import 'package:ajari/model/Profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  Future<void> createProfile({
    required String userid,
    required String role,
  }) async {
    try {
      Map<String, dynamic> data = <String, dynamic>{
        "role": role,
        "code_kelas": ''
      };

      await FirebaseReference.user.doc(userid).set(data);
      print("createProfile: Success");
    } catch (e) {
      print("createProfile: Error");
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

      print("updateProflie: Success");
    } catch (e) {
      print("updateProflie: Error");
    }
  }

  Future<Profile?> getProfile({required userUid}) async {
    try {
      if (userUid == "") throw Exception("Error");

      DocumentSnapshot data = await FirebaseReference.user.doc(userUid).get();

      if (!data.exists) throw Exception("Error");

      Profile profile = profileFromJson(jsonEncode(data.data()));
      globals.Set.prf(profile);
      print("getProfile: Success");

      return profile;
    } catch (e) {
      print("getProfile: Error");
    }
  }

  Future<String> chekRole({required userUid}) async {
    try {
      DocumentSnapshot data = await FirebaseReference.user.doc(userUid).get();

      if (!data.exists) throw Exception("Error");

      await createProfile(role: '', userid: userUid);

      print("chekRole: exists");
      return data.get("role");
    } catch (e) {
      print("chekRole: Not Found");
      return "Tidak ada";
    }
  }
}
