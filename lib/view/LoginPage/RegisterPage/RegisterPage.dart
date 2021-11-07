import 'package:ajari/component/Indicator/IndicatorLoad.dart';
import 'package:ajari/config/globals.dart' as globals;
import 'package:ajari/firebase/DataProfileProvider.dart';
import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/view/DashboardPage/DashboardPage.dart';
import 'package:ajari/view/LoginPage/component/ButtonLogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final User user;

  const RegisterPage({required this.user});

  @override
  _RegisterPage createState() => _RegisterPage();
}

enum SingingCharacter { Santri, Pengajar }

class _RegisterPage extends State<RegisterPage> {
  bool isLoading = false;
  SingingCharacter? _character = SingingCharacter.Santri;

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
              padding: EdgeInsets.all(SpacingDimens.spacing24),
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
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: const Text('Santri'),
                            leading: Radio<SingingCharacter>(
                              value: SingingCharacter.Santri,
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
                              value: SingingCharacter.Pengajar,
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
                  ),
                  ButtonLogin(
                    onPressedFunction: onPressedFunction,
                    title: "Continue",
                  ),
                ],
              ),
            ),
          ),
          new Align(
            child: loadingIndicator,
            alignment: FractionalOffset.center,
          ),
        ],
      ),
    );
  }

  void onPressedFunction() async {
    await DataProfileProvider.createProfile(
      userid: widget.user.uid,
      role: _character == SingingCharacter.Santri ? "Santri" : "Pengajar",
    );
    await DataProfileProvider.getProfile(userUid: globals.Get.usr().uid);

    print(widget.user.displayName);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => DashboardPage(),
      ),
    );
  }
}
