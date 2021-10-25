

import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/theme/TypographyStyle.dart';
import 'package:flutter/material.dart';

Widget dateCard({hari, tgl, color, onTap}) {
  return TextButton(
    onPressed: onTap,
    style: TextButton.styleFrom(
      padding: const EdgeInsets.all(0),
      primary: PaletteColor.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
    ),
    child: SizedBox.expand(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            hari,
            style: TextStyle(color: color, fontWeight: FontWeight.w400, fontSize: 12),
          ),
          SizedBox(height: 2),
          Text(tgl, style: TextStyle(color: color, fontWeight: FontWeight.normal, fontSize: 18)),
          SizedBox(height: 1),
          Container(
            height: 1.4,
            width: 24,
            decoration: BoxDecoration(
              color: color,
            ),
          ),
        ],
      ),
    ),
  );
}