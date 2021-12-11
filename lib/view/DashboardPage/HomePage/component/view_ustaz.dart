import 'package:ajari/model/kelas.dart';
import 'package:ajari/providers/kelas_providers.dart';
import 'package:ajari/route/route_transisition.dart';
import 'package:ajari/theme/costume_icons.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:ajari/view/DashboardPage/HomePage/StoryPage/story_page.dart';
import 'package:ajari/view/DashboardPage/HomePage/StudensPage/studens_page.dart';
import 'package:ajari/view/DashboardPage/HomePage/component/home_button.dart';
import 'package:ajari/view/NotificationPage/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ViewUstaz extends StatelessWidget {
  final String name;

  ViewUstaz({
    Key? key,
    required this.name,
  }) : super(key: key);


  final _pageViewController = PageController();

  @override
  Widget build(BuildContext context) {
    Kelas _kelas = context.read<KelasProvider>().kelas;

    return Column(
      children: [
        SizedBox(
          height: 220,
          child: PageView(
            physics: const BouncingScrollPhysics(),
            controller: _pageViewController,
            children: [
              Stack(
                children: [
                  Positioned(
                    top: 46,
                    left: SpacingDimens.spacing28,
                    child: Stack(
                      children: [
                        Text(
                          "Assalamualaikum,",
                          style: TypographyStyle.subtitle1.copyWith(
                              color: PaletteColor.primarybg,
                          ),
                        ),
                        Positioned(
                          top: 18,
                          child: Text(
                            name,
                            style: TypographyStyle.subtitle2.copyWith(color: PaletteColor.primarybg),
                          ),
                        ),
                        Positioned(
                          top: -10.0,
                          right: SpacingDimens.spacing28,
                          child: IconButton(
                            icon: const Icon(
                              Icons.wysiwyg,
                              color: PaletteColor.primarybg,
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
                        ),
                        SizedBox(
                          height: 40,
                          width: MediaQuery.of(context).size.width,
                        )
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: - 25,
                    right: 10,
                    child: SizedBox(
                      height: 135,
                      child: Image.asset(
                        'assets/images/banner.png',
                      ),
                    ),
                  ),
                  Positioned(
                    top: 100,
                    left: 35,
                    child: Container(
                      height: 75,
                      width: 75,
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
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    margin: const EdgeInsets.only(
                      left: SpacingDimens.spacing12,
                      bottom: SpacingDimens.spacing16,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: SpacingDimens.spacing8),
                      child: Text(
                        " ${_kelas.nama}",
                        style: TypographyStyle.subtitle2.copyWith(
                                color: PaletteColor.primarybg,
                                fontWeight: FontWeight.w100,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container()
            ],
          ),
        ),
        Expanded(
          child: Container(
            decoration:  BoxDecoration(
              color: PaletteColor.primarybg2,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  offset: const Offset(0, 0),
                  color: PaletteColor.grey80.withOpacity(0.5)
                ),
                BoxShadow(
                  blurRadius: 3,
                  offset: const Offset(0, 0),
                  color: PaletteColor.grey60.withOpacity(0.5)
                ),
                BoxShadow(
                  blurRadius: 4,
                  offset: const Offset(0, 0),
                  color: PaletteColor.grey40.withOpacity(0.5)
                ),
              ]
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SmoothPageIndicator(
                    controller: _pageViewController,
                    count: 2,
                    axisDirection: Axis.horizontal,
                    onDotClicked: (i) {
                      _pageViewController.animateToPage(
                        i,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    effect: const ExpandingDotsEffect(
                      expansionFactor: 3,
                      spacing: 8,
                      radius: 16,
                      dotWidth: 10,
                      dotHeight: 10,
                      dotColor: PaletteColor.grey40,
                      activeDotColor: PaletteColor.primary,
                      paintStyle: PaintingStyle.fill,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Expanded(
                        child: UstazHomePageButton(
                          icon: CostumeIcons.holyQuran,
                          titleArab: "قيم",
                          title: "Nilai",
                          target: StudentsPage(),
                        ),
                      ),
                      SizedBox(width: SpacingDimens.spacing4),
                      Expanded(
                        child: UstazHomePageButton(
                          icon: Icons.collections_bookmark_sharp,
                          iconSize: 28.0,
                          titleArab: "قصة",
                          title: "Cerita",
                          target: StoryPage(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}





