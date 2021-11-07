import 'dart:async';
import 'dart:convert';

import 'package:ajari/config/FirebaseReference.dart';
import 'package:ajari/model/Profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ajari/config/globals.dart' as globals;

class DataProfileProvider extends ChangeNotifier {
  // static String? userUid;

  static Future<void> createProfile({
    required String userid,
    required String role,
  }) async {
    DocumentReference documentReferencer = FirebaseReference.user.doc(userid);

    Map<String, dynamic> data = <String, dynamic>{
      "role": role,
      "code_kelas": ''
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("data role added to the database"))
        .catchError((e) => print(e));
  }

  static Future<void> updateProflie({
    required String userid,
    required String role,
  }) async {
    DocumentReference documentReferencer = FirebaseReference.user.doc(userid);

    Map<String, dynamic> data = <String, dynamic>{
      "role": role,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("data role update to the database"))
        .catchError((e) => print(e));
  }

  static Future<Profile?> getProfile({required userUid}) async {

    if(userUid == ""){
      print('Failed get profile');
      return null;
    }

    DocumentReference notesItemCollection = FirebaseReference.user.doc(userUid);
    DocumentSnapshot data = await notesItemCollection.get();
    Profile? profile;

    if (data.data() != null) {
      profile = profileFromJson(jsonEncode(data.data()));
      globals.Set.prf(profile);
      print('Success get profile');
    } else {
      profile = null;
      print('Failed get profile');
    }

    return profile;
  }

  static Future<String> chekRole({required userUid}) async {
    DocumentReference notesItemCollection = FirebaseReference.user.doc(userUid);

    DocumentSnapshot data = await notesItemCollection.get();

    if (!data.exists) {
      await createProfile(role: '', userid: userUid);
      return "Tidak ada";
    } else {
      return data.get("role");
    }
  }
}
