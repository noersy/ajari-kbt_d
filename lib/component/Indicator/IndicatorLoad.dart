import 'package:ajari/theme/PaletteColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget indicatorLoad() {
  return SpinKitFadingCircle(
    size: 45,
    itemBuilder: (BuildContext context, int index) {
      return const DecoratedBox(
        decoration: BoxDecoration(
          color: PaletteColor.primary,
          shape: BoxShape.circle,
        ),
      );
    },
  );
}
