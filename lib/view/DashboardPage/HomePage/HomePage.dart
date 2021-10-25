import 'package:ajari/component/AppBar/AppBarNotification.dart';
import 'package:ajari/config/globals.dart' as globals;
import 'package:ajari/model/Kelas.dart';
import 'package:ajari/model/Profile.dart';
import 'package:ajari/theme/PaletteColor.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'component/ViewSantri.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageViewController = PageController();
  late User _user;
  late Profile _profile;
  late Kelas _kelas;

  @override
  void initState() {
    _user = globals.user!;
    _profile = globals.profile!;
    _kelas = globals.kelas!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: PaletteColor.primarybg,
        appBar: AppBarNotification(
          ctx: context,
          title: 'Hallo, ${_user.displayName}!',
        ),
        body: _profile.role == "Santri"
            ? ViewSantri(
                pageViewController: _pageViewController,
                user: _user,
                profile: _profile,
              )
            : SizedBox.shrink());
  }
}
