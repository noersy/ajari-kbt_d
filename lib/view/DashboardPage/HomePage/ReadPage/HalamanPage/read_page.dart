import 'package:ajari/config/path_iqro.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:ajari/view/DashboardPage/HomePage/ReadPage/HalamanPage/component/action_bottom.dart';
import 'package:ajari/view/DashboardPage/HomePage/ReadPage/HalamanPage/component/audio_top.dart';
import 'package:ajari/view/DashboardPage/HomePage/ReadPage/HalamanPage/component/santri_action.dart';
import 'package:ajari/view/DashboardPage/HomePage/ReadPage/HalamanPage/component/ustaz_action.dart';
import 'package:flutter/material.dart';

import 'component/component.dart';

class ReadPage extends StatefulWidget {
  final String nomorHalaman, nomorJilid, uid, codeKelas, role, grade;


  const ReadPage({
    Key? key,
    required this.nomorHalaman,
    required this.nomorJilid,
    required this.uid,
    required this.role,
    required this.grade,
    required this.codeKelas,
  }) : super(key: key);

  @override
  State<ReadPage> createState() => _ReadPageState();
}

class _ReadPageState extends State<ReadPage> {
  int _nomorJilid = 0;
  int _nomorHalaman = 0;

  @override
  void initState() {
    _nomorJilid = int.parse(widget.nomorJilid);
    _nomorHalaman = int.parse(widget.nomorHalaman) ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var pathBacaan = PathIqro.mainImagePath +
        "/jilid$_nomorJilid" +
        "/halaman$_nomorHalaman" +
        ".png";

    return Scaffold(
      backgroundColor: PaletteColor.primarybg,
      body: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        body: _content(pathBacaan),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: PaletteColor.primarybg,
              shadowColor: Colors.transparent,
              elevation: 0,
              iconTheme: const IconThemeData(color: PaletteColor.primary),
              title:  Text("Halaman $_nomorHalaman", style: TypographyStyle.subtitle1),
              bottom:  PreferredSize(
                preferredSize: const Size(0.0, 50),
                child: AudioTop(
                  nomorHalaman: "$_nomorHalaman",
                  nomorJilid: "$_nomorJilid",
                ),
              ),
              pinned: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
            ),
          ];
        },
      ),

    );
  }

  _content(pathBacaan) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: SpacingDimens.spacing12),
          Container(
            padding: const EdgeInsets.only(
              left: SpacingDimens.spacing16,
              right: SpacingDimens.spacing8,
            ),
            margin: const EdgeInsets.only(
              left: SpacingDimens.spacing16,
              right: SpacingDimens.spacing16,
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
            child: Container(
              margin: const EdgeInsets.all(SpacingDimens.spacing4),
              padding: const EdgeInsets.all(SpacingDimens.spacing4),
              alignment: Alignment.center,
              child: Image.asset('assets/images/iqro/bismilah.png', height: 60),
            ),
          ),
          const SizedBox(height: SpacingDimens.spacing8),
          Container(
            padding: const EdgeInsets.only(
              top: SpacingDimens.spacing16,
              left: SpacingDimens.spacing16,
              right: SpacingDimens.spacing8,
            ),
            margin: const EdgeInsets.only(
              left: SpacingDimens.spacing16,
              right: SpacingDimens.spacing16,
            ),
            child: Container(
              margin: const EdgeInsets.all(SpacingDimens.spacing4),
              alignment: Alignment.center,
              child: Image.asset(
                pathBacaan,
              ),
            ),
          ),
          widget.codeKelas != "-"
              ? widget.role == "Santri"
                  ? _actionSantriContainer()
                  : _actionUstazContainer()
              : notJoinAction(),
          ActionBottom(
            curretHalaman: _nomorHalaman,
            prevAction: () {
              setState(() {
                _nomorHalaman -= 1;
              });
            },
            nextAction: () {
              setState(() {
                _nomorHalaman += 1;
              });
            },
          ),
        ],
      ),
    );
  }

  _actionSantriContainer() {
    return Padding(
      padding: const EdgeInsets.only(
        left: SpacingDimens.spacing16,
        right: SpacingDimens.spacing16,
      ),
      child: SantriAction(
        uid: widget.uid,
        grade: widget.grade,
        codeKelas: widget.codeKelas,
        nomorJilid: widget.nomorJilid,
        nomorHalaman: widget.nomorHalaman,
        role: widget.role,
      ),
    );
  }

  _actionUstazContainer() {
    return Padding(
      padding: const EdgeInsets.only(
        left: SpacingDimens.spacing16,
        right: SpacingDimens.spacing16,
      ),
      child: UstazAction(
        uid: widget.uid,
        grade: widget.grade,
        codeKelas: widget.codeKelas,
        nomorJilid: widget.nomorJilid,
        nomorHalaman: widget.nomorHalaman,
        role: widget.role,
      ),
    );
  }
}
