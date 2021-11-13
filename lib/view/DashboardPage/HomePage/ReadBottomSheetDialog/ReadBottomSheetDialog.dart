import 'package:ajari/config/globals.dart' as globals;
import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/theme/TypographyStyle.dart';
import 'package:ajari/view/DashboardPage/HomePage/ReadPage/ReadPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReadBottomSheetDialog extends StatelessWidget {
  final BuildContext ctx;

  ReadBottomSheetDialog({
    required this.ctx,
  });

  final List<Jilid> _page = [
    Jilid("١", "Satu"),
    Jilid("٢", "Dua"),
    Jilid("٣", "Tiga"),
    Jilid("٤", "Empat"),
    Jilid("٥", "Lima"),
    Jilid("٦", "Enam"),
  ];

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Container(
          height: 280.0,
          padding: EdgeInsets.symmetric(
            horizontal: SpacingDimens.spacing24,
            vertical: SpacingDimens.spacing16,
          ),
          color: PaletteColor.primarybg,
          child: Column(
            children: [
              Container(
                height: 5,
                width: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: PaletteColor.grey60,
                ),
              ),
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        top: SpacingDimens.spacing28,
                        left: SpacingDimens.spacing12,
                        right: SpacingDimens.spacing12,
                      ),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Pilih Jilid",
                        style: TypographyStyle.button1,
                      ),
                    ),
                    Divider(),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 6,
                      itemBuilder: (BuildContext context, int index) {
                        return _jilidContainer(
                          jilid: _page[index].arab,
                          text: _page[index].text,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ReadPage(
                                  nomor: "${index + 1}",
                                  uid: globals.Get.usr().uid,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }



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

  Widget actionBottomSheet({required IconData icon, required String title}) {
    return Container(
      color: PaletteColor.primarybg,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: SpacingDimens.spacing16,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 25,
              color: PaletteColor.primary,
            ),
            SizedBox(
              width: SpacingDimens.spacing24,
            ),
            Text(
              title,
              style: TypographyStyle.subtitle2,
            ),
          ],
        ),
      ),
    );
  }
}

class Jilid {
  final String text;
  final String arab;

  Jilid(this.arab, this.text);
}
