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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ViewUstaz extends StatelessWidget {
  final String name;

  ViewUstaz({
    Key? key,
    required this.name,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}





