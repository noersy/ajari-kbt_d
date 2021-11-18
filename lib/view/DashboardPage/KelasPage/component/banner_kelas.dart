import 'package:ajari/model/kelas.dart';
import 'package:ajari/model/profile.dart';
import 'package:ajari/providers/kelas_providers.dart';
import 'package:ajari/providers/profile_providers.dart';
import 'package:ajari/route/route_transisition.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:ajari/view/DashboardPage/KelasPage/AbsenPage/absen_page.dart';
import 'package:ajari/view/DashboardPage/KelasPage/StudentListPage/student_listpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BannerKelas extends StatelessWidget {
  const BannerKelas({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final Profile profile = context
        .watch<ProfileProvider>()
        .profile;
    final Kelas kelas = context
        .watch<KelasProvider>()
        .kelas;


    return Padding(
      padding: const EdgeInsets.all(SpacingDimens.spacing12),
      child: Stack(
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF6EEA91), Color(0xFF008165)],
              ),
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
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(
                left: SpacingDimens.spacing16,
                top: SpacingDimens.spacing12,
                bottom: SpacingDimens.spacing8,
              ),
              child: Text(
                kelas.nama,
                style: TypographyStyle.title.merge(
                  const TextStyle(
                    color: PaletteColor.primarybg2,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 150,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: SpacingDimens.spacing16,
                  bottom: 4,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.person,
                      color: PaletteColor.primarybg2,
                    ),
                    Text(
                      kelas.pengajar,
                      style: TypographyStyle.button1.merge(
                        const TextStyle(
                          fontSize: 18,
                          color: PaletteColor.primarybg2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 150,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 19,
                  top: 36,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.people,
                      size: 18,
                      color: PaletteColor.primarybg2,
                    ),
                    Text(
                      " ${kelas.jumlahSantri}",
                      style: TypographyStyle.button1.merge(
                        const TextStyle(
                          fontSize: 13,
                          color: PaletteColor.primarybg2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 120,
            margin: const EdgeInsets.only(
              right: SpacingDimens.spacing12,
            ),
            alignment: Alignment.topRight,
            child: Image.asset(
              'assets/images/lentrn.png',
            ),
          ),
          SizedBox(
            height: 150,
            child: Align(
              alignment: Alignment.bottomRight,
              child: SizedBox(
                width: 60,
                height: 30,
                child: GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Copy code kelas."),
                        duration: Duration(milliseconds: 300),
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: SpacingDimens.spacing8 + 1,
                          right: SpacingDimens.spacing4,
                        ),
                        child: Text(
                          kelas.kelasId,
                          style: TypographyStyle.button1.copyWith(
                            fontSize: 12,
                            color: PaletteColor.primarybg2.withOpacity(0.8),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                            bottom: SpacingDimens.spacing4 + 3,
                            right: SpacingDimens.spacing8),
                        child: Icon(
                          Icons.content_copy,
                          size: 16,
                          color: PaletteColor.primarybg,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          profile.role != "Santri"
              ? Container(
            height: 155,
            alignment: Alignment.bottomLeft,
            child: Row(
              children: [
                const SizedBox(width: SpacingDimens.spacing4),
                TextButton(
                  style: TextButton.styleFrom(
                      primary: PaletteColor.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  onPressed: () =>
                      Navigator.of(context).push(
                        routeTransition(
                          StudenListPage(
                            codeKelas: profile.codeKelas,
                          ),
                        ),
                      ),
                  child: Text(
                    "Santri List",
                    style: TypographyStyle.button2.copyWith(
                      color: PaletteColor.primarybg2,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(
                    SpacingDimens.spacing4,
                  ),
                  child: SizedBox(
                    width: 1,
                    height: SpacingDimens.spacing16,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: PaletteColor.primarybg2,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: PaletteColor.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context)
                        .push(routeTransition(const AbsenPage()));
                  },
                  child: Text(
                    "Absen",
                    style: TypographyStyle.button2.copyWith(
                      color: PaletteColor.primarybg2,
                    ),
                  ),
                )
              ],
            ),
          )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
