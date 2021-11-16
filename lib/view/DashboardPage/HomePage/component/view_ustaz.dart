import 'package:ajari/config/globals.dart' as globals;
import 'package:ajari/model/kelas.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:ajari/theme/costume_icons.dart';
import 'package:ajari/view/DashboardPage/HomePage/StoryPage/story_page.dart';
import 'package:ajari/view/DashboardPage/StudensPage/studens_page.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ViewUstaz extends StatefulWidget {
  final PageController pageViewController;

  const ViewUstaz({Key? key,
    required this.pageViewController,
  }) : super(key: key);

  @override
  State<ViewUstaz> createState() => _ViewUstazState();
}

class _ViewUstazState extends State<ViewUstaz> {
  Kelas _kelas = Kelas(
    pengajarId: "pengajarId",
    nama: "-",
    jumlahSantri: 0,
    kelasId: "kelasId",
    pengajar: "pengajar",
  );

  @override
  void initState() {
    if (globals.isKelasNotNull) _kelas = globals.Get.kls();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            SizedBox(
              height: 150,
              child: PageView(
                physics: const BouncingScrollPhysics(),
                controller: widget.pageViewController,
                children: [
                  Container(
                    height: 130,
                    alignment: Alignment.bottomRight,
                    margin: const EdgeInsets.only(
                        top: SpacingDimens.spacing16,
                        left: SpacingDimens.spacing16,
                        right: SpacingDimens.spacing16,
                        bottom: SpacingDimens.spacing12),
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF6EEA91), Color(0xFF008165)],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          child: Image.asset(
                            'assets/images/Quran.png',
                          ),
                          height: 100,
                          alignment: Alignment.bottomRight,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(
                            left: SpacingDimens.spacing12,
                            top: SpacingDimens.spacing16,
                          ),
                          height: 130,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.people,
                                color: PaletteColor.primarybg,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Studens",
                                style: TypographyStyle.subtitle2.merge(
                                    const TextStyle(color: PaletteColor.primarybg)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(
                            left: 50,
                            top: SpacingDimens.spacing8,
                          ),
                          child: Text(
                            "${_kelas.jumlahSantri}",
                            style: TypographyStyle.title.merge(
                                const TextStyle(color: PaletteColor.primarybg)),
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
                              style: TypographyStyle.subtitle2.merge(const TextStyle(
                                  color: PaletteColor.primarybg,
                                  fontWeight: FontWeight.w100)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 130,
                    alignment: Alignment.bottomRight,
                    margin: const EdgeInsets.only(
                        top: SpacingDimens.spacing16,
                        left: SpacingDimens.spacing16,
                        right: SpacingDimens.spacing16,
                        bottom: SpacingDimens.spacing12),
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            Color(0xFF008165),
                            Color(0xFF22997B),
                            Color(0xFF3DAD8A),
                            Color(0xFF6EEA91),
                          ],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          child: Image.asset(
                            'assets/images/Quran.png',
                          ),
                          height: 100,
                          alignment: Alignment.bottomRight,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(
                            left: SpacingDimens.spacing12,
                            top: SpacingDimens.spacing16,
                          ),
                          height: 130,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.people,
                                color: PaletteColor.primarybg,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Studens",
                                style: TypographyStyle.subtitle2.merge(
                                    const TextStyle(color: PaletteColor.primarybg)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(
                            left: 50,
                            top: SpacingDimens.spacing8,
                          ),
                          child: Text(
                            "${_kelas.jumlahSantri}",
                            style: TypographyStyle.title.merge(
                                const TextStyle(color: PaletteColor.primarybg)),
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
                              style: TypographyStyle.subtitle2.merge(const TextStyle(
                                  color: PaletteColor.primarybg,
                                  fontWeight: FontWeight.w100)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SmoothPageIndicator(
              controller: widget.pageViewController,
              count: 2,
              axisDirection: Axis.horizontal,
              onDotClicked: (i) {
                widget.pageViewController.animateToPage(
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
          ],
        ),
        const SizedBox(height: SpacingDimens.spacing8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: SpacingDimens.spacing4,
                  left: SpacingDimens.spacing16,
                  right: SpacingDimens.spacing8,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 1,
                    primary: PaletteColor.primarybg,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    side: BorderSide(
                      color: PaletteColor.grey80.withOpacity(0.08),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const StudensPage(),
                      ),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 65,
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          margin: const EdgeInsets.all(SpacingDimens.spacing8),
                          decoration: BoxDecoration(
                              color: PaletteColor.primary.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(100)),
                          child: const Icon(
                            CostumeIcons.holyQuran,
                            color: PaletteColor.primary,
                          ),
                        ),
                        Container(
                          width: 70,
                          padding: const EdgeInsets.only(
                              bottom: SpacingDimens.spacing12,
                              left: SpacingDimens.spacing12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "قيم",
                                style: TypographyStyle.subtitle1.merge(
                                    const TextStyle(
                                        color: PaletteColor.primary,
                                        fontSize: 20)),
                              ),
                              Text("Nilai",
                                  style: TypographyStyle.subtitle2
                                      .merge(const TextStyle(fontSize: 12))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: SpacingDimens.spacing4,
                  right: SpacingDimens.spacing16,
                  left: SpacingDimens.spacing8,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 1,
                    primary: PaletteColor.primarybg,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    side: BorderSide(
                      color: PaletteColor.grey80.withOpacity(0.08),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const StoryPage()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 65,
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          margin: const EdgeInsets.all(SpacingDimens.spacing8),
                          decoration: BoxDecoration(
                              color: PaletteColor.primary.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(100)),
                          child: const Icon(
                            Icons.collections_bookmark_sharp,
                            color: PaletteColor.primary,
                          ),
                        ),
                        Container(
                          width: 60,
                          padding: const EdgeInsets.only(
                              bottom: SpacingDimens.spacing12,
                              left: SpacingDimens.spacing12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "قصة",
                                style: TypographyStyle.subtitle1.merge(
                                    const TextStyle(
                                        color: PaletteColor.primary,
                                        fontSize: 20)),
                              ),
                              Text(
                                "Cerita",
                                style: TypographyStyle.subtitle2.merge(
                                  const TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
