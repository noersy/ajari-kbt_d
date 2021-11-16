import 'package:ajari/component/appbar/appbar_notification.dart';
import 'package:ajari/config/globals.dart' as globals;
import 'package:ajari/model/profile.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/view/DashboardPage/HomePage/component/view_ustaz.dart';
import 'package:flutter/material.dart';

import 'component/view_santri.dart';

class HomePage extends StatelessWidget {
  final _pageViewController = PageController();
  final String _username = globals.Get.usr().displayName!;
  final Profile _profile = globals.Get.prf();

  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColor.primarybg,
      appBar: AppBarNotification(
        ctx: context,
        title: 'Hallo, $_username!',
      ),
      body: _profile.role == "Santri"
          ? ViewSantri(pageViewController: _pageViewController)
          : ViewUstaz(pageViewController: _pageViewController),
    );
  }
}
