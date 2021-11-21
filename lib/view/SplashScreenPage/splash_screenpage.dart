import 'dart:async';

import 'package:ajari/component/dialog/dialog_failed.dart';
import 'package:ajari/component/indicator/indicator_load.dart';
import 'package:ajari/model/profile.dart';
import 'package:ajari/providers/kelas_providers.dart';
import 'package:ajari/providers/profile_providers.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/view/DashboardPage/dashboard_page.dart';
import 'package:ajari/view/LoginPage/selection_role.dart';
import 'package:ajari/view/LoginPage/component/auth_login.dart';
import 'package:ajari/view/LoginPage/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenPage> {
  startTime() async {
    var _duration = const Duration(seconds: 3);
    return Timer(_duration, navigationPage);
  }

  navigationPage() async {
    try {
      User? user = await AuthLogin.signInWithGoogle(context: context);
      if (user == null) throw Exception("Not login");
      Profile? prf = await Provider.of<ProfileProvider>(context, listen: false).getProfile(userUid: user.uid);
      await Provider.of<KelasProvider>(context, listen: false).getKelas(codeKelas: prf?.codeKelas ?? " ");

      if (prf == null) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => SelectionPage(user: user),
          ),
        );
      }

      if(prf!.role == "-"){
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => SelectionPage(user: user),
          ),
        );
      }

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const DashboardPage(),
        ),
      );
    } catch (e) {
      if (FirebaseAuth.instance.currentUser != null) {
        showDialog(
          context: context,
          builder: (context) {
            return DialogFailed(
              content: "Whups something wrong",
              onPressedFunction: () {
                Navigator.of(context).pop();
              },
            );
          },
        );
      }

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
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
          return const Text('Error initializing Firebase');
        } else if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            backgroundColor: PaletteColor.primarybg,
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
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
