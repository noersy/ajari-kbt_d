import 'package:ajari/component/dialog/dialog_failed.dart';
import 'package:ajari/component/indicator/indicator_load.dart';
import 'package:ajari/config/firebase_reference.dart';
import 'package:ajari/providers/kelas_providers.dart';
import 'package:ajari/providers/profile_providers.dart';
import 'package:ajari/route/route_transisition.dart';
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

import '../../providers/auth_providers.dart';
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
  // double get paddingSafe => MediaQuery.of(context).padding.vertical;

  bool isLoading = false;

  Widget get loadingIndicator => isLoading
      ? Container(
          color: Colors.black26,
          width: double.infinity,
          height: double.infinity,
          child: indicatorLoad(),
        )
      : const SizedBox.shrink();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColor.primarybg,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                top: -330,
                child: Image.asset(
                  'assets/images/logo_login.png',
                  scale: 1.5,
                ),
              ),
              Positioned.fill(
                bottom: 120,
                left: 30,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Sign In", style: TypographyStyle.title,),
                    Text("To continue.", style: TypographyStyle.caption2,),
                  ],
                ),
              ),
              Positioned.fill(
                bottom: -200,
                child: Align(
                  alignment: Alignment.center,
                  child: MainForms(
                    controllerUsername: _usernameController,
                    passwordFilter: _passwordController,
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Column(
                  children: [
                    ButtonLogin(
                      onPressedFunction: onPressedFunction,
                      title: "Sign In",
                    ),
                    const SizedBox(height: SpacingDimens.spacing8),
                    ButtonLoginGoogle(
                      onPressedFunction: loginWIthGoogle,
                      label: "Sign In with Google",
                    ),
                    const SizedBox(height: SpacingDimens.spacing24),
                  ],
                ),
              ),
              const SizedBox(height: SpacingDimens.spacing8),

              Align(
                child: loadingIndicator,
                alignment: FractionalOffset.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loginWIthGoogle() async {
    setState(() {
      isLoading = true;
    });

    try {
      User? user = await Provider.of<AuthProvider>(context, listen: false).signInWithGoogle(context: context);
      if (user == null) throw Exception("Not login");
      final prf = await Provider.of<ProfileProvider>(context, listen: false).getProfile(uid: user.uid);

      if (prf["role"] == "-" || prf.isEmpty) {
        Navigator.of(context).pushReplacement(routeTransition(RegisterPage(user: user)));
        setState(() => isLoading = false);
        return;
      }

      await Provider.of<KelasProvider>(context, listen: false).getKelas(codeKelas: prf["code_kelas"]);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const DashboardPage(),
        ),
      );
    } catch (e, r) {
      if (kDebugMode) {
        print(e);
        print(r);
      }
    }
    setState(() => isLoading = false);
  }




  void onPressedFunction() async {
    setState(() {
      isLoading = true;
    });

    try {
      var data = await FirebaseReference.user.get();
      Iterable<QueryDocumentSnapshot<Object?>> user = data.docs.where(
          (element) =>
              element
                  .get("username")
                  .toString()
                  .compareTo(_usernameController.text) ==
              0);

      if (user.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("User tidak ditemukan")));
        setState(() => isLoading = false);
        return;
      }

      if (_passwordController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Password tidak boleh kosong")));
        setState(() => isLoading = false);
        return;
      }

      final key = encrypt.Key.fromUtf8('ASDFGHJKLASDFGHJ');
      final iv = encrypt.IV.fromLength(16);
      final encrypter = encrypt.Encrypter(encrypt.AES(key));
      final en = encrypt.Encrypted.fromBase16(user.first["password"]);
      final decrypted = encrypter.decrypt(en, iv: iv);

      if (decrypted.compareTo(_passwordController.text) != 0) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password salah")));
        setState(() => isLoading = false);
        return;
      }

      final profile = await Provider.of<ProfileProvider>(context, listen: false).getProfile(uid: user.first["uid"]);
      final kelas = await Provider.of<KelasProvider>(context, listen: false).getKelas(codeKelas: user.first["code_kelas"] ?? "");

      Provider.of<ProfileProvider>(context, listen: false).storeLocalProfile(profile);
      Provider.of<KelasProvider>(context, listen: false).storeLocalKelas(kelas);

      //
      // if (profile["role"] == "-" || profile.isEmpty) {
      //   Navigator.of(context).pushReplacement(
      //     MaterialPageRoute(
      //       builder: (context) => const RegisterPage(user: ),
      //     ),
      //   );
      //   return;
      // }

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
