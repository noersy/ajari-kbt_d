import 'package:ajari/component/AppBar/AppBarBack.dart';
import 'package:ajari/firebase/DataKelasProvider.dart';
import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/view/DashboardPage/KelasPage/component/DialogCreateAbsen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      body: StreamBuilder<QuerySnapshot>(
          stream: Provider.of<DataKelasProvider>(context).getsAbsen(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: Text("There is no expense"));
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: snapshot.data!.docs.map((e) => Container(
                child: Text("test"),
              )).toList(),
            ),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: PaletteColor.green,
        backgroundColor: PaletteColor.primary,
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context, builder: (context) => DialogCreateAbsen());
        },
      ),
    );
  }
}
