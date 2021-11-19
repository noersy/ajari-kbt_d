import 'package:ajari/component/appbar/appbar_notification.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/view/DashboardPage/HomePage/component/view_ustaz.dart';
import 'package:flutter/material.dart';

import 'component/view_santri.dart';

class HomePage extends StatelessWidget {
  final _pageViewController = PageController();
  final String role, username;

  HomePage({Key? key, required this.role, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColor.primarybg2,
      appBar: AppBarNotification(
        ctx: context,
        title: 'Hallo, $username!',
      ),
      body: role == "Santri"
          ? ViewSantri(pageViewController: _pageViewController)
          : ViewUstaz(pageViewController: _pageViewController),
    );
  }
}
