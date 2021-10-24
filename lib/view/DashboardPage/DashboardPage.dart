import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/view/DashboardPage/KelasPage/ClassPage.dart';
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
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      HomePage(),
      ClassPage(),
    ];

    return Scaffold(
      backgroundColor: PaletteColor.primarybg,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Class',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _bottomNavBarSelectedIndex,
        selectedItemColor: Colors.green,
        onTap: _onItemTapped,
      ),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          children: _children,
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
}
