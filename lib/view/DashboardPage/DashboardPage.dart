import 'dart:convert';

import 'package:ajari/config/FirebaseReference.dart';
import 'package:ajari/config/globals.dart' as globals;
import 'package:ajari/model/Profile.dart';
import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/costume_icons.dart';
import 'package:ajari/view/DashboardPage/KelasPage/ClassPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'HomePage/HomePage.dart';
import 'UserBottomSheetDialog/UserBottomSheetDialog.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage();

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _bottomNavBarSelectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColor.primarybg,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(CostumeIcons.home_outline, size: 20),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CostumeIcons.calendar_outlilne, size: 20),
            label: 'Class',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: 'Profile',
          ),
        ],
        currentIndex: _bottomNavBarSelectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
      body: SizedBox.expand(
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: [
            HomePage(),
            ClassPage(),
          ],
        ),
      ),
    );
  }

  _onItemTapped(index) {
    if (index != _bottomNavBarSelectedIndex) {
      if (index != 2) {
        _pageController.animateToPage(
          index,
          duration: Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
        );
        setState(() {
          _bottomNavBarSelectedIndex = index;
        });
      }

      if (index == 2)
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) => UserBottomSheetDialog(
            ctx: context,
          ),
        );
    }
  }

  void _fetchProfile() {
    try {
      DocumentReference documentReferencer =
          FirebaseReference.user.doc(globals.Get.usr().uid);

      documentReferencer.snapshots().listen((event) {
        print(event.data());

        var profile = profileFromJson(jsonEncode(event.data()));
        globals.Set.prf(profile);
      });
    } catch (e) {}
  }
}
