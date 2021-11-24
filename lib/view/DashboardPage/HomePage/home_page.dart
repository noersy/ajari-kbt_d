import 'package:ajari/view/DashboardPage/HomePage/component/view_ustaz.dart';
import 'package:flutter/material.dart';

import 'component/view_santri.dart';

class HomePage extends StatelessWidget {
  final _pageViewController = PageController();
  final String role, username;

  HomePage({Key? key, required this.role, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6EEA91), Color(0xFF008165)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // appBar: AppBarNotification(
        //   ctx: context,
        //   title: 'Hallo, $username!',
        // ),
        body: role == "Santri"
            ? ViewSantri(pageViewController: _pageViewController, name: username)
            : ViewUstaz(pageViewController: _pageViewController, name: username),
      ),
    );
  }
}
