import 'package:ajari/model/kelas.dart';
import 'package:ajari/model/profile.dart';
import 'package:ajari/providers/kelas_providers.dart';
import 'package:ajari/providers/profile_providers.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/typography_style.dart';
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
  Kelas? _kelas;
  Profile? _profile;

  void freshWitget(kelas) {
    setState(() {
      _kelas = kelas;
    });
  }

  @override
  void initState() {
    _kelas = context.read<KelasProvider>().kelas;
    _profile = context.read<ProfileProvider>().profile;
    super.initState();
  }

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
        child: _kelas!.kelasId == "-"
            ? _profile!.role != "Pengajar"
                ? JoinKelas(freshState: freshWitget)
                : CreateKelas(freshState: freshWitget)
            : NestedScrollView(
                physics: const BouncingScrollPhysics(),
                body: Column(
                  children: const [
                    JadwalKelas(),
                  ],
                ),
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                      backgroundColor: PaletteColor.primarybg,
                      iconTheme:
                          const IconThemeData(color: PaletteColor.primary),
                      title: const Text(
                        "Kelas",
                        style: TypographyStyle.subtitle1,
                      ),
                      bottom: const PreferredSize(
                        preferredSize: Size(0, 178),
                        child: BannerKelas(),
                      ),
                      pinned: false,
                      floating: false,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      forceElevated: innerBoxIsScrolled,
                    ),
                  ];
                },
              ),
      ),

      // //
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
