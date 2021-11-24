import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:ajari/view/DashboardPage/HomePage/ReadPage/component/message_dialog.dart';
import 'package:flutter/material.dart';

class HalamanContainer extends StatefulWidget {
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
  State<HalamanContainer> createState() => _HalamanContainerState();
}

class _HalamanContainerState extends State<HalamanContainer> {
  Color _color = PaletteColor.grey80;
  bool isRecordedExist = false;
  final int _pesan = 0;

  @override
  void initState() {
    switch (widget.grade) {
      case "A":
        _color = Colors.green;
        break;
      case "B":
        _color = Colors.lightGreenAccent;
        break;
      case "C":
        _color = Colors.lime;
        break;
      case "D":
        _color = Colors.orangeAccent;
        break;
      case "E":
        _color = Colors.red;
        break;
      default:
    }

    // _chekRecored();
    super.initState();
  }

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
        contentPadding: const EdgeInsets.only(
            left: SpacingDimens.spacing16, right: SpacingDimens.spacing4),
        leading: Stack(
          children: [
            Container(
              height: 30,
              width: 66,
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(
                  left: SpacingDimens.spacing8,
                  top: SpacingDimens.spacing4 - 2),
              decoration: BoxDecoration(
                  color: PaletteColor.grey60.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.only(right: SpacingDimens.spacing12),
                child: Text(
                  widget.grade,
                  style: TypographyStyle.subtitle1.copyWith(color: _color),
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
                  widget.nomorHalaman,
                  style: TypographyStyle.subtitle1
                      .copyWith(color: PaletteColor.primarybg),
                ),
              ),
            ),
          ],
        ),
        title: Row(
          children: [
            SizedBox(
              width: 150,
              child: Row(
                children: [
                  _container(
                    onPressed: () => _showDialog(false),
                    iconData: Icons.comment,
                    bgColor: _pesan > 0 ? PaletteColor.primary :  PaletteColor.grey40.withOpacity(0.7),
                    iconColor: _pesan > 0 ?  PaletteColor.primarybg :  PaletteColor.grey80,
                  ),
                  _container(
                    onPressed: () => _showDialog(true),
                    iconData: Icons.play_arrow,
                    bgColor: isRecordedExist ? PaletteColor.primary : PaletteColor.grey40.withOpacity(0.7),
                    iconColor: isRecordedExist ? PaletteColor.primarybg : PaletteColor.grey80,
                  ),
                ],
              ),
            ),
            Expanded(
              child: _container(
                onPressed: widget.inTo,
                iconData: Icons.flip,
                bgColor: PaletteColor.primarybg,
                iconColor: PaletteColor.grey80,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // _chekRecored() async {
  //   try {
  //     await FirebaseStorage.instance
  //         .ref('uploads/audio_${widget.nomorHalaman}.m4a')
  //         .getDownloadURL().then((value) {
  //       isRecordedExist = value.isNotEmpty;
  //     },
  //     );
  //   }catch (e){
  //     // print(e);
  //   }
  // }

  Widget _container({
    required Function() onPressed,
    required IconData iconData,
    required Color bgColor,
    required Color iconColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: SizedBox(
        width: 42,
        height: 42,
        child: TextButton(
          style: TextButton.styleFrom(
            primary: !isRecordedExist ? PaletteColor.primary : PaletteColor.primarybg,
            backgroundColor: bgColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          ),
          onPressed: onPressed,
          child: Icon(
            iconData,
            size: 23,
            color: iconColor,
          ),
        ),
      ),
    );
  }

  void _showDialog(isPlay) {
    showDialog(
      context: widget.ctx,
      builder: (BuildContext context) {
        return MessageDialog(
          uid: widget.uid,
          role: widget.role,
          codeKelas: widget.codeKelas,
          homePageCtx: context,
          sheetDialogCtx: context,
          nomorJilid: widget.nomorJilid,
          nomorHalaman: widget.nomorHalaman,
          isPlayed: isPlay,
        );
      },
    );
  }
}
