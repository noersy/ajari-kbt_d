import 'package:ajari/providers/kelas_providers.dart';
import 'package:ajari/theme/costume_icons.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:ajari/view/DashboardPage/HomePage/StoryPage/story_page.dart';
import 'package:ajari/view/DashboardPage/HomePage/StudensPage/studens_page.dart';
import 'package:ajari/view/DashboardPage/HomePage/component/home_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  bool isButtonList = true;

  List<Map<String, dynamic>> get _listSantri =>
      Provider.of<KelasProvider>(context, listen: false).listSantri;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: widget.scrollController,
      primary: false,
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              right: SpacingDimens.spacing28,
              left: SpacingDimens.spacing28,
              top: SpacingDimens.spacing12,
              bottom: 2.0,
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
                            backgroundColor:
                                isButtonList ? PaletteColor.grey40 : null,
                            padding: const EdgeInsets.all(0)),
                        onPressed: () => setState(() => isButtonList = true),
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
                            backgroundColor:
                                isButtonList ? null : PaletteColor.grey40,
                            padding: const EdgeInsets.all(0)),
                        onPressed: () => setState(() => isButtonList = false),
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
            padding: const EdgeInsets.symmetric(
              horizontal: SpacingDimens.spacing12,
            ),
            child: AnimatedSwitcher(
              switchInCurve: Curves.ease,
              switchOutCurve: Curves.ease,
              duration: const Duration(milliseconds: 200),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return SizeTransition(sizeFactor: animation, child: child);
              },
              child: _homeButton(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: SpacingDimens.spacing28,
              left: SpacingDimens.spacing28,
              top: SpacingDimens.spacing12,
              bottom: 2.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Santri",
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
                            backgroundColor: PaletteColor.grey40,
                            padding: const EdgeInsets.all(0)),
                        onPressed: () => setState(() => isButtonList = true),
                        child: const Icon(
                          Icons.view_list_rounded,
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
          Column(
            children: [
              for (Map<String, dynamic> item in _listSantri)
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: SpacingDimens.spacing12),
                  child: Card(
                    elevation: 2,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7.0))),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(45),
                          child: CachedNetworkImage(
                            imageUrl: item["photo"] ?? "-",
                          ),
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(item["name"] ?? "-"),
                              const Text(
                                "20%",
                                style: TypographyStyle.caption2,
                              ),
                            ],
                          ),
                          const SizedBox(height: SpacingDimens.spacing4),
                          Stack(
                            children: [
                              Container(
                                height: 5,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: PaletteColor.grey40,
                                  borderRadius: BorderRadius.circular(7.0),
                                ),
                              ),
                              Container(
                                height: 5,
                                margin: const EdgeInsets.only(right: 200),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: PaletteColor.primary,
                                  borderRadius: BorderRadius.circular(7.0),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
            ],
          )
        ],
      ),
    );
  }

  Widget _homeButton() {
    if (isButtonList) {
      return Container(
        key: const ValueKey<int>(0),
        child: Row(
          children: const [
            UstazHomePageButtonList(
              icon: CostumeIcons.holyQuran,
              titleArab: "قيم",
              title: "Nilai",
              target: StudentsPage(),
            ),
            UstazHomePageButtonList(
              icon: Icons.collections_bookmark_sharp,
              iconSize: 28.0,
              titleArab: "قصة",
              title: "Cerita",
              target: StoryPage(),
            ),
          ],
        ),
      );
    } else {
      return Container(
        key: const ValueKey<int>(1),
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
      );
    }
  }
}
