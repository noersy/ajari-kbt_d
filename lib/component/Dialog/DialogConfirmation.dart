import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/theme/TypographyStyle.dart';
import 'package:flutter/material.dart';

class DialogConfirmation extends StatelessWidget {
  final String title;
  final String content;
  final Function onPressedFunction;

  const DialogConfirmation({Key? key,
    required this.title,
    required this.content,
    required this.onPressedFunction,
  }) : super(key: key);

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
      content: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(SpacingDimens.spacing24),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: PaletteColor.primarybg,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TypographyStyle.subtitle1.merge(
                const TextStyle(
                  color: PaletteColor.black,
                ),
              ),
            ),
            const SizedBox(
              height: 22,
            ),
            Text(
              content,
              style: TypographyStyle.paragraph.merge(
                const TextStyle(
                  color: PaletteColor.grey60,
                ),
              ),
            ),
            const SizedBox(
              height: 38,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3.2,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: PaletteColor.primarybg,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        side: const BorderSide(color: PaletteColor.primary),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'No',
                      style: TypographyStyle.button2.merge(
                        const TextStyle(
                          color: PaletteColor.primary,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3.2,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: PaletteColor.primary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    onPressed: () {
                      onPressedFunction();
                    },
                    child: Text(
                      'Yes',
                      style: TypographyStyle.button2.merge(
                        const TextStyle(
                          color: PaletteColor.primarybg,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
