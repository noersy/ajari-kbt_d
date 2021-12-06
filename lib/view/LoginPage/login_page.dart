import 'package:ajari/component/dialog/dialog_failed.dart';
import 'package:ajari/component/indicator/indicator_load.dart';
import 'package:ajari/config/firebase_reference.dart';
import 'package:ajari/providers/kelas_providers.dart';
import 'package:ajari/providers/profile_providers.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:ajari/view/DashboardPage/dashboard_page.dart';
import 'package:ajari/view/LoginPage/component/button_login_wgoogle.dart';
import 'package:ajari/view/LoginPage/register_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'component/auth_login.dart';
import 'component/button_login.dart';
import 'component/main_forms.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
                        nimFilter: _usernameController,
                        passwordFilter: _passwordController,
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
                        title: "Sign In",
                      ),
                      ButtonLoginGoogle(
                        onPressedFunction: loginWIthGoogle,
                        label: "Sign In with Google",
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

    try{
      User? user = await AuthLogin.signInWithGoogle(context: context);
      if (user == null) throw Exception("Not login");
      final prf = await Provider.of<ProfileProvider>(context, listen: false).getProfile(uid: user.uid);
      await Provider.of<KelasProvider>(context, listen: false).getKelas(codeKelas: prf["code_kelas"]);

      if (prf["role"] == "-" || prf.isEmpty) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const RegisterPage(),
          ),
        );
        return;
      }

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const DashboardPage(),
        ),
      );
    }catch(e, r){
      if (kDebugMode) {
        print(e);
        print(r);
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  void onPressedFunction() async {
    setState(() {
      isLoading = true;
    });

    try {


      var data = await FirebaseReference.user.get();
      Iterable<QueryDocumentSnapshot<Object?>> user = data.docs.where((element) => element.get("username").toString().compareTo(_usernameController.text) == 0);

      if (user.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("User tidak ditemukan")));
        setState(() => isLoading = false);
        return;
      }

      if(_passwordController.text.isEmpty){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password tidak boleh kosong")));
        setState(() => isLoading = false);
        return;
      }

      final key = encrypt.Key.fromUtf8('ASDFGHJKLASDFGHJ');
      final iv = encrypt.IV.fromLength(16);
      final encrypter = encrypt.Encrypter(encrypt.AES(key));
      final en = encrypt.Encrypted.fromBase16(user.first["password"]);
      final decrypted = encrypter.decrypt(en, iv: iv);

      if(decrypted.compareTo(_passwordController.text) != 0){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password salah")));
        setState(() => isLoading = false);
        return;
      }

      final profile = await Provider.of<ProfileProvider>(context, listen: false).getProfile(uid: user.first["uid"]);
      await Provider.of<KelasProvider>(context, listen: false).getKelas(codeKelas: user.first["code_kelas"] ?? "");

      if (profile["role"] == "-" || profile.isEmpty) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const RegisterPage(),
          ),
        );
        return;
      }

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const DashboardPage(),
        ),
      );
    } catch (e, r) {
      showDialog(
        context: context,
        builder: (context) {
          return DialogFailed(
            content: "Ups sesuatu salah, silahkan hubungin admin.",
            onPressedFunction: () => Navigator.of(context).pop(),
          );
        },
      );
      if (kDebugMode) {
        print("$e : $r");
      }
    }
    setState(() {
      isLoading = false;
    });
  }
}
