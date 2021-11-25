
import 'package:ajari/model/kelas.dart';
import 'package:ajari/providers/kelas_providers.dart';
import 'package:ajari/providers/profile_providers.dart';
import 'package:ajari/model/profile.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/costume_icons.dart';
import 'package:ajari/view/DashboardPage/KelasPage/kelas_page.dart';
import 'package:ajari/view/UserBottomSheetDialog/user_bottomsheet_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'HomePage/home_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _bottomNavBarSelectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    Provider.of<KelasProvider>(context, listen: false).instalizeKelasService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColor.primarybg,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CostumeIcons.homeOutline, size: 20),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CostumeIcons.calendarOutlilne, size: 20),
            label: 'Kelas',
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
