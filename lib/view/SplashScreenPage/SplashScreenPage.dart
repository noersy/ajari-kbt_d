import 'dart:async';

import 'package:ajari/component/Dialog/DialogFailed.dart';
import 'package:ajari/component/Indicator/IndicatorLoad.dart';
import 'package:ajari/config/globals.dart' as globals;
import 'package:ajari/firebase/KelasProvider.dart';
import 'package:ajari/firebase/ProfileProvider.dart';
import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/view/DashboardPage/DashboardPage.dart';
import 'package:ajari/view/LoginPage/LoginPage.dart';
import 'package:ajari/view/LoginPage/RegisterPage/RegisterPage.dart';
import 'package:ajari/view/LoginPage/component/AuthLogin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    try {
      var user = await AuthLogin.signInWithGoogle(context: context);
      if (user == null) throw Exception("Not login");

      var prf = await Provider.of<ProfileProvider>(context, listen: false)
          .getProfile(userUid: user.uid);
      await Provider.of<KelasProvider>(context, listen: false)
          .getKelas(codeKelas: prf?.codeKelas ?? " ");

      if (prf == null)
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => RegisterPage(user: globals.Get.usr()),
          ),
        );
      else
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => DashboardPage(),
          ),
        );
    } catch (e, r) {
      if (globals.isUserNotNull) {
        showDialog(
          context: context,
          builder: (context) {
            return DialogFailed(
              content: "Whups something wrong",
            );
          },
        );
      }

      print("$e : $r");

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }
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
