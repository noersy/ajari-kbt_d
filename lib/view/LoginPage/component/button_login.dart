import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
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
    return SizedBox(
      width: MediaQuery.of(context).size.width - SpacingDimens.spacing24*2,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          primary: PaletteColor.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
          ),
        ),
        onPressed: onPressedFunction,
        child: SizedBox(
          height: 48,
          child: Center(
            child: Text(
              title,
              style: TypographyStyle.button1.copyWith(
                  color: PaletteColor.primarybg,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
