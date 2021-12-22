import 'package:ajari/component/appbar/silver_mainapp_bar.dart';
import 'package:ajari/model/kelas.dart';
import 'package:ajari/model/profile.dart';
import 'package:ajari/providers/kelas_providers.dart';
import 'package:ajari/providers/notification_providers.dart';
import 'package:ajari/providers/profile_providers.dart';
import 'package:ajari/route/route_transisition.dart';
import 'package:ajari/theme/costume_icons.dart';
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

  Kelas get _kelas => context.read<KelasProvider>().kelas;

  Profile get profile =>
      Provider.of<ProfileProvider>(context, listen: false).profile;

  List<Map<String, dynamic>> get _listSantri =>
      Provider.of<KelasProvider>(context).listSantri;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColor.primarybg2,
      body: SilverMainAppBar(
        pinned: true,
        floating: true,
        scrollController: _scrollController,
        action: Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.wysiwyg),
              color: PaletteColor.primary,
              iconSize: 20,
              onPressed: () => Navigator.of(context).push(
                routeTransition(const NotificationPage()),
              ),
            ),
            Positioned(
              top: 18,
              right: 12,
              child: AnimatedBuilder(
                animation: Provider.of<NotificationProvider>(context),
                builder: (BuildContext context, Widget? child) {
                  final item = Provider.of<NotificationProvider>(context).notification;
                  return item.isNotEmpty ? Container(
                    height: 13,
                    width: 13,
                    alignment: Alignment.center,
                    child: Text('${item.length}', style: TypographyStyle.mini.copyWith(
                      color: PaletteColor.primarybg,
                      fontWeight: FontWeight.bold,
                    )),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: PaletteColor.red,
                    ),
                  ) : const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
        barTitle: [
          const Text("Assalamualaikum,", style: TypographyStyle.subtitle1),
          Text(profile.name, style: TypographyStyle.caption2),
        ],
        banner: [
          if (profile.role == "Pengajar") ...[
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
                            boxShadow: ShadowCostume.shadowStroke1,
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
                                    style: TypographyStyle.title.copyWith(
                                        color: PaletteColor.primarybg),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Text(
                          _kelas.nama,
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
          ] else if (profile.role == "Santri") ...[
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
                alignment: Alignment.bottomCenter,
                children: [
                  Positioned(
                    bottom: -30,
                    right: -20,
                    child: SizedBox(
                      height: 135,
                      child: Image.asset(
                        'assets/images/banner.png',
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    top: 15,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.menu_book_rounded,
                              color: PaletteColor.primarybg,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Last Read",
                              style: TypographyStyle.subtitle2.merge(
                                  const TextStyle(
                                      color: PaletteColor.primarybg)),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              top: SpacingDimens.spacing12),
                          padding: const EdgeInsets.only(
                            left: SpacingDimens.spacing12,
                            right: SpacingDimens.spacing12,
                            top: SpacingDimens.spacing4,
                            bottom: SpacingDimens.spacing8,
                          ),
                          decoration: BoxDecoration(
                              color: PaletteColor.primarybg.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4.0),
                              boxShadow: [
                                BoxShadow(
                                    color:
                                        PaletteColor.primarybg.withOpacity(0.1),
                                    spreadRadius: 5)
                              ]),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Jilid",
                                    style: TypographyStyle.subtitle1.merge(
                                        const TextStyle(
                                            color: PaletteColor.primarybg)),
                                  ),
                                  Text(
                                    " ١",
                                    style: TypographyStyle.title.merge(
                                        const TextStyle(
                                            color: PaletteColor.primarybg)),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Halaman",
                                    style: TypographyStyle.subtitle2.merge(
                                        const TextStyle(
                                            color: PaletteColor.primarybg,
                                            fontWeight: FontWeight.w100)),
                                  ),
                                  Text(
                                    " 1",
                                    style: TypographyStyle.subtitle2.merge(
                                      const TextStyle(
                                          color: PaletteColor.primarybg),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomRight,
              margin: const EdgeInsets.symmetric(
                horizontal: SpacingDimens.spacing16,
                vertical: SpacingDimens.spacing12,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: const Color(0xFFF7EAC0),
                boxShadow: ShadowCostume.shadow1,
              ),
              child: InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(10),
                splashColor: PaletteColor.primary,
                highlightColor: PaletteColor.primary.withOpacity(0.2),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      child: Image.asset(
                        'assets/images/nabi_musa.png',
                      ),
                      height: 130,
                      alignment: Alignment.bottomRight,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(
                        left: SpacingDimens.spacing12,
                        top: SpacingDimens.spacing8,
                      ),
                      height: 160,
                      child: Row(
                        children: const [
                          Icon(
                            CostumeIcons.book,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            "Last Read",
                            style: TypographyStyle.subtitle2,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(
                            left: SpacingDimens.spacing12,
                            top: SpacingDimens.spacing16,
                          ),
                          child: const Text(
                            "Kisah Nabi Musa",
                            style: TypographyStyle.subtitle1,
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          margin: const EdgeInsets.only(
                            left: SpacingDimens.spacing12,
                            bottom: SpacingDimens.spacing16,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Halaman",
                                style: TypographyStyle.subtitle2.copyWith(
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                              const Text(" 1",
                                  style: TypographyStyle.subtitle2),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ]
        ],
        body: profile.role == "Santri"
            ? ViewSantri(
                name: profile.name,
                scrollController: _scrollController,
              )
            : ViewUstaz(
                name: profile.name,
                scrollController: _scrollController,
              ),
      ),
    );
  }
}
