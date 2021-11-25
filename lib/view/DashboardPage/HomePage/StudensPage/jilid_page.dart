import 'package:ajari/component/appbar/silver_appbar_back.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:ajari/view/DashboardPage/HomePage/ReadBottomSheetDialog/read_bottomheet_dialog.dart';
import 'package:ajari/view/DashboardPage/HomePage/ReadPage/listhalaman_page.dart';
import 'package:flutter/material.dart';

class JilidPage extends StatefulWidget {
  final String uid, codeKelas, role;

   const JilidPage({Key? key, required this.uid, required this.codeKelas, required this.role}) : super(key: key);

  @override
  _StudensPageState createState() => _StudensPageState();
}

class _StudensPageState extends State<JilidPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColor.primarybg,
      // appBar: AppBarBack(ctx: context, title: "Jilid"),
      body: SilverAppBarBack(
        pinned: true,
        floating: true,
        barTitle: "Jilid",
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: _page.length,
            itemBuilder: (BuildContext context, int index) {
              return _jilidContainer(
                jilid: _page[index].arab,
                text: _page[index].text,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ListHalamanPage(
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

  final List<Jilid> _page = [
    Jilid("١", "Satu"),
    Jilid("٢", "Dua"),
    Jilid("٣", "Tiga"),
    Jilid("٤", "Empat"),
    Jilid("٥", "Lima"),
    Jilid("٦", "Enam"),
  ];

  Widget _jilidContainer({text, jilid, onTap}) {
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
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0)),
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
                const TextStyle(color: PaletteColor.primary),
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
