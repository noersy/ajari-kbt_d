
import 'package:ajari/component/appbar/silver_appbar_back.dart';
import 'package:ajari/model/kelas.dart';
import 'package:ajari/model/profile.dart';
import 'package:ajari/providers/profile_providers.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:ajari/view/NotificationPage/notification_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../component/appbar/silver_mainapp_bar.dart';
import '../../../providers/kelas_providers.dart';
import '../../../route/route_transisition.dart';
import 'component/view_santri.dart';
import 'component/view_ustaz.dart';

class HomePage extends StatelessWidget {
   HomePage({Key? key}) : super(key: key);

  final  _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context, listen: false).profile;
    Kelas _kelas = context.read<KelasProvider>().kelas;

    return Scaffold(
      backgroundColor: PaletteColor.primarybg2,
      body: SilverMainAppBar(
        pinned: true,
        floating: true,
        scrollController: _scrollController,
        action: IconButton(
          icon: const Icon(
            Icons.wysiwyg,
          ),
          color: PaletteColor.primary,
          iconSize: 20,
          onPressed: () {
            Navigator.of(context).push(
              routeTransition(
                const NotificationPage(),
              ),
            );
          },
        ),
        barTitle: [
          const Text(
            "Assalamualaikum,",
            style: TypographyStyle.subtitle1,
          ),
          Text(
            profile.name,
            style: TypographyStyle.caption2,
          ),
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
                colors: [
                  Color(0xFF62D282),
                  Color(0xFF008165),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: PaletteColor.grey40.withOpacity(0.1),
                  spreadRadius: 3.5,
                ),
                BoxShadow(
                  color: PaletteColor.grey40.withOpacity(0.2),
                  spreadRadius: 3,
                ),
                BoxShadow(
                  color: PaletteColor.grey40.withOpacity(0.2),
                  spreadRadius: 2.5,
                ),
                BoxShadow(
                  color: PaletteColor.grey60.withOpacity(0.05),
                  spreadRadius: 2,
                ),
                BoxShadow(
                  color: PaletteColor.grey60.withOpacity(0.1),
                  spreadRadius: 1.5,
                ),
                BoxShadow(
                  color: PaletteColor.grey60.withOpacity(0.2),
                  spreadRadius: 1,
                ),
                BoxShadow(
                  color: PaletteColor.grey60.withOpacity(0.05),
                  spreadRadius: 0.5,
                ),
              ]
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: -30,
                  right: -20,
                  child: Image.asset(
                    'assets/images/banner.png',
                    height: 140,
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 20,
                  child: Column(
                    children: [
                      Container(
                        height: 75,
                        width: 75,
                        margin: const EdgeInsets.only(bottom: SpacingDimens.spacing8),
                        decoration: BoxDecoration(
                            color: PaletteColor.primarybg.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(50.0),
                            boxShadow:  [
                              BoxShadow(
                                  spreadRadius: 5,
                                  color: PaletteColor.primarybg.withOpacity(0.1)
                              )
                            ]
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
                                  var _listSantri = Provider.of<KelasProvider>(context).listSantri;

                                  return Text(
                                    "${_listSantri.length}",
                                    style: TypographyStyle.title.copyWith(color: PaletteColor.primarybg),
                                  );
                                }
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
        body: Column(
          children: [
            Column(
              children: [
                const SizedBox(height: SpacingDimens.spacing16),
                profile.role == "Santri"
                    ? ViewSantri(name: profile.name)
                    : ViewUstaz(name: profile.name),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

