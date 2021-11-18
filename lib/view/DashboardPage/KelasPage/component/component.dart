

import 'package:ajari/theme/palette_color.dart';
import 'package:flutter/material.dart';

Widget dateCard({hari, tgl, color, onTap}) {
  return Padding(
    padding: const EdgeInsets.only(left: 2, right: 2),
    child: ElevatedButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0),
        primary: PaletteColor.primary,
        backgroundColor: PaletteColor.primarybg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0)
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
            const SizedBox(height: 2),
            Text(tgl, style: TextStyle(color: color, fontWeight: FontWeight.normal, fontSize: 18)),
            const SizedBox(height: 1),
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
    ),
  );
}