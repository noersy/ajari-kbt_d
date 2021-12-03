import 'package:ajari/component/appbar/appbar_notification.dart';
import 'package:ajari/model/profile.dart';
import 'package:ajari/providers/profile_providers.dart';
import 'package:ajari/view/DashboardPage/HomePage/component/view_ustaz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'component/view_santri.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Profile profile = Provider.of<ProfileProvider>(context, listen: false).profile;

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
        body: profile.role == "Santri"
            ? ViewSantri(name: profile.name)
            : ViewUstaz(name: profile.name),
      ),
    );
  }
}
