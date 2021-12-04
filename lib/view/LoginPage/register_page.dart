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
    _profile = Provider
        .of<ProfileProvider>(context, listen: false)
        .profile;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator = isLoading
        ? Container(
        color: Colors.black26, width: double.infinity, height: double.infinity,
        child: indicatorLoad()
    )
        : Container();
    return Scaffold(
      backgroundColor: PaletteColor.primarybg,
      body: Stack(
        children: [
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
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
                      Container(
                        margin: const EdgeInsets.only(
                            top: SpacingDimens.spacing44),
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
                                label: Text("Username",
                                  style: TypographyStyle.paragraph.copyWith(
                                    color: PaletteColor.grey60,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0)
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: const BorderSide(
                                    color: PaletteColor.primary,
                                  ),
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
                                label: Text("Password Baru",
                                  style: TypographyStyle.paragraph.copyWith(
                                    color: PaletteColor.grey60,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.only(
                                  left: SpacingDimens.spacing16,
                                  right: SpacingDimens.spacing16,
                                  top: SpacingDimens.spacing28,
                                  bottom: SpacingDimens.spacing8,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0)
                                ),
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
                                label: Text("Konfirmasi Password",
                                  style: TypographyStyle.paragraph.copyWith(
                                    color: PaletteColor.grey60,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0)
                                ),
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
                      ButtonLogin(
                        onPressedFunction: onPressedFunction,
                        title: "Sign Up",
                      ),
                      // ButtonLoginGoogle(
                      //   onPressedFunction: onPressedFunction,
                      //   label: "Sign Up with Google",
                      // ),
                      const SizedBox(height: SpacingDimens.spacing12),
                      const Divider(),
                      const SizedBox(height: SpacingDimens.spacing8),
                      const Text("Already have an account? Sign in now!",
                        style: TypographyStyle.caption1,),
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

  bool _validateStructure(String value){
    String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  void onPressedFunction() async {
    setState(() {
      isLoading = true;
    });

    if(_usernameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Username tidak boleh kosong")));
      setState(() => isLoading = false);
      return;
    }

    if(_passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password tidak boleh kosong")));
      setState(() => isLoading = false);
      return;
    }

    if(_passwordController.text.compareTo(_passwordKonController.text) != 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Password tidak match.")));
      setState(() => isLoading = false);
      return;
    }

    bool _isSudahDipakai = false;
    await FirebaseReference.user.get().then((value){
      if(value.docs.where((element) => element.get("username").toString().compareTo(_usernameController.text) == 0).isNotEmpty){
        _isSudahDipakai = true;
      }
    });

    if(_isSudahDipakai){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Username sudah dipakai")));
      setState(() =>  isLoading = false);
      return;
    }


    final key = encrypt.Key.fromUtf8('ASDFGHJKLASDFGHJ');
    final iv = encrypt.IV.fromLength(16);
    final encrypter = encrypt.Encrypter(encrypt.AES(key));
    final encrypted = encrypter.encrypt(_passwordController.text, iv: iv);

    try {
      final profile = await Provider.of<ProfileProvider>(context, listen: false).getProfile(uid: FirebaseAuth.instance.currentUser?.uid ?? "");
      await Provider.of<KelasProvider>(context, listen: false).getKelas(codeKelas: _profile?.codeKelas ?? "");

      if (profile.role == "-") {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) =>
                SelectionPage(
                  user: FirebaseAuth.instance.currentUser!,
                  username: _usernameController.text,
                  password: encrypted.base16,
                ),
          ),
        );
        return;
      }


    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }
}