import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:ajari/view/DashboardPage/HomePage/ReadPage/component/message_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HalamanContainer extends StatelessWidget {
  final BuildContext ctx;
  final Function() inTo;
  final String nomorHalaman, nomorJilid, uid, codeKelas, role, grade;

  const HalamanContainer({
    Key? key,
    required this.nomorJilid,
    required this.nomorHalaman,
    required this.ctx,
    required this.uid,
    required this.codeKelas,
    required this.role,
    required this.grade,
    required this.inTo,
  }) : super(key: key);

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
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.only(left: SpacingDimens.spacing16, right: SpacingDimens.spacing4),
        leading: Stack(
          children: [
            Container(
              height: 30,
              width: 66,
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(left: SpacingDimens.spacing8, top: SpacingDimens.spacing4 - 2),
              decoration: BoxDecoration(color: PaletteColor.grey60.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.only(right: SpacingDimens.spacing12),
                child: Text(
                  grade,
                  style: TypographyStyle.subtitle1.merge(
                    const TextStyle(color: PaletteColor.primary),
                  ),
                ),
              ),
            ),
            Container(
              height: 36,
              width: 36,
              decoration: BoxDecoration(
                color: PaletteColor.primary.withOpacity(0.8),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Text(
                  nomorHalaman,
                  style: TypographyStyle.subtitle1.copyWith(color: PaletteColor.primarybg),
                ),
              ),
            ),
          ],
        ),
        title: Row(
          children: [
            SizedBox(
              width: 140,
              child: Row(
                children: [
                  _container(onPressed: () => _showDialog(false) , iconData: Icons.comment, bgColor: PaletteColor.grey40.withOpacity(0.7), ),
                  _container(onPressed: () => _showDialog(true) , iconData: Icons.play_arrow, bgColor: PaletteColor.grey40.withOpacity(0.7), ),
                ],
              ),
            ),
            _container(onPressed: inTo , iconData: Icons.flip, bgColor: PaletteColor.primary.withOpacity(0.13), ),
          ],
        ),
      ),
    );
  }

  Widget _container({required Function() onPressed, required IconData iconData, required Color bgColor}) {
    return Expanded(
      flex: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: SpacingDimens.spacing4),
        child: TextButton(
          style: TextButton.styleFrom(
            primary: PaletteColor.primary,
            backgroundColor: bgColor,
            padding: const EdgeInsets.symmetric(vertical: SpacingDimens.spacing12),
            shape:  RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)
            ),
          ),
          onPressed: onPressed,
          child:  Icon(
            iconData,
            size: 23,
            color: PaletteColor.grey80,
          ),
        ),
      ),
    );
  }

  void _showDialog(isPlay) {
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
