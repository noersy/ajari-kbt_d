import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/theme/TypographyStyle.dart';
import 'package:ajari/view/DashboardPage/DashboardPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'AuthLogin.dart';

class ButtonLoginGoogle extends StatelessWidget {
  final VoidCallback onPressedFunction;

  ButtonLoginGoogle({required this.onPressedFunction});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: SpacingDimens.spacing12),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: FlatButton(
          color: PaletteColor.primarybg,
          splashColor: PaletteColor.primary80,
          height: 48,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.0),
            side: BorderSide(
              color: PaletteColor.green,
            ),
          ),
          onPressed: this.onPressedFunction,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/googlelogo.png'),
              Text(
                "Log In with Google",
                style: TypographyStyle.button1.merge(
                  TextStyle(
                    color: PaletteColor.grey60,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
