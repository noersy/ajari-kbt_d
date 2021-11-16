import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/theme/TypographyStyle.dart';
import 'package:flutter/material.dart';

class ButtonLogin extends StatelessWidget {
  final Function() onPressedFunction;
  final String title;

  const ButtonLogin({
    Key? key,
    required this.onPressedFunction,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: SpacingDimens.spacing64),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(0),
            backgroundColor: PaletteColor.primary,
            primary: PaletteColor.primary80,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3.0),
              side: const BorderSide(
                color: PaletteColor.green,
              ),
            ),
          ),
          onPressed: onPressedFunction,
          child: SizedBox(
            height: 48,
            child: Center(
              child: Text(
                title,
                style: TypographyStyle.button1.merge(
                  const TextStyle(
                    color: PaletteColor.primarybg,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
