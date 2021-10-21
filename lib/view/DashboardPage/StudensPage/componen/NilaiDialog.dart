import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/theme/TypographyStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NilaiDialog extends StatelessWidget {
  final BuildContext homePageCtx, sheetDialogCtx;

  NilaiDialog({required this.homePageCtx, required this.sheetDialogCtx});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          8.0,
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    String _chosenValue;
    return Container(
      height: MediaQuery.of(context).size.height - 370,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: PaletteColor.primarybg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Nilai',
                      style: TypographyStyle.subtitle1.merge(
                        TextStyle(
                          color: PaletteColor.black,
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                ],
              ),
              Column(
                children: [
                  Container(
                    height: 60,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(SpacingDimens.spacing16),
                    padding: const EdgeInsets.all(SpacingDimens.spacing12),
                    decoration: BoxDecoration(
                      color: PaletteColor.blue.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'A : >80, B+ : >=75, B : >=70, C+ : >=60, C : >=55, D : >=40, E : <40',
                      textAlign: TextAlign.center,
                      style: TypographyStyle.caption2.merge(
                        TextStyle(
                          color: PaletteColor.grey,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: SpacingDimens.spacing24,
                      right: SpacingDimens.spacing24,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Nilai",
                          style: TypographyStyle.button1,
                        ),
                        DropdownButton<String>(
                          focusColor: Colors.white,
                          // value: _chosenValue,
                          //elevation: 5,
                          style: TextStyle(color: Colors.white),
                          iconEnabledColor: Colors.black,
                          items: <String>[
                            'A',
                            'B',
                            'C',
                            'D',
                            'E',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(color: Colors.black),
                              ),
                            );
                          }).toList(),
                          hint: Text(
                            "E",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
