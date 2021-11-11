import 'package:ajari/component/AppBar/AppBarBack.dart';
import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/theme/TypographyStyle.dart';
import 'package:ajari/view/DashboardPage/HomePage/ReadBottomSheetDialog/ReadBottomSheetDialog.dart';
import 'package:ajari/view/DashboardPage/HomePage/ReadPage/ReadPage.dart';
import 'package:flutter/material.dart';

class JilidPage extends StatefulWidget {
  final String uid, codeKelas, role;

  const JilidPage({required this.uid, required this.codeKelas, required this.role});

  @override
  _StudensPageState createState() => _StudensPageState();
}

class _StudensPageState extends State<JilidPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColor.primarybg,
      appBar: AppBarBack(ctx: context, title: "Jilid"),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _page.length,
            itemBuilder: (BuildContext context, int index) {
              return JilidContainer(
                jilid: _page[index].arab,
                text: _page[index].text,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ReadPage(
                        nomor: "${index + 1}",
                        uid: widget.uid,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  List<jilid> _page = [
    jilid("١", "Satu"),
    jilid("٢", "Dua"),
    jilid("٣", "Tiga"),
    jilid("٤", "Empat"),
    jilid("٥", "Lima"),
    jilid("٦", "Enam"),
  ];

  Widget JilidContainer({text, jilid, onTap}) {
    return Container(
      margin: const EdgeInsets.all(SpacingDimens.spacing4),
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
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0)),
        ),
        onPressed: onTap,
        child: ListTile(
          leading: Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.all(SpacingDimens.spacing8),
            decoration: BoxDecoration(
              color: PaletteColor.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
                child: Text(
              jilid,
              style: TypographyStyle.title.merge(
                TextStyle(color: PaletteColor.primary),
              ),
            )),
          ),
          title: Text(
            text,
            style: TypographyStyle.paragraph,
          ),
        ),
      ),
    );
  }
}
