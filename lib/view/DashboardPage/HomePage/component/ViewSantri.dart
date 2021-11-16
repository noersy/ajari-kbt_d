import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/theme/TypographyStyle.dart';
import 'package:ajari/theme/costume_icons.dart';
import 'package:ajari/view/DashboardPage/HomePage/ReadBottomSheetDialog/ReadBottomSheetDialog.dart';
import 'package:ajari/view/DashboardPage/HomePage/StoryPage/ChildStoryPage/NabiIbrahimPage.dart';
import 'package:ajari/view/DashboardPage/HomePage/StoryPage/ChildStoryPage/NabiMusaPage.dart';
import 'package:ajari/view/DashboardPage/HomePage/StoryPage/ChildStoryPage/NabiNuhPage.dart';
import 'package:ajari/view/DashboardPage/HomePage/StoryPage/StoryPage.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'component.dart';

class ViewSantri extends StatelessWidget {
  final PageController pageViewController;

   const ViewSantri({Key? key,
    required this.pageViewController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        Column(
          children: [
            SizedBox(
              height: 150,
              child: PageView(
                physics: const BouncingScrollPhysics(),
                controller: pageViewController,
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
                                Icons.menu_book_rounded,
                                color: PaletteColor.primarybg,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Last Read",
                                style: TypographyStyle.subtitle2.merge(
                                    const TextStyle(color: PaletteColor.primarybg)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(
                            left: SpacingDimens.spacing12,
                            top: SpacingDimens.spacing16,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Jilid",
                                style: TypographyStyle.subtitle1.merge(
                                    const TextStyle(color: PaletteColor.primarybg)),
                              ),
                              Text(
                                " ١",
                                style: TypographyStyle.title.merge(
                                    const TextStyle(color: PaletteColor.primarybg)),
                              ),
                            ],
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
                                style: TypographyStyle.subtitle2.merge(
                                    const TextStyle(
                                        color: PaletteColor.primarybg,
                                        fontWeight: FontWeight.w100)),
                              ),
                              Text(
                                " 1",
                                style: TypographyStyle.subtitle2.merge(
                                  const TextStyle(color: PaletteColor.primarybg),
                                ),
                              ),
                            ],
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
                      bottom: SpacingDimens.spacing12,
                    ),
                    child: Ink(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF008165),
                            Color(0xFF22997B),
                            Color(0xFF3DAD8A),
                            Color(0xFF6EEA91),
                          ],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
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
                                    CostumeIcons.book,
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
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.only(
                                left: SpacingDimens.spacing12,
                                top: SpacingDimens.spacing16,
                              ),
                              child: Text(
                                "Kisah Nabi Musa",
                                style: TypographyStyle.subtitle1.merge(
                                    const TextStyle(color: PaletteColor.primarybg)),
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
                                    style: TypographyStyle.subtitle2.merge(
                                      const TextStyle(
                                          color: PaletteColor.primarybg,
                                          fontWeight: FontWeight.w100),
                                    ),
                                  ),
                                  Text(
                                    " 1",
                                    style: TypographyStyle.subtitle2.merge(
                                      const TextStyle(color: PaletteColor.primarybg),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SmoothPageIndicator(
              controller: pageViewController,
              count: 2,
              axisDirection: Axis.horizontal,
              onDotClicked: (i) {
                pageViewController.animateToPage(
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
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) => ReadBottomSheetDialog(
                        ctx: context,
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
                            CostumeIcons.holy_quran,
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
                                "قرأ",
                                style: TypographyStyle.subtitle1.merge(
                                    const TextStyle(
                                        color: PaletteColor.primary,
                                        fontSize: 20)),
                              ),
                              Text("Baca",
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
                      MaterialPageRoute(builder: (context) => const StoryPage()),
                    );
                  },
                  child: Container(
                    height: 65,
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: PaletteColor.primary.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(
                                100,
                              )),
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
        Container(
          margin: const EdgeInsets.only(
              top: SpacingDimens.spacing24,
              left: SpacingDimens.spacing28,
              bottom: SpacingDimens.spacing16),
          child: const Text(
            "Something Interesting",
            style: TypographyStyle.subtitle2,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 140,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(
                width: SpacingDimens.spacing28,
              ),
              cardStry(
                image: 'assets/images/nabi_ibrahim.png',
                title: const Text(
                  "Kisah Nabi Ibrahim",
                  style: TextStyle(color: PaletteColor.primarybg, fontSize: 16),
                ),
                color: const Color(0xFF9F5A2A),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const NabiIbrahimPage(),
                    ),
                  );
                },
              ),
              cardStry(
                image: 'assets/images/nabi_musa.png',
                title: const Text(
                  "Kisah Nabi Musa",
                  style: TextStyle(color: Color(0xFF620101), fontSize: 16),
                ),
                color: const Color(0xFFF7EAC0),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const NabiMusaPage(),
                    ),
                  );
                },
              ),
              cardStry(
                image: 'assets/images/nabi_nuh.png',
                title: const Text(
                  "Kisah Nabi Nuh",
                  style: TextStyle(color: PaletteColor.primarybg, fontSize: 16),
                ),
                color: const Color(0xFF8DAA3C),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const NabihNuhPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
