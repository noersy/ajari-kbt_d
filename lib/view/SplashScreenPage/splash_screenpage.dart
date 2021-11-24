import 'dart:async';

import 'package:ajari/component/dialog/dialog_failed.dart';
import 'package:ajari/component/indicator/indicator_load.dart';
import 'package:ajari/providers/kelas_providers.dart';
import 'package:ajari/providers/profile_providers.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/view/DashboardPage/dashboard_page.dart';
import 'package:ajari/view/LoginPage/component/auth_login.dart';
import 'package:ajari/view/LoginPage/login_page.dart';
import 'package:ajari/view/LoginPage/selection_role.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenPage> with TickerProviderStateMixin {

  // late final AnimationController _controller = AnimationController(
  //   duration: const Duration(seconds: 3),
  //   vsync: this,
  // );
  //
  // final Tween<double> turnsTween = Tween<double>(
  //   begin: 3,
  //   end: 3.2,
  // );
  //
  // final Tween<double> turnsTween2 = Tween<double>(
  //   begin: 2.2,
  //   end: 2,
  // );
  //
  // final Tween<double> turnsTween3 = Tween<double>(
  //   begin: 1.3,
  //   end: 1.4,
  // );

  // late final Animation<double> _animation = CurvedAnimation(
  //   parent: _controller,
  //   curve: Curves.ease,
  // );


  startTime() async {
    var _duration = const Duration(seconds: 3);
    return Timer(_duration, navigationPage);
  }

  navigationPage() async {
    try {
      User? user = await AuthLogin.signInWithGoogle(context: context);
      if (user == null) throw Exception("Not login");
      final prf = await Provider.of<ProfileProvider>(context, listen: false).getProfile(userUid: user.uid);
      await Provider.of<KelasProvider>(context, listen: false).getKelas(codeKelas: prf.codeKelas);

      if (prf.role == "-") {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => SelectionPage(user: user),
          ),
        );
        return;
      }

      if(prf.role == "Pengajar") {
        await Provider.of<KelasProvider>(context, listen: false).getSantri(codeKelas: prf.codeKelas);
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
    startTime();
    super.initState();
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: AuthLogin.initializeFirebase(context: context),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error initializing Firebase'));
        } else if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            backgroundColor: PaletteColor.primarybg,
            body: Stack(
              children: [
                SingleChildScrollView(
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
                // Positioned(
                //   bottom: 5.0,
                //   left: -135.0,
                //   child: RotationTransition(
                //     turns: turnsTween.animate(_animation),
                //     child: Container(
                //       height: 190,
                //       width: 190,
                //       decoration: BoxDecoration(
                //           color: PaletteColor.primary,
                //           borderRadius: BorderRadius.circular(85.0),
                //       ),
                //     ),
                //   ),
                // ),
                // Positioned(
                //   bottom: -65.0,
                //   left: -65.0,
                //   child: RotationTransition(
                //     turns: turnsTween2.animate(_animation),
                //     child: Container(
                //       height: 190,
                //       width: 190,
                //       decoration: BoxDecoration(
                //           color: PaletteColor.primary,
                //           borderRadius: BorderRadius.circular(85.0),
                //       ),
                //     ),
                //   ),
                // ),
                // Positioned(
                //   bottom: -135.0,
                //   left: 25.0,
                //   child: RotationTransition(
                //     turns: turnsTween3.animate(_animation),
                //     child: Container(
                //       height: 190,
                //       width: 190,
                //       decoration: BoxDecoration(
                //           color: PaletteColor.primary,
                //           borderRadius: BorderRadius.circular(85.0),
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                ),
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
