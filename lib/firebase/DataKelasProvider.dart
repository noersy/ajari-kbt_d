import 'package:ajari/config/FirebaseReference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DataKelasProvider extends ChangeNotifier {
  static Future<void> createKelas({
    required namaKelas,
    required User user,
  }) async {
    String _code = FirebaseReference.getRandomString(5);
    DocumentReference documentReferencerKelas =
        FirebaseReference.kelas.doc(_code);
    DocumentReference documentReferencerUser =
        FirebaseReference.user.doc(user.uid);

    Map<String, dynamic> data = <String, dynamic>{
      "nama": namaKelas,
      "pengajar": user.displayName,
      "pengajar_id": user.uid,
      "jumlah_santri": 0,
      "kelas_id": _code
    };

    Map<String, dynamic> data2 = <String, dynamic>{"code_kelas": _code};

    await documentReferencerUser
        .update(data2)
        .whenComplete(() => print("data code class update to the profile user"))
        .catchError((e) => print(e));

    await documentReferencerKelas
        .set(data)
        .whenComplete(() => print("data kelas added to the database"))
        .catchError((e) => print(e));
  }

  static Future<String> joinKelas({
    required codeKelas,
    required User user,
  }) async {
    DocumentReference documentReferencerUser =
        FirebaseReference.user.doc(user.uid);
    DocumentReference documentReferencerKelas =
        FirebaseReference.kelas.doc(codeKelas);

    DocumentReference documentReferencerProfileinKelas = FirebaseReference.kelas
        .doc(codeKelas)
        .collection('santri')
        .doc(user.uid);


    Map<String, dynamic> data2 = <String, dynamic>{
      "code_kelas": codeKelas,
    };

    DocumentSnapshot santri = await documentReferencerKelas.get();
    Map<String, dynamic> data3 = <String, dynamic>{
      "jumlah_santri": santri.get('jumlah_santri') + 1
    };

    Map<String, dynamic> data = <String, dynamic>{
      "uid": user.uid,
      'name': user.displayName,
      'number': user.phoneNumber,
      'email': user.email,
      'photo': user.photoURL
    };

    bool kelasExist = false;
    await FirebaseReference.kelas.doc(codeKelas).get().then((value) => {
          if (value.exists)
            {
              kelasExist = true,
            }
        });

    if (kelasExist) {
      await documentReferencerProfileinKelas
          .set(data)
          .whenComplete(() => print("berhasil join kelas"))
          .catchError((e) => print(e));

      await documentReferencerKelas
          .update(data3)
          .whenComplete(() => print("berhasil join kelas"))
          .catchError((e) => print(e));

      await documentReferencerUser
          .update(data2)
          .whenComplete(
              () => print("data code class update to the profile user"))
          .catchError((e) => print(e));
      return 'Berhasil';
    }

    return 'Gagal';
  }

  static Future<void> sendMessage({
    required uid,
    required codeKelas,
    required nomorJilid,
    required nomorHalaman,
    required message,
    required role,
}) async {
    String _meesageID = FirebaseReference.getRandomString(22);

    DocumentReference documentReference = FirebaseReference
        .kelas.doc(codeKelas)
        .collection('santri')
        .doc(uid)
        .collection("jilid" + nomorJilid)
        .doc('halaman' + nomorHalaman)
        .collection('message')
        .doc(_meesageID);

    Map<String, dynamic> data = <String, dynamic>{
      "message": message,
      "role": role,
      "dateTime": DateTime.now()
    };

    await documentReference
        .set(data)
        .whenComplete(() => print("data kelas added to the database"))
        .catchError((e) => print(e));
  }

  Future<DocumentSnapshot> getKelas({required codeKelas}) async {
    DocumentReference documentReferencer =
        FirebaseReference.kelas.doc(codeKelas);

    DocumentSnapshot data = await documentReferencer.get();
    return data;
  }

  Stream<QuerySnapshot> getSantri({required codeKelas}) {
    CollectionReference documentReferencer =
        FirebaseReference.kelas.doc(codeKelas).collection('santri');
    return documentReferencer.snapshots();
  }

  Stream<QuerySnapshot> getMassage({
    required uid,
    required codeKelas,
    required nomorJilid,
    required nomorHalaman
  }){
    CollectionReference collectionReference = FirebaseReference
        .kelas.doc(codeKelas)
        .collection('santri')
        .doc(uid)
        .collection("jilid" + nomorJilid)
        .doc('halaman' + nomorHalaman)
        .collection('message');

    print(collectionReference);

    return collectionReference.orderBy("dateTime", descending: false).snapshots();
  }

  Stream<QuerySnapshot> getGrade({
    required uid,
    required codeKelas,
    required nomorJilid,
  }){
    CollectionReference collectionReference = FirebaseReference
        .kelas.doc(codeKelas)
        .collection('santri')
        .doc(uid)
        .collection("jilid" + nomorJilid);

    print(collectionReference);

    return collectionReference.snapshots();
  }

  static Future<void> setGrade({
    required uid,
    required grade,
    required codeKelas,
    required nomorJilid,
    required nomorHalaman
}) async {
    DocumentReference documentReference = FirebaseReference
        .kelas.doc(codeKelas)
        .collection('santri')
        .doc(uid)
        .collection("jilid" + nomorJilid)
        .doc('halaman' + nomorHalaman);

    Map<String, dynamic> data = {
      'grade' : grade,
    };

    await documentReference
        .update(data)
        .whenComplete(() => print("grade added to the database"))
        .catchError((e) => print(e));
  }
}
