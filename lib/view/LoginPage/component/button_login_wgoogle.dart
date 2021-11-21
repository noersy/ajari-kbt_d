import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:flutter/material.dart';


class ButtonLoginGoogle extends StatelessWidget {
  final VoidCallback onPressedFunction;

  const ButtonLoginGoogle({Key? key, required this.onPressedFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: SpacingDimens.spacing12),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: PaletteColor.primarybg,
            elevation: 1,
            padding: const EdgeInsets.all(0),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/googlelogo.png'),
                Text(
                  "Log In with Google",
                  style: TypographyStyle.button1.copyWith(
                      color: PaletteColor.grey60,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
