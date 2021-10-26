import 'package:ajari/component/AppBar/AppBarBack.dart';
import 'package:ajari/config/PathIqro.dart';
import 'package:ajari/config/globals.dart' as globals;
import 'package:ajari/firebase/DataKelasProvider.dart';
import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/view/DashboardPage/HomePage/ReadPage/HalamanPage/HalamanPage.dart';
import 'package:ajari/view/DashboardPage/HomePage/ReadPage/component/HalamanContainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReadPage extends StatefulWidget {
  final String nomor;

  ReadPage({
    required this.nomor,
  });

  @override
  _ReadPageState createState() => _ReadPageState();
}

class _ReadPageState extends State<ReadPage> {
  final User _user = globals.user!;
  final String _codeKelas =
      globals.profile!.codeKelas.isNotEmpty ? globals.profile!.codeKelas : "-";
  final String _role =
      globals.profile!.role.isNotEmpty ? globals.profile!.role : "-";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColor.primarybg,
      appBar: AppBarBack(
        ctx: context,
        title: 'Jilid ${widget.nomor}',
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: Provider.of<DataKelasProvider>(context).getGrade(
              uid: _user.uid,
              codeKelas: _codeKelas,
              nomorJilid: widget.nomor,
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return Center(child: Text("No data."));

              List<QueryDocumentSnapshot<Object?>> dat = snapshot.data!.docs;
              List<Map<String, String>> _dataDump = [];
              int _length = 10 - dat.length;
              int i = dat.length - 1;

              if (snapshot.data!.docChanges.length == 0) {
                print(snapshot.data!.docs);
                i = 1;
                _length = 10;
              }

              while (_length >= -1) {
                _dataDump.add({'halaman': '$i'});
                _length--;
                i++;
              }

              return ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  var data = {};

                  if (dat.length > index) data = dat[index].data() as Map;

                  if (data['halaman'] == null) data = _dataDump[index];

                  return HalamanContainer(
                    ctx: context,
                    uid: _user.uid,
                    role: _role,
                    grade: data['grade'] != null ? "${data['grade']}" : '-',
                    codeKelas: _codeKelas,
                    nomorHalaman: "${data['halaman']}",
                    nomorJilid: widget.nomor,
                    inTo: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HalamanPage(
                            uid: _user.uid,
                            role: _role,
                            grade: data['grade'] != null
                                ? "${data['grade']}"
                                : 'E',
                            codeKelas: _codeKelas,
                            nomorJilid: widget.nomor,
                            nomorHalaman: "${data['halaman']}",
                            pathBacaan: PathIqro.mainImagePath +
                                "/jilid${widget.nomor}" +
                                "/halaman${data['halaman']}" +
                                ".png",
                            pathAudio: PathIqro.mainAudioPath +
                                "/jilid${widget.nomor}" +
                                "/halaman${data['halaman']}" +
                                ".png",
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            }),
      ),
    );
  }
}
