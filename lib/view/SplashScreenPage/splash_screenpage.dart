import 'dart:async';

import 'package:ajari/component/dialog/dialog_failed.dart';
import 'package:ajari/component/indicator/indicator_load.dart';
import 'package:ajari/providers/kelas_providers.dart';
import 'package:ajari/providers/profile_providers.dart';
import 'package:ajari/view/DashboardPage/dashboard_page.dart';
import 'package:ajari/view/LoginPage/component/auth_login.dart';
import 'package:ajari/view/LoginPage/login_page.dart';
import 'package:ajari/view/LoginPage/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenPage>{

  startTime() async {
    var _duration = const Duration(seconds: 3);
    return Timer(_duration, navigationPage);
  }

  @override
  void initState() {
    startTime();
    super.initState();
  }

  navigationPage() async {
    try {
      await Provider.of<ProfileProvider>(context, listen: false).setDatabase();
      await Provider.of<KelasProvider>(context, listen: false).setDatabase();

      final localProfile = await Provider.of<ProfileProvider>(context, listen: false).getLocalProfile();

      if(localProfile.role != "-"){

        if(localProfile.codeKelas == "-"){
          final kelas = await Provider.of<KelasProvider>(context, listen: false).getKelas(codeKelas: localProfile.codeKelas);
          await Provider.of<KelasProvider>(context, listen: false).storeLocalKelas(kelas);
        }

        final kelas = await Provider.of<KelasProvider>(context, listen: false).getLocalKelas();

        if(kelas.kelasId == "-"){
          final kelas = await Provider.of<KelasProvider>(context, listen: false).getKelas(codeKelas: localProfile.codeKelas);
          await Provider.of<KelasProvider>(context, listen: false).storeLocalKelas(kelas);
        }

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const DashboardPage(),
          ),
        );
        return;
      }

      User? user = await AuthLogin.signInWithGoogle(context: context);

      if (user == null) throw Exception("Not login");

      final role = await Provider.of<ProfileProvider>(context, listen: false).chekRole(user: user);
      final prf = await Provider.of<ProfileProvider>(context, listen: false).getProfile(uid: user.uid);

      if (role == "-") {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const RegisterPage(),
          ),
        );
        return;
      }

      final kelas = await Provider.of<KelasProvider>(context, listen: false).getKelas(codeKelas: prf["code_kelas"]);

      await Provider.of<KelasProvider>(context, listen: false).storeLocalKelas(kelas);
      Provider.of<ProfileProvider>(context, listen: false).storeLocalProfile(prf);


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
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: AuthLogin.initializeFirebase(context: context),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error initializing Firebase'));
          } else if (snapshot.connectionState == ConnectionState.done) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Image.asset(
                      "assets/images/ajarilogo.png",
                    ),
                    Expanded(
                      child: indicatorLoad(),
                    ),
                  ],
                ),
              ),
            );
          }

          return indicatorLoad();
        },
      ),
    );
  }
}
