import 'package:ajari/component/AppBar/AppBarBack.dart';
import 'package:ajari/firebase/DataKelasProvider.dart';
import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/view/DashboardPage/StudensPage/JilidPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudensPage extends StatefulWidget {
  final String codeKelas;
  final String uid;

  const StudensPage({required this.codeKelas, required this.uid});

  @override
  _StudensPageState createState() => _StudensPageState();
}

class _StudensPageState extends State<StudensPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColor.primarybg,
      appBar: AppBarBack(ctx: context, title: "Santri"),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: Provider.of<DataKelasProvider>(context)
              .getSantri(codeKelas: widget.codeKelas),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(child: Text("There is no expense"));
            return ListView(
              children: snapshot.data!.docChanges
                  .map(
                    (e) => SantriContainer(
                      name: "${e.doc.get('name')}",
                      imageUrl: e.doc.get('photo'),
                      inTo: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => JilidPage(
                              role: 'santri',
                              uid: e.doc.get('uid'),
                              codeKelas: widget.codeKelas,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ),
    );
  }

  Widget SantriContainer({name, inTo, imageUrl}) {
    return Container(
      margin: const EdgeInsets.only(
        left: SpacingDimens.spacing16,
        right: SpacingDimens.spacing16,
        top: SpacingDimens.spacing8,
        bottom: SpacingDimens.spacing8,
      ),
      decoration: BoxDecoration(
        color: PaletteColor.primarybg,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          height: 36,
          width: 36,
          margin: const EdgeInsets.all(SpacingDimens.spacing8),
          decoration: BoxDecoration(
            color: PaletteColor.grey60.withOpacity(0.2),
            borderRadius: BorderRadius.circular(100),
          ),
          child: CircleAvatar(
            foregroundColor: PaletteColor.primary,
            backgroundImage: NetworkImage(imageUrl),
          ),
        ),
        title: Container(
          decoration: BoxDecoration(
            color: PaletteColor.grey60.withOpacity(0.1),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Container(
            width: 100,
            margin: const EdgeInsets.only(left: SpacingDimens.spacing8),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(SpacingDimens.spacing8),
                  child: Text(name),
                )
              ],
            ),
          ),
        ),
        trailing: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
          ),
          child: TextButton(
            onPressed: inTo,
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0)),
            ),
            child: Icon(
              Icons.arrow_forward,
              color: PaletteColor.grey,
            ),
          ),
        ),
      ),
    );
  }
}
