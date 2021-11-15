import 'package:ajari/component/AppBar/AppBarBack.dart';
import 'package:ajari/theme/PaletteColor.dart';
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
