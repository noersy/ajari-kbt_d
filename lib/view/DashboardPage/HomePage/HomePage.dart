import 'package:ajari/component/AppBar/AppBarNotification.dart';
import 'package:ajari/config/globals.dart' as globals;
import 'package:ajari/model/Profile.dart';
import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/view/DashboardPage/HomePage/component/ViewUstaz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'component/ViewSantri.dart';

class HomePage extends StatelessWidget {
  final _pageViewController = PageController();
  final String _username = globals.Get.usr().displayName!;
  final Profile _profile = globals.Get.prf();

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
