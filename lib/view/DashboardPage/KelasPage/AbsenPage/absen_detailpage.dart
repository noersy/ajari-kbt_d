import 'package:ajari/component/appbar/appbar_back.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:flutter/material.dart';

class AbsenDetailPage extends StatefulWidget {
  const AbsenDetailPage({Key? key}) : super(key: key);

  @override
  _AbsenDetailPageState createState() => _AbsenDetailPageState();
}

class _AbsenDetailPageState extends State<AbsenDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColor.primarybg,
      appBar: AppBarBack(ctx: context, title: "title"),
    );
  }
}
