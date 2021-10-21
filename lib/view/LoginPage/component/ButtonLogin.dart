import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/theme/TypographyStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonLogin extends StatelessWidget {
  final onPressedFunction;
  final String title;

  const ButtonLogin({required this.onPressedFunction, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: SpacingDimens.spacing64),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: FlatButton(
          color: PaletteColor.primary,
          splashColor: PaletteColor.primary80,
          height: 48,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3.0),
            side: BorderSide(
              color: PaletteColor.green,
            ),
          ),
          onPressed: this.onPressedFunction,
          child: Text(
            title,
            style: TypographyStyle.button1.merge(
              TextStyle(
                color: PaletteColor.primarybg,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
