import 'dart:async';
import 'dart:convert';

import 'package:ajari/component/Indicator/IndicatorLoad.dart';
import 'package:ajari/config/globals.dart' as globals;
import 'package:ajari/firebase/DataKelasProvider.dart';
import 'package:ajari/firebase/DataProfileProvider.dart';
import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/view/DashboardPage/DashboardPage.dart';
import 'package:ajari/view/LoginPage/LoginPage.dart';
import 'package:ajari/view/LoginPage/RegisterPage/RegisterPage.dart';
import 'package:ajari/view/LoginPage/component/AuthLogin.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenPage> {
  startTime() async {
    var _duration = new Duration(seconds: 3);
    return Timer(_duration, navigationPage);
  }

  navigationPage() async {
    globals.user = await AuthLogin.signInWithGoogle(context: context);
    globals.profile =
        await DataProfileProvider.getProfile(userUid: globals.user!.uid);
    globals.kelas =
        await DataKelasProvider.getKelas(codeKelas: globals.profile!.codeKelas);

    if (globals.profile != null) {
      print(jsonEncode(globals.profile));

      if (globals.profile!.role == "Tidak ada")
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => RegisterPage(user: globals.user!),
          ),
        );
      else
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => DashboardPage(),
          ),
        );
    } else
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthLogin.initializeFirebase(context: context),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return Text('Error initializing Firebase');
        } else if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            backgroundColor: PaletteColor.primarybg,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/images/ajarilogo.png",
                  ),
                ),
                indicatorLoad(),
              ],
            ),
          );
        }

        return Scaffold(
          body: indicatorLoad(),
        );
      },
    );
  }
}
