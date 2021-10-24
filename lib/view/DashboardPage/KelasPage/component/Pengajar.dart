


import 'package:ajari/component/Indicator/IndicatorLoad.dart';
import 'package:ajari/firebase/DataKelasProvider.dart';
import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/view/DashboardPage/KelasPage/component/CreateKelas.dart';
import 'package:ajari/view/DashboardPage/KelasPage/component/Joined.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Pengajar extends StatelessWidget {
  final BuildContext ctx;
  final User user;
  final String codeKelas;

  const Pengajar({required this.codeKelas, required this.ctx, required this.user});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<DataKelasProvider>(context)
          .getKelas(codeKelas: codeKelas),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (codeKelas == '') {
          return CreateKelas(ctx: ctx, user: user);
        } else if (snapshot.hasError) {
          return Text('Error initializing Firebase');
        } else if (snapshot.connectionState == ConnectionState.done) {
          return Joined(data: snapshot,);
        }
        return Scaffold(
          backgroundColor: PaletteColor.primarybg,
          body: indicatorLoad(),
        );
      },
    );
  }
}
