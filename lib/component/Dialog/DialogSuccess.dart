import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/theme/TypographyStyle.dart';
import 'package:flutter/material.dart';

class DialogSuccess extends StatelessWidget {
  final String content;
  final Function onPressedFunction;

  DialogSuccess({required this.content, required this.onPressedFunction});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.black.withOpacity(SpacingDimens.spacing4),
      child: AlertDialog(
        backgroundColor: PaletteColor.primarybg,
        contentPadding: EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(
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
              padding: EdgeInsets.only(
                top: 20,
                bottom: SpacingDimens.spacing4,
              ),
              child: Text(
                'Success!',
                style: TypographyStyle.subtitle1.merge(
                  TextStyle(
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
              padding: EdgeInsets.only(
                left: SpacingDimens.spacing64,
                right: SpacingDimens.spacing64,
              ),
              child: Text(
                content,
                textAlign: TextAlign.center,
                style: TypographyStyle.paragraph.merge(
                  TextStyle(
                    color: PaletteColor.grey60,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(
                SpacingDimens.spacing24,
              ),
              child: FlatButton(
                minWidth: double.infinity,
                color: PaletteColor.primary,
                onPressed: () {
                  onPressedFunction();
                },
                child: Text(
                  'Done',
                  style: TypographyStyle.button2.merge(
                    TextStyle(
                      color: PaletteColor.primarybg,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
