import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/theme/TypographyStyle.dart';
import 'package:flutter/material.dart';

class DialogFailed extends StatelessWidget {
  final String content;
  final onPressedFunction;

  DialogFailed({required this.content, this.onPressedFunction});

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
            Container(
              padding: EdgeInsets.all(
                SpacingDimens.spacing12,
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: PaletteColor.red,
              ),
              child: Icon(
                // IconComponent.close,
                Icons.close,
                size: 28,
                color: PaletteColor.primarybg,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: SpacingDimens.spacing16,
                bottom: SpacingDimens.spacing4,
              ),
              child: Text(
                'Failed!',
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
            onPressedFunction != null
                ? Padding(
                    padding: EdgeInsets.all(
                      SpacingDimens.spacing24,
                    ),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        backgroundColor: PaletteColor.primary,
                        primary: PaletteColor.green,
                      ),
                      onPressed: onPressedFunction,
                      child: SizedBox(
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            'OK',
                            style: TypographyStyle.button2.merge(
                              TextStyle(
                                color: PaletteColor.primarybg,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
