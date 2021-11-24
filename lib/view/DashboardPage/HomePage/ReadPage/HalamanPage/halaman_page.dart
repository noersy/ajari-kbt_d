import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:ajari/view/DashboardPage/HomePage/ReadPage/HalamanPage/component/audio_top.dart';
import 'package:ajari/view/DashboardPage/HomePage/ReadPage/HalamanPage/component/santri_action.dart';
import 'package:ajari/view/DashboardPage/HomePage/ReadPage/HalamanPage/component/ustaz_action.dart';
import 'package:flutter/material.dart';

import 'component/component.dart';

class HalamanPage extends StatelessWidget {
  final String pathBacaan;
  final String pathAudio;
  final String nomorHalaman, nomorJilid, uid, codeKelas, role, grade;

  const HalamanPage({
    Key? key,
    required this.pathBacaan,
    required this.pathAudio,
    required this.nomorHalaman,
    required this.nomorJilid,
    required this.uid,
    required this.role,
    required this.grade,
    required this.codeKelas,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColor.primarybg,
      // appBar: AppBarBack(
      //   ctx: context,
      //   title: "Halaman ${nomorHalaman}",
      // ),
      body: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        body: _content(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: PaletteColor.primarybg,
              shadowColor: Colors.transparent,
              elevation: 0,
              iconTheme: const IconThemeData(color: PaletteColor.primary),
              title:  Text("Halaman $nomorHalaman", style: TypographyStyle.subtitle1),
              bottom: const PreferredSize(
                preferredSize: Size(0.0, 50),
                child: AudioTop(),
              ),
              pinned: true,
              floating: true,
              forceElevated: innerBoxIsScrolled,
            ),
          ];
        },
      ),

      // SilverAppBarBack(
      //   pinned: false,
      //   floating: true,
      //   barTitle: "Halaman $nomorHalaman",
      //   body: _content(),
      // ),
    );
  }

  _content() {
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
          codeKelas != "-"
              ? role == "Santri"
                  ? _actionSantriContainer()
                  : _actionUstazContainer()
              : notJoinAction(),
          // _actionPage(),
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
        uid: uid,
        grade: grade,
        codeKelas: codeKelas,
        nomorJilid: nomorJilid,
        nomorHalaman: nomorHalaman,
        role: role,
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
        uid: uid,
        grade: grade,
        codeKelas: codeKelas,
        nomorJilid: nomorJilid,
        nomorHalaman: nomorHalaman,
        role: role,
      ),
    );
  }
}
