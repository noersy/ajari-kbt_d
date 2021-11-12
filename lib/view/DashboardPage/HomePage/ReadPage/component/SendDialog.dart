


import 'dart:io';

import 'package:ajari/theme/PaletteColor.dart';

import 'package:flutter/material.dart';

class SendDialog extends StatelessWidget {
  final String path, nomorHalaman;
  const SendDialog({Key? key, required this.path, required this.nomorHalaman}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: PaletteColor.primarybg2
      ),
      child: Text("t"),
    );
  }



}
