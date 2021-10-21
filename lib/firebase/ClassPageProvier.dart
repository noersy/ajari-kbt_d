
import 'package:ajari/config/FirebaseReference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClassPageProvider{
  Future<DocumentSnapshot> getKelas({required codeKelas}) async {
    DocumentReference documentReferencer =
    FirebaseReference.kelas.doc(codeKelas);

    DocumentSnapshot data = await documentReferencer.get();
    return data;
  }
}