import 'package:ajari/component/appbar/silver_mainapp_bar.dart';
import 'package:ajari/model/kelas.dart';
import 'package:ajari/model/profile.dart';
import 'package:ajari/providers/kelas_providers.dart';
import 'package:ajari/providers/profile_providers.dart';
import 'package:ajari/route/route_transisition.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/shadow_box.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:ajari/view/NotificationPage/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'component/view_santri.dart';
import 'component/view_ustaz.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();

  Profile get profile =>
      Provider.of<ProfileProvider>(context, listen: false).profile;

  List<Map<String, dynamic>> get _listSantri =>
      Provider.of<KelasProvider>(context).listSantri;

  Kelas get _kelas => context.read<KelasProvider>().kelas;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColor.primarybg2,
      body: SilverMainAppBar(
        pinned: true,
        floating: true,
        scrollController: _scrollController,
        action: IconButton(
          icon: const Icon(Icons.wysiwyg),
          color: PaletteColor.primary,
          iconSize: 20,
          onPressed: () => Navigator.of(context).push(
            routeTransition(const NotificationPage()),
          ),
        ),
        barTitle: [
          const Text("Assalamualaikum,", style: TypographyStyle.subtitle1),
          Text(profile.name, style: TypographyStyle.caption2),
        ],
        banner: [
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: SpacingDimens.spacing16,
              vertical: SpacingDimens.spacing12,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF62D282), Color(0xFF008165)],
              ),
              boxShadow: ShadowCostume.shadow1,
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: -30,
                  right: -20,
                  child: Image.asset('assets/images/banner.png', height: 140),
                ),
                Positioned(
                  top: 30,
                  left: 20,
                  child: Column(
                    children: [
                      Container(
                        height: 75,
                        width: 75,
                        margin: const EdgeInsets.only(
                          bottom: SpacingDimens.spacing8,
                        ),
                        decoration: BoxDecoration(
                          color: PaletteColor.primarybg.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(50.0),
                          boxShadow: ShadowCostume.shadowSoft1,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.people,
                              color: PaletteColor.primarybg,
                              size: 33,
                            ),
                            const SizedBox(width: SpacingDimens.spacing8),
                            AnimatedBuilder(
                              animation: Provider.of<KelasProvider>(context),
                              builder: (context, snapshot) {
                                return Text(
                                  "${_listSantri.length}",
                                  style: TypographyStyle.title.copyWith(color: PaletteColor.primarybg),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Text(
                        " ${_kelas.nama}",
                        style: TypographyStyle.subtitle2.copyWith(
                          color: PaletteColor.primarybg,
                          fontWeight: FontWeight.w100,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container()
        ],
        body: profile.role == "Santri"
            ? ViewSantri(name: profile.name)
            : ViewUstaz(
                name: profile.name,
                scrollController: _scrollController,
              ),
      ),
    );
  }
}
