

import 'package:ajari/component/Indicator/IndicatorLoad.dart';
import 'package:ajari/firebase/DataKelasProvider.dart';
import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/view/DashboardPage/KelasPage/component/JoinKelas.dart';
import 'package:ajari/view/DashboardPage/KelasPage/component/Joined.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Santri extends StatelessWidget {
  final User user;
  final String codeKelas;

  const Santri({required this.codeKelas, required this.user});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<DataKelasProvider>(context)
          .getKelas(codeKelas: codeKelas),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (codeKelas == '') {
          return JoinKelas(user: user,);
        } else if (snapshot.hasError) {
          return Center(child: Text('Error initializing Firebase'));
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
