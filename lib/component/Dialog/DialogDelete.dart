import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/theme/TypographyStyle.dart';
import 'package:flutter/material.dart';

class DialogDelete extends StatelessWidget {
  final String content;
  final Function onPressedFunction;

  const DialogDelete({
    required this.content,
    required this.onPressedFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                color: PaletteColor.red.withOpacity(0.8),
              ),
              child: Icon(
                // IconComponent.close,
                Icons.delete_outline,
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
                'Delete!',
                style: TypographyStyle.subtitle1.merge(
                  TextStyle(
                    color: PaletteColor.black,
                  ),
                ),
              ),
            ),
          ],
        ),
        content: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(SpacingDimens.spacing24),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: PaletteColor.primarybg,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                content,
                style: TypographyStyle.paragraph.merge(
                  TextStyle(
                    color: PaletteColor.grey60,
                  ),
                ),
              ),
              SizedBox(
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
                          side: BorderSide(color: PaletteColor.primary.withOpacity(0.5)),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'No',
                        style: TypographyStyle.button2.merge(
                          TextStyle(
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
                        primary: PaletteColor.red,
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
                          TextStyle(
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
      ),
    );
  }
}
