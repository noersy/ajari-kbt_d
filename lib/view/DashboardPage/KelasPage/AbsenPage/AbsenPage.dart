import 'package:ajari/component/AppBar/AppBarBack.dart';
import 'package:ajari/theme/PaletteColor.dart';
import 'package:flutter/material.dart';

class AbsenPage extends StatelessWidget {
  const AbsenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColor.primarybg,
      appBar: AppBarBack(
        title: "Absensi",
        ctx: context,
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        splashColor: PaletteColor.green,
        backgroundColor: PaletteColor.primary,
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
