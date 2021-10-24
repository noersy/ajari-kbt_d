import 'package:ajari/component/AppBar/AppBarNotification.dart';
import 'package:ajari/component/Indicator/IndicatorLoad.dart';
import 'package:ajari/firebase/DataProfileProvider.dart';
import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/view/DashboardPage/KelasPage/component/Pengajar.dart';
import 'package:ajari/view/DashboardPage/KelasPage/component/Santri.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClassPage extends StatefulWidget {
  final User user;

  ClassPage({required this.user});

  @override
  _ClassPageState createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  String codeKelas = '';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<DataProfileProvider>(context)
          .getProfile(userUid: widget.user.uid),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error initializing Firebase');
        } else if (snapshot.connectionState == ConnectionState.done) {
          this.codeKelas = snapshot.data!.get('code_kelas');
          return Scaffold(
            backgroundColor: PaletteColor.primarybg,
            appBar: AppBarNotification(
              ctx: context,
              title: 'Class',
            ),
            body: snapshot.data!.get('role') == "Santri"
                ? Santri(codeKelas: codeKelas, user: widget.user)
                : Pengajar(codeKelas: codeKelas, ctx: context, user: widget.user),
          );
        }
        return Scaffold(
          backgroundColor: PaletteColor.primarybg,
          appBar: AppBarNotification(
            ctx: context,
            title: "Class",
          ),
          body: indicatorLoad(),
        );
      },
    );
  }

}


