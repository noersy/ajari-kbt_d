import 'package:ajari/component/indicator/indicator_load.dart';
import 'package:ajari/providers/profile_provider.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/view/DashboardPage/dashboard_page.dart';
import 'package:ajari/view/LoginPage/component/button_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final User user;

  const RegisterPage({Key? key, required this.user}) : super(key: key);

  @override
  _RegisterPage createState() => _RegisterPage();
}

enum SingingCharacter { santri, pengajar }

class _RegisterPage extends State<RegisterPage> {
  bool isLoading = false;
  SingingCharacter? _character = SingingCharacter.santri;

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
            child: Padding(
              padding: const EdgeInsets.all(SpacingDimens.spacing24),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/ajarilogo.png',
                      width: 150,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: const Text('Santri'),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.santri,
                            groupValue: _character,
                            onChanged: (SingingCharacter? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('Pengajar'),
                          leading: Radio<SingingCharacter>(
                            value: SingingCharacter.pengajar,
                            groupValue: _character,
                            onChanged: (SingingCharacter? value) {
                              setState(() {
                                _character = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  ButtonLogin(
                    onPressedFunction: onPressedFunction,
                    title: "Continue",
                  ),
                ],
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

  void onPressedFunction() async {
    await Provider.of<ProfileProvider>(context, listen: false).createProfile(
      userid: widget.user.uid,
      role: _character == SingingCharacter.santri ? "Santri" : "Pengajar",
    );
    await Provider.of<ProfileProvider>(context, listen: false)
        .getProfile(userUid: FirebaseAuth.instance.currentUser?.uid ?? "");

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const DashboardPage(),
      ),
    );
  }
}
