import 'package:ajari/model/kelas.dart';
import 'package:ajari/model/profile.dart';
import 'package:ajari/providers/kelas_providers.dart';
import 'package:ajari/providers/profile_providers.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:ajari/view/DashboardPage/KelasPage/component/banner_kelas.dart';
import 'package:ajari/view/DashboardPage/KelasPage/component/join_kelas.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'component/banner_kelas.dart';
import 'component/create_kelas.dart';
import 'component/jadwal_kelas.dart';

class ClassPage extends StatefulWidget {
  const ClassPage({Key? key}) : super(key: key);

  @override
  State<ClassPage> createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColor.primarybg2,

      body: AnimatedBuilder(
        animation: Provider.of<KelasProvider>(context),
        builder: (BuildContext context, Widget? child) {
          Kelas _kelas = Provider.of<KelasProvider>(context).kelas;
          Profile _profile = Provider.of<ProfileProvider>(context).profile;
          return SafeArea(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              switchInCurve: Curves.easeIn,
              switchOutCurve: Curves.easeInOut,
              child: _kelas.kelasId == "-"
                  ? _profile.role != "Pengajar"
                      ? const JoinKelas()
                      : const CreateKelas()
                  : NestedScrollView(
                      physics: const BouncingScrollPhysics(),
                      body: Column(
                        children: const [
                          JadwalKelas(),
                        ],
                      ),
                      headerSliverBuilder: (_, bool innerBoxIsScrolled) {
                        return <Widget>[
                          SliverAppBar(
                            backgroundColor: PaletteColor.primarybg,
                            iconTheme: const IconThemeData(color: PaletteColor.primary),
                            title: const Text(
                              "Kelas",
                              style: TypographyStyle.subtitle1,
                            ),
                            pinned: false,
                            floating: true,
                            forceElevated: innerBoxIsScrolled,
                          ),
                          SliverAppBar(
                            backgroundColor: PaletteColor.primarybg,
                            bottom: const PreferredSize(
                              preferredSize: Size(0, 115),
                              child: BannerKelas(),
                            ),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10),
                              ),
                            ),
                            pinned: false,
                            floating: true,
                            forceElevated: innerBoxIsScrolled,
                          ),
                        ];
                      },
                    ),
            ),
          );
        },
      ),
    );
  }
}
