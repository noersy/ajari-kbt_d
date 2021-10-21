import 'dart:async';

import 'package:ajari/config/FirebaseReference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataProfileProvider extends ChangeNotifier {
  // static String? userUid;

  static Future<void> createProfile({
    required String userid,
    required String role,
  }) async {
    DocumentReference documentReferencer = FirebaseReference.user
        .doc(userid) ;

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
    DocumentReference documentReferencer = FirebaseReference.user
        .doc(userid) ;

    Map<String, dynamic> data = <String, dynamic>{
      "role": role,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("data role update to the database"))
        .catchError((e) => print(e));
  }

  Future<DocumentSnapshot> getProfile({required userUid}) async {
    DocumentReference notesItemCollection = FirebaseReference.user
        .doc(userUid) ;

    DocumentSnapshot data = await notesItemCollection.get();

    print(data.data());
    return data;
  }

  static Future<String> chekRole({required userUid}) async {
    DocumentReference notesItemCollection = FirebaseReference.user
        .doc(userUid);

    DocumentSnapshot data = await notesItemCollection.get();

    if (!data.exists) {
      await createProfile(role: '', userid: userUid);
      return "Tidak ada";
    } else {
      return data.get("role");
    }
  }

}
