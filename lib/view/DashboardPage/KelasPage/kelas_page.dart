import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:flutter/material.dart';

import 'component/banner_kelas.dart';
import 'component/jadwal_kelas.dart';

class ClassPage extends StatelessWidget {
  const ClassPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: PaletteColor.primarybg2,
      // appBar: AppBar(
      //   backgroundColor: PaletteColor.primarybg,
      //   elevation: 0,
      //   title: const Text(
      //     "Class",
      //     style: TypographyStyle.subtitle1,
      //   ),
      // ),
      body: SafeArea(
        child: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          body: Column(
            children: const [
              JadwalKelas(),
            ],
          ),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: PaletteColor.primarybg,
                iconTheme: const IconThemeData(color: PaletteColor.primary),
                title:  const Text(
                      "Class",
                      style: TypographyStyle.subtitle1,
                    ),
                bottom: const PreferredSize(
                  preferredSize: Size(0, 160),
                  child: BannerKelas(),
                ),
                pinned: false,
                floating: false,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                forceElevated: innerBoxIsScrolled,
              ),
            ];
          },
        ),
      ),

      //
      // _kelas.kelasId == "-"
      //     ? _profile.role != "Pengajar"
      //     ? const JoinKelas()
      //     : CreateKelas(ctx: context)
      //     : Column(
      //   children: const [
      //     BannerKelas(),
      //     JadwalKelas(),
      //   ],
      // ),
    );
  }
}
