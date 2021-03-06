
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:flutter/material.dart';

Widget cardStry({
  required image,
  required title,
  required color,
  required onTap,
}) {
  return Card(
    color: color,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0),
      ),
      onPressed: onTap,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: SpacingDimens.spacing8),
            child: Align(
              child: Image.asset(
                image,
                height: 100,
              ),
              alignment: Alignment.bottomLeft,
            ),
          ),
          SizedBox(
            width: 120,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: title,
            ),
          ),
        ],
      ),
    ),
  );
}
