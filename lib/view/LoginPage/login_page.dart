import 'package:ajari/component/dialog/dialog_failed.dart';
import 'package:ajari/component/indicator/indicator_load.dart';
import 'package:ajari/model/profile.dart';
import 'package:ajari/providers/kelas_providers.dart';
import 'package:ajari/providers/profile_providers.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:ajari/view/DashboardPage/dashboard_page.dart';
import 'package:ajari/view/LoginPage/component/button_login_wgoogle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'RegisterPage/register_page.dart';
import 'component/auth_login.dart';
import 'component/button_login.dart';
import 'component/main_forms.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _nimFilter = TextEditingController();
  final TextEditingController _passwordFilter = TextEditingController();
  Profile? _profile;
  bool isLoading = false;

  @override
  void initState() {
    _profile = Provider.of<ProfileProvider>(context, listen: false).profile;
    super.initState();
  }

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
                        padding:
                            const EdgeInsets.only(top: SpacingDimens.spacing16),
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
                        onPressedFunction: onPressedFunction,
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
      await Provider.of<ProfileProvider>(context, listen: false)
          .getProfile(userUid: FirebaseAuth.instance.currentUser?.uid ?? "");
      await Provider.of<KelasProvider>(context, listen: false)
          .getKelas(codeKelas: _profile?.codeKelas ?? "");
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

    if (FirebaseAuth.instance.currentUser == null) {
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

    if (_profile == null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              RegisterPage(user: FirebaseAuth.instance.currentUser!),
        ),
      );
      return;
    }

    if (_profile!.role == "-") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              RegisterPage(user: FirebaseAuth.instance.currentUser!),
        ),
      );
      return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const DashboardPage(),
      ),
    );
  }
}
