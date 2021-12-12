import 'package:ajari/theme/costume_icons.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:ajari/view/DashboardPage/HomePage/StoryPage/story_page.dart';
import 'package:ajari/view/DashboardPage/HomePage/StudensPage/studens_page.dart';
import 'package:ajari/view/DashboardPage/HomePage/component/home_button.dart';
import 'package:flutter/material.dart';

class ViewUstaz extends StatefulWidget {
  final String name;
  final ScrollController scrollController;

  const ViewUstaz({
    Key? key,
    required this.name,
    required this.scrollController,
  }) : super(key: key);

  @override
  State<ViewUstaz> createState() => _ViewUstazState();
}

class _ViewUstazState extends State<ViewUstaz> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SpacingDimens.spacing28,
              vertical: SpacingDimens.spacing8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Menu",
                  style: TypographyStyle.button2.copyWith(
                    fontWeight: FontWeight.bold,
                    color: PaletteColor.grey.withOpacity(0.8),
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            primary: PaletteColor.primary,
                            padding: const EdgeInsets.all(0)
                        ),
                        onPressed: () {  },
                        child: const Icon(
                          Icons.view_list_rounded,
                          size: 18,
                          color: PaletteColor.grey80,
                        ),
                      ),
                    ),
                    const SizedBox(width: SpacingDimens.spacing4),
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          primary: PaletteColor.primary,
                          backgroundColor: PaletteColor.grey40,
                          padding: const EdgeInsets.all(0)
                        ),
                        onPressed: () {  },
                        child: const Icon(
                          Icons.view_module_rounded,
                          size: 18,
                          color: PaletteColor.grey80,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: SpacingDimens.spacing12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                UstazHomePageButtonExtend(
                  icon: CostumeIcons.holyQuran,
                  titleArab: "قيم",
                  title: "Nilai",
                  target: StudentsPage(),
                ),
                UstazHomePageButtonExtend(
                  icon: Icons.collections_bookmark_sharp,
                  iconSize: 28.0,
                  titleArab: "قصة",
                  title: "Cerita",
                  target: StoryPage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
