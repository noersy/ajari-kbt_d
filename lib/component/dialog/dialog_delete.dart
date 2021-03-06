import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:flutter/material.dart';

class DialogDelete extends StatelessWidget {
  final String content;
  final Function onPressedFunction;

   const DialogDelete({Key? key,
    required this.content,
    required this.onPressedFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: null,
      builder: (context, snapshot) {
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
              Container(
                padding: const EdgeInsets.all(
                  SpacingDimens.spacing12,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: PaletteColor.red.withOpacity(0.8),
                ),
                child: const Icon(
                  // IconComponent.close,
                  Icons.delete_outline,
                  size: 28,
                  color: PaletteColor.primarybg,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: SpacingDimens.spacing16,
                  bottom: SpacingDimens.spacing4,
                ),
                child: Text(
                  'Delete!',
                  style: TypographyStyle.subtitle1.merge(
                    const TextStyle(
                      color: PaletteColor.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
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
                            side: BorderSide(color: PaletteColor.primary.withOpacity(0.5)),
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
    );
  }
}
