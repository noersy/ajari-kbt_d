import 'package:ajari/component/indicator/indicator_load.dart';
import 'package:ajari/config/firebase_reference.dart';
import 'package:ajari/model/profile.dart';
import 'package:ajari/providers/kelas_providers.dart';
import 'package:ajari/providers/profile_providers.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:ajari/view/DashboardPage/dashboard_page.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'component/auth_login.dart';
import 'component/button_login.dart';
import 'selection_role.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordKonController = TextEditingController();
  bool _isHidePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

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
            child: indicatorLoad())
        : Container();
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
                top: -300,
                child: Image.asset(
                  'assets/images/logo_login.png',
                  scale: 1.5,
                ),
              ),
              Positioned(
                bottom: 100,
                child: Container(
                  padding: const EdgeInsets.all(SpacingDimens.spacing28),
                  alignment: Alignment.center,
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _usernameController,
                        cursorColor: PaletteColor.primary,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                            left: SpacingDimens.spacing16,
                            right: SpacingDimens.spacing16,
                            top: SpacingDimens.spacing28,
                            bottom: SpacingDimens.spacing8,
                          ),
                          label: Text(
                            "Username",
                            style: TypographyStyle.paragraph.copyWith(
                              color: PaletteColor.grey60,
                            ),
                          ),
                          hintText: "Enter Username",
                          hintStyle: TypographyStyle.paragraph.copyWith(
                            color: PaletteColor.grey60,
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(color: PaletteColor.primary),
                          ),
                        ),
                      ),
                      const SizedBox(height: SpacingDimens.spacing12),
                      TextFormField(
                        obscureText: _isHidePassword,
                        controller: _passwordController,
                        cursorColor: PaletteColor.primary,
                        keyboardType: TextInputType.visiblePassword,
                        style: TypographyStyle.button1,
                        decoration: InputDecoration(
                          label: Text(
                            "Password Baru",
                            style: TypographyStyle.paragraph
                                .copyWith(color: PaletteColor.grey60),
                          ),
                          hintText: "Enter Password Baru",
                          hintStyle: TypographyStyle.paragraph.copyWith(
                            color: PaletteColor.grey60,
                          ),
                          contentPadding: const EdgeInsets.only(
                            left: SpacingDimens.spacing16,
                            right: SpacingDimens.spacing16,
                            top: SpacingDimens.spacing28,
                            bottom: SpacingDimens.spacing8,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              color: PaletteColor.primary,
                            ),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: _togglePasswordVisibility,
                            child: Icon(
                              _isHidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: _isHidePassword
                                  ? PaletteColor.grey60
                                  : PaletteColor.primary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: SpacingDimens.spacing12),
                      TextFormField(
                        obscureText: _isHidePassword,
                        controller: _passwordKonController,
                        cursorColor: PaletteColor.primary,
                        keyboardType: TextInputType.visiblePassword,
                        style: TypographyStyle.button1,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                            left: SpacingDimens.spacing16,
                            right: SpacingDimens.spacing16,
                            top: SpacingDimens.spacing28,
                            bottom: SpacingDimens.spacing8,
                          ),
                          label: Text(
                            "Konfirmasi Password",
                            style: TypographyStyle.paragraph.copyWith(
                              color: PaletteColor.grey60,
                            ),
                          ),
                          hintText: "Re-Enter Password",
                          hintStyle: TypographyStyle.paragraph.copyWith(
                            color: PaletteColor.grey60,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: const BorderSide(
                              color: PaletteColor.primary,
                            ),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: _togglePasswordVisibility,
                            child: Icon(
                              _isHidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: _isHidePassword
                                  ? PaletteColor.grey60
                                  : PaletteColor.primary,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(vertical: SpacingDimens.spacing12),
                  child: Column(
                    children: [
                      ButtonLogin(
                        onPressedFunction: onPressedFunction,
                        title: "Register",
                      ),
                      const SizedBox(height: SpacingDimens.spacing8),
                      const Divider(),
                      Row(
                        children: [
                          const Text("Already have an account? ", style: TypographyStyle.caption1),
                          GestureDetector(
                            onTap: (){},
                              child: Text("Sign in ", style: TypographyStyle.caption1.copyWith(
                                color: PaletteColor.primary,
                              )),
                          ),
                          const Text("now!", style: TypographyStyle.caption1)
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              // ButtonLoginGoogle(
              //   onPressedFunction: onPressedFunction,
              //   label: "Sign Up with Google",
              // ),
              // const SizedBox(height: SpacingDimens.spacing12),
              // const SizedBox(height: SpacingDimens.spacing8),
              // const SizedBox(height: SpacingDimens.spacing8),

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

    if (_usernameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Username tidak boleh kosong")));
      setState(() => isLoading = false);
      return;
    }

    if (_passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Password tidak boleh kosong")));
      setState(() => isLoading = false);
      return;
    }

    if (_passwordController.text.compareTo(_passwordKonController.text) != 0) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Password tidak match.")));
      setState(() => isLoading = false);
      return;
    }

    bool _isSudahDipakai = false;
    await FirebaseReference.user.get().then((value) {
      if (value.docs
          .where((element) =>
              element
                  .get("username")
                  .toString()
                  .compareTo(_usernameController.text) ==
              0)
          .isNotEmpty) {
        _isSudahDipakai = true;
      }
    });

    if (_isSudahDipakai) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Username sudah dipakai")));
      setState(() => isLoading = false);
      return;
    }

    final key = encrypt.Key.fromUtf8('ASDFGHJKLASDFGHJ');
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypter.encrypt(_passwordController.text, iv: iv);

    try {
      await Provider.of<ProfileProvider>(context, listen: false)
          .chekRole(user: FirebaseAuth.instance.currentUser!);
      final profile = await Provider.of<ProfileProvider>(context, listen: false)
          .getProfile(uid: FirebaseAuth.instance.currentUser?.uid ?? "");
      await Provider.of<KelasProvider>(context, listen: false)
          .getKelas(codeKelas: _profile?.codeKelas ?? "");

      if (profile["role"] == "-") {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => SelectionPage(
              user: FirebaseAuth.instance.currentUser!,
              username: _usernameController.text,
              password: encrypted.base16,
            ),
          ),
        );
        return;
      }
    } catch (e, r) {
      if (kDebugMode) {
        print("$e : $r");
      }
    }
    setState(() {
      isLoading = false;
    });
  }
}
