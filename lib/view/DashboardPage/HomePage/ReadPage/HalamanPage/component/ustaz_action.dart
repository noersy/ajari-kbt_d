import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:ajari/view/DashboardPage/HomePage/ReadPage/component/message_dialog.dart';
import 'package:ajari/view/DashboardPage/HomePage/StudensPage/componen/nilai_dialog.dart';
import 'package:flutter/material.dart';

import 'component.dart';

class UstazAction extends StatefulWidget {
  final String uid, grade, codeKelas, nomorJilid, nomorHalaman, role;

  const UstazAction({
    Key? key,
    required this.uid,
    required this.grade,
    required this.codeKelas,
    required this.nomorJilid,
    required this.nomorHalaman,
    required this.role,
  }) : super(key: key);

  @override
  State<UstazAction> createState() => _UstazActionState();
}

class _UstazActionState extends State<UstazAction> {
  bool _downloadAudio = false;

  @override
  void initState() {
    _fetchRecord();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: SpacingDimens.spacing16,
        right: SpacingDimens.spacing8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 100,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(
                  top: SpacingDimens.spacing8,
                  bottom: SpacingDimens.spacing16,
                ),
                decoration: BoxDecoration(
                    color: PaletteColor.primarybg,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset:
                            const Offset(0, 1), // changes position of shadow
                      ),
                    ]),
                child: TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return NilaiDialog(
                          uid: widget.uid,
                          grade: widget.grade,
                          codeKelas: widget.codeKelas,
                          nomorJilid: widget.nomorJilid,
                          nomorHalaman: widget.nomorHalaman,
                        );
                      },
                    );
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: const EdgeInsets.all(SpacingDimens.spacing16),
                  ),
                  child: const Text(
                    "Nilai",
                    style: TypographyStyle.button1,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: SpacingDimens.spacing8,
                  bottom: SpacingDimens.spacing16,
                ),
                decoration: BoxDecoration(
                  color: PaletteColor.primarybg,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(SpacingDimens.spacing16),
                child: InkWell(
                  onTap: () {
                    _showdialog(false, context);
                  },
                  child: const Icon(Icons.insert_comment_outlined),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: SpacingDimens.spacing8,
                  bottom: SpacingDimens.spacing16,
                  left: SpacingDimens.spacing12,
                ),
                decoration: BoxDecoration(
                    color: PaletteColor.primarybg,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset:
                            const Offset(0, 1), // changes position of shadow
                      ),
                    ]),
                padding: const EdgeInsets.all(SpacingDimens.spacing16),
                child: InkWell(
                  onTap: () {
                    if (_downloadAudio) {
                      _showdialog(true, context);
                    }
                  },
                  child: const Icon(Icons.play_arrow),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  void _fetchRecord() async {
    try {
      await checkPermission();

      final String filepath = await getFilePath() + 'record.m4a';

      String? path = await downloadFile(filepath, widget.nomorHalaman, widget.nomorJilid);

      if (path != null) {
        setState(() {
          _downloadAudio = true;
        });
      }
    } catch (e) {
      // print("$e");
    }
  }

  void _showdialog(isPlayed, ctx) {
    showDialog(
      context: ctx,
      builder: (BuildContext context) {
        return MessageDialog(
          uid: widget.uid,
          role: widget.role,
          codeKelas: widget.codeKelas,
          homePageCtx: context,
          sheetDialogCtx: context,
          nomorJilid: widget.nomorJilid,
          nomorHalaman: widget.nomorHalaman,
          isPlayed: isPlayed,
        );
      },
    );
  }
}
