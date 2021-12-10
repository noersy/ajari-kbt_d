import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:flutter/material.dart';


class ButtonLoginGoogle extends StatelessWidget {
  final VoidCallback onPressedFunction;
  final String label;

  const ButtonLoginGoogle({Key? key, required this.onPressedFunction, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - SpacingDimens.spacing24*2,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: PaletteColor.primarybg,
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
            side: BorderSide(
              width: 1.5,
              color: PaletteColor.green.withOpacity(0.3),
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
                label,
                style: TypographyStyle.button1.copyWith(
                    color: PaletteColor.grey60,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
