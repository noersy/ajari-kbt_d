
import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/costume_icons.dart';
import 'package:ajari/view/DashboardPage/KelasPage/ClassPage.dart';
import 'package:flutter/material.dart';

import 'HomePage/HomePage.dart';
import 'UserBottomSheetDialog/UserBottomSheetDialog.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

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
        items: const [
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
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children:  [
            HomePage(),
            const ClassPage(),
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
          duration: const Duration(milliseconds: 500),
          curve: Curves.fastOutSlowIn,
        );
        setState(() {
          _bottomNavBarSelectedIndex = index;
        });
      }

      if (index == 2) {
        showModalBottomSheet(
          context: context,
          builder: (BuildContext context) => UserBottomSheetDialog(
            ctx: context,
          ),
        );
      }
    }
  }

}
