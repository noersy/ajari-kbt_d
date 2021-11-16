import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/theme/TypographyStyle.dart';
import 'package:flutter/material.dart';

class DialogSuccess extends StatelessWidget {
  final String content;
  final Function onPressedFunction;

  const DialogSuccess({Key? key, required this.content, required this.onPressedFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: PaletteColor.primarybg,
      contentPadding: const EdgeInsets.all(0.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            SpacingDimens.spacing4,
          ),
        ),
      ),
      elevation: 5,
      title: Column(
        children: [
          Image.asset(
            'assets/images/check_green.png',
            width: SpacingDimens.spacing36,
            height: SpacingDimens.spacing36,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              bottom: SpacingDimens.spacing4,
            ),
            child: Text(
              'Success!',
              style: TypographyStyle.subtitle1.merge(
                const TextStyle(
                  color: PaletteColor.black,
                ),
              ),
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: SpacingDimens.spacing64,
              right: SpacingDimens.spacing64,
            ),
            child: Text(
              content,
              textAlign: TextAlign.center,
              style: TypographyStyle.paragraph.merge(
                const TextStyle(
                  color: PaletteColor.grey60,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(
              SpacingDimens.spacing24,
            ),
            child: TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(0),
                primary: PaletteColor.primary,
              ),
              onPressed: () {
                onPressedFunction();
              },
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  'Done',
                  style: TypographyStyle.button2.merge(
                    const TextStyle(
                      color: PaletteColor.primarybg,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
