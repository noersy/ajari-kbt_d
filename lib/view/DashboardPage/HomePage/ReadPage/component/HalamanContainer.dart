import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/theme/TypographyStyle.dart';
import 'package:ajari/view/DashboardPage/HomePage/ReadPage/component/MessageDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HalamanContainer extends StatelessWidget {
  final BuildContext ctx;
  final inTo;
  final String nomorHalaman, nomorJilid, uid, codeKelas, role, grade;

  HalamanContainer({
    required this.nomorJilid,
    required this.nomorHalaman,
    required this.ctx,
    required this.uid,
    required this.codeKelas,
    required this.role,
    required this.grade,
    this.inTo,
  });

  @override
  Widget build(BuildContext context) {
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
          child: Center(
            child: Text(
              this.nomorHalaman,
              style: TypographyStyle.subtitle1.merge(
                TextStyle(color: PaletteColor.primary),
              ),
            ),
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
                  padding: const EdgeInsets.all(8.0),
                  child: Text(grade),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(right: SpacingDimens.spacing12),
                  child: Text("|"),
                ),
                Container(
                  height: 26,
                  width: 26,
                  margin: const EdgeInsets.all(SpacingDimens.spacing4),
                  decoration: BoxDecoration(
                    color: PaletteColor.grey60.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      primary: PaletteColor.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: (){
                      _showDialog(false);
                    },
                    child: Icon(
                      Icons.comment,
                      size: 16,
                      color: PaletteColor.grey80,
                    ),
                  ),
                ),
                Container(
                  height: 26,
                  width: 26,
                  margin: const EdgeInsets.all(SpacingDimens.spacing4),
                  decoration: BoxDecoration(
                    color: PaletteColor.grey60.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: TextButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                          EdgeInsets.all(0)),
                    ),
                    onPressed: (){
                      _showDialog(true);
                    },
                    child: Icon(
                      Icons.play_arrow,
                      size: 18,
                      color: PaletteColor.grey80,
                    ),
                  ),
                ),
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


  void _showDialog(isPlay){
    showDialog(
      context: ctx,
      builder: (BuildContext context) {
        return MessageDialog(
          uid: uid,
          role: role,
          codeKelas: codeKelas,
          homePageCtx: context,
          sheetDialogCtx: context,
          nomorJilid: nomorJilid,
          nomorHalaman: nomorHalaman,
          isPlayed: isPlay,
        );
      },
    );
  }
}
