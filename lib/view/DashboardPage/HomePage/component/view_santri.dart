import 'package:ajari/theme/costume_icons.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:ajari/view/DashboardPage/HomePage/ReadBottomSheetDialog/read_bottomheet_dialog.dart';
import 'package:ajari/view/DashboardPage/HomePage/StoryPage/ChildStoryPage/nabi_ibrahim_page.dart';
import 'package:ajari/view/DashboardPage/HomePage/StoryPage/ChildStoryPage/nabi_musa_page.dart';
import 'package:ajari/view/DashboardPage/HomePage/StoryPage/ChildStoryPage/nabi_nuh_page.dart';
import 'package:ajari/view/DashboardPage/HomePage/StoryPage/story_page.dart';
import 'package:flutter/material.dart';

import 'component.dart';

class ViewSantri extends StatefulWidget {
  final String name;
  final ScrollController scrollController;

  const ViewSantri({
    Key? key,
    required this.name,
    required this.scrollController,
  }) : super(key: key);

  @override
  State<ViewSantri> createState() => _ViewSantriState();
}

class _ViewSantriState extends State<ViewSantri> {
  final _pageViewController = PageController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      primary: false,
      controller: _pageViewController,
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: SpacingDimens.spacing12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SantriHomePageButton(
                arab: "أقر",
                title: "Baca",
                onPressed: ()=> showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) => ReadBottomSheetDialog(ctx: context),
                ),
              ),
              const SizedBox(width: SpacingDimens.spacing8),
              SantriHomePageButton(
                arab: "قصة",
                title: "Cerita",
                onPressed: ()=> Navigator.of(context).push(
                  MaterialPageRoute(builder: (_)=> const StoryPage())
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(
              top: SpacingDimens.spacing24,
              left: SpacingDimens.spacing28,
              bottom: SpacingDimens.spacing16,
            ),
            child: const Text(
              "Something Interesting",
              style: TypographyStyle.subtitle2,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 140,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(width: SpacingDimens.spacing28),
                  cardStry(
                    image: 'assets/images/nabi_ibrahim.png',
                    title: const Text(
                      "Kisah Nabi Ibrahim",
                      style: TextStyle(
                          color: PaletteColor.primarybg, fontSize: 16),
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
                      style: TextStyle(
                          color: Color(0xFF620101), fontSize: 16),
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
                      style: TextStyle(
                          color: PaletteColor.primarybg, fontSize: 16),
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
          ),
        ],
      ),
    );
  }
}

class SantriHomePageButton extends StatelessWidget {
  final Function() onPressed;
  final String arab, title;


  const SantriHomePageButton({
    Key? key,
    required this.onPressed,
    required this.arab,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 2,
        primary: PaletteColor.primarybg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        side: BorderSide(
          color: PaletteColor.grey80.withOpacity(0.08),
        ),
      ),
      onPressed: onPressed,
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
                borderRadius: BorderRadius.circular(100),
              ),
              child: const Icon(
                CostumeIcons.holyQuran,
                color: PaletteColor.primary,
              ),
            ),
            Container(
              width: 70,
              padding: const EdgeInsets.only(
                bottom: SpacingDimens.spacing12,
                left: SpacingDimens.spacing12,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    arab,
                    style: TypographyStyle.subtitle1.copyWith(
                      color: PaletteColor.primary,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    title,
                    style: TypographyStyle.subtitle2.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
