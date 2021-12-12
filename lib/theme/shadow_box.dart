

import 'package:ajari/theme/palette_color.dart';
import 'package:flutter/cupertino.dart';

class ShadowCostume{
  static final List<BoxShadow> shadowSoft1 = [
    BoxShadow(
      spreadRadius: 5,
      color: PaletteColor.primarybg.withOpacity(0.1),
    ),
  ];

  static final List<BoxShadow> shadow1 = [
    BoxShadow(
      color: PaletteColor.grey40.withOpacity(0.1),
      spreadRadius: 3.5,
    ),
    BoxShadow(
      color: PaletteColor.grey40.withOpacity(0.2),
      spreadRadius: 3,
    ),
    BoxShadow(
      color: PaletteColor.grey40.withOpacity(0.2),
      spreadRadius: 2.5,
    ),
    BoxShadow(
      color: PaletteColor.grey60.withOpacity(0.05),
      spreadRadius: 2,
    ),
    BoxShadow(
      color: PaletteColor.grey60.withOpacity(0.1),
      spreadRadius: 1.5,
    ),
    BoxShadow(
      color: PaletteColor.grey60.withOpacity(0.2),
      spreadRadius: 1,
    ),
    BoxShadow(
      color: PaletteColor.grey60.withOpacity(0.05),
      spreadRadius: 0.5,
    ),
  ];
}