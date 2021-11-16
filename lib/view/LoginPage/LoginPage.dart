import 'package:ajari/component/Dialog/DialogFailed.dart';
import 'package:ajari/component/Indicator/IndicatorLoad.dart';
import 'package:ajari/config/globals.dart' as globals;
import 'package:ajari/firebase/KelasProvider.dart';
import 'package:ajari/firebase/ProfileProvider.dart';
import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/theme/TypographyStyle.dart';
import 'package:ajari/view/DashboardPage/DashboardPage.dart';
import 'package:ajari/view/LoginPage/component/ButtonLoginGoogle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'RegisterPage/RegisterPage.dart';
import 'component/AuthLogin.dart';
import 'component/ButtonLogin.dart';
import 'component/MainForms.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _nimFilter = TextEditingController();
  final TextEditingController _passwordFilter = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator = isLoading
        ? Container(
            color: Colors.black26,
            width: double.infinity,
            height: double.infinity,
            child: indicatorLoad(),
          )
        : Container();
    return Scaffold(
      backgroundColor: PaletteColor.primarybg,
      body: Stack(
        children: [
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(SpacingDimens.spacing24),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Image.asset(
                          'assets/images/ajarilogo.png',
                          width: 230,
                        ),
                      ),
                      MainForms(
                        nimFilter: _nimFilter,
                        passwordFilter: _passwordFilter,
                      ),
                      Container(
                        alignment: Alignment.topRight,
                        padding: const EdgeInsets.only(top: SpacingDimens.spacing16),
                        child: GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Forgot password?",
                            style: TypographyStyle.caption2.merge(
                              const TextStyle(
                                color: PaletteColor.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ButtonLogin(
                        onPressedFunction: onPressedFunction,
                        title: "Login",
                      ),
                      ButtonLoginGoogle(
                        onPressedFunction: loginWIthGoogle,
                      ),
                      const SizedBox(height: SpacingDimens.spacing8),
                      const Divider(),
                      const SizedBox(height: SpacingDimens.spacing8),
                      const Text("Not have account yet? Register now!"),
                      const SizedBox(height: SpacingDimens.spacing8),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            child: loadingIndicator,
            alignment: FractionalOffset.center,
          ),
        ],
      ),
    );
  }

  void loginWIthGoogle() async {
    setState(() {
      isLoading = true;
    });

    await AuthLogin.signInWithGoogle(context: context);

    setState(() {
      isLoading = false;
    });

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const DashboardPage(),
      ),
    );
  }

  void onPressedFunction() async {
    setState(() {
      isLoading = true;
    });

    try {
      await AuthLogin.signInWithGoogle(context: context);
      await Provider.of<ProfileProvider>(context, listen: false).getProfile(userUid: globals.Get.usr().uid);
      await Provider.of<KelasProvider>(context, listen: false).getKelas(codeKelas: globals.Get.prf().codeKelas);
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) {
          return DialogFailed(
            content: "Whups something wrong \n$e",
            onPressedFunction: () {
              Navigator.of(context).pop();
            },
          );
        },
      );
    }

    setState(() {
      isLoading = false;
    });

    if (globals.Get.prf().role == "-") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => RegisterPage(user: globals.Get.usr()),
        ),
      );
    }

    if (globals.isUserNotNull) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const DashboardPage(),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return DialogFailed(
            content: "Username or Password is Wrong",
            onPressedFunction: () => Navigator.of(context).pop(),
          );
        },
      );
    }
  }
}
