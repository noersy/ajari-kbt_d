

import 'package:ajari/theme/SpacingDimens.dart';
import 'package:flutter/material.dart';

Widget dateCard({hari, tgl, color}) {
  return Column(
    children: [
      Text(
        hari,
        style: TextStyle(color: color),
      ),
      Text(tgl, style: TextStyle(color: color)),
      SizedBox(height: SpacingDimens.spacing4),
      Container(
        height: 2,
        width: 20,
        decoration: BoxDecoration(
          color: color,
        ),
      ),
    ],
  );
}