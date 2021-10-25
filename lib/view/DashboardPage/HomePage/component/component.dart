
import 'package:ajari/theme/SpacingDimens.dart';
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
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0)),
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
          Container(
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
