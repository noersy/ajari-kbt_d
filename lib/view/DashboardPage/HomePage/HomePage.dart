import 'package:ajari/component/AppBar/AppBarNotification.dart';
import 'package:ajari/model/Kelas.dart';
import 'package:ajari/model/Profile.dart';
import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/theme/TypographyStyle.dart';
import 'package:ajari/view/DashboardPage/HomePage/ReadBottomSheetDialog/ReadBottomSheetDialog.dart';
import 'package:ajari/view/DashboardPage/HomePage/StoryPage/ChildStoryPage/NabiIbrahimPage.dart';
import 'package:ajari/view/DashboardPage/HomePage/StoryPage/ChildStoryPage/NabiMusaPage.dart';
import 'package:ajari/view/DashboardPage/HomePage/StoryPage/ChildStoryPage/NabiNuhPage.dart';
import 'package:ajari/view/DashboardPage/HomePage/StoryPage/StoryPage.dart';
import 'package:ajari/view/DashboardPage/StudensPage/StudensPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:ajari/config/globals.dart' as globals;

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pageViewController = PageController();
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
          ? ViewSantri()
          : ViewUstaz(),
    );
  }

  Widget ViewSantri() {
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        Column(
          children: [
            SizedBox(
              height: 150,
              child: PageView(
                physics: BouncingScrollPhysics(),
                controller: pageViewController,
                children: [
                  Container(
                    height: 130,
                    alignment: Alignment.bottomRight,
                    margin: const EdgeInsets.only(
                        top: SpacingDimens.spacing16,
                        left: SpacingDimens.spacing16,
                        right: SpacingDimens.spacing16,
                        bottom: SpacingDimens.spacing12),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF6EEA91), Color(0xFF008165)],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          child: Image.asset(
                            'assets/images/Quran.png',
                          ),
                          height: 100,
                          alignment: Alignment.bottomRight,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(
                            left: SpacingDimens.spacing12,
                            top: SpacingDimens.spacing16,
                          ),
                          height: 130,
                          child: Row(
                            children: [
                              Icon(
                                Icons.menu_book_rounded,
                                color: PaletteColor.primarybg,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Last Read",
                                style: TypographyStyle.subtitle2.merge(
                                    TextStyle(color: PaletteColor.primarybg)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(
                            left: SpacingDimens.spacing12,
                            top: SpacingDimens.spacing16,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Jilid",
                                style: TypographyStyle.subtitle1.merge(
                                    TextStyle(color: PaletteColor.primarybg)),
                              ),
                              Text(
                                " ١",
                                style: TypographyStyle.title.merge(
                                    TextStyle(color: PaletteColor.primarybg)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          margin: const EdgeInsets.only(
                            left: SpacingDimens.spacing12,
                            bottom: SpacingDimens.spacing16,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Halaman",
                                style: TypographyStyle.subtitle2.merge(
                                    TextStyle(
                                        color: PaletteColor.primarybg,
                                        fontWeight: FontWeight.w100)),
                              ),
                              Text(
                                " 1",
                                style: TypographyStyle.subtitle2.merge(
                                  TextStyle(color: PaletteColor.primarybg),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 130,
                    alignment: Alignment.bottomRight,
                    margin: const EdgeInsets.only(
                        top: SpacingDimens.spacing16,
                        left: SpacingDimens.spacing16,
                        right: SpacingDimens.spacing16,
                        bottom: SpacingDimens.spacing12),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF6EEA91), Color(0xFF008165)],
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          child: Image.asset(
                            '-',
                          ),
                          height: 100,
                          alignment: Alignment.bottomRight,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(
                            left: SpacingDimens.spacing12,
                            top: SpacingDimens.spacing16,
                          ),
                          height: 130,
                          child: Row(
                            children: [
                              Icon(
                                Icons.menu_book_rounded,
                                color: PaletteColor.primarybg,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Last Read",
                                style: TypographyStyle.subtitle2.merge(
                                    TextStyle(color: PaletteColor.primarybg)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: const EdgeInsets.only(
                            left: SpacingDimens.spacing12,
                            top: SpacingDimens.spacing16,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Jilid",
                                style: TypographyStyle.subtitle1.merge(
                                    TextStyle(color: PaletteColor.primarybg)),
                              ),
                              Text(
                                " ١",
                                style: TypographyStyle.title.merge(
                                    TextStyle(color: PaletteColor.primarybg)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          margin: const EdgeInsets.only(
                            left: SpacingDimens.spacing12,
                            bottom: SpacingDimens.spacing16,
                          ),
                          child: Row(
                            children: [
                              Text(
                                "Halaman",
                                style: TypographyStyle.subtitle2.merge(
                                    TextStyle(
                                        color: PaletteColor.primarybg,
                                        fontWeight: FontWeight.w100)),
                              ),
                              Text(
                                " 1",
                                style: TypographyStyle.subtitle2.merge(
                                  TextStyle(color: PaletteColor.primarybg),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SmoothPageIndicator(
              controller: pageViewController,
              count: 2,
              axisDirection: Axis.horizontal,
              onDotClicked: (i) {
                pageViewController.animateToPage(
                  i,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.ease,
                );
              },
              effect: ExpandingDotsEffect(
                expansionFactor: 3,
                spacing: 8,
                radius: 16,
                dotWidth: 10,
                dotHeight: 10,
                dotColor: PaletteColor.grey40,
                activeDotColor: PaletteColor.primary,
                paintStyle: PaintingStyle.fill,
              ),
            ),
          ],
        ),
        SizedBox(height: SpacingDimens.spacing8),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) => ReadBottomSheetDialog(
                        ctx: context,
                        uid: _user.uid,
                        codeKelas: _profile.codeKelas,
                        role: _profile.role,
                      ),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 65,
                    width: 150,
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          margin: const EdgeInsets.all(SpacingDimens.spacing8),
                          decoration: BoxDecoration(
                              color: PaletteColor.primary.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(100)),
                          child: Icon(
                            Icons.book,
                            color: PaletteColor.primary,
                          ),
                        ),
                        Container(
                          width: 70,
                          padding: const EdgeInsets.only(
                              bottom: SpacingDimens.spacing12,
                              left: SpacingDimens.spacing12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "قرأ",
                                style: TypographyStyle.subtitle1.merge(
                                    TextStyle(
                                        color: PaletteColor.primary,
                                        fontSize: 20)),
                              ),
                              Text("Baca",
                                  style: TypographyStyle.subtitle2
                                      .merge(TextStyle(fontSize: 12))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: SpacingDimens.spacing12,
              ),
              Card(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => StoryPage()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 65,
                    width: 150,
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          margin: const EdgeInsets.all(SpacingDimens.spacing8),
                          decoration: BoxDecoration(
                              color: PaletteColor.primary.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(100)),
                          child: Icon(
                            Icons.collections_bookmark_sharp,
                            color: PaletteColor.primary,
                          ),
                        ),
                        Container(
                          width: 60,
                          padding: const EdgeInsets.only(
                              bottom: SpacingDimens.spacing12,
                              left: SpacingDimens.spacing12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "قصة",
                                style: TypographyStyle.subtitle1.merge(
                                    TextStyle(
                                        color: PaletteColor.primary,
                                        fontSize: 20)),
                              ),
                              Text(
                                "Cerita",
                                style: TypographyStyle.subtitle2.merge(
                                  TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
              top: SpacingDimens.spacing24,
              left: SpacingDimens.spacing28,
              bottom: SpacingDimens.spacing16),
          child: Text(
            "Something Interesting",
            style: TypographyStyle.subtitle2,
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 140,
          child: ListView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: [
              SizedBox(
                width: SpacingDimens.spacing28,
              ),
              _cardStry(
                image: 'assets/images/nabi_ibrahim.png',
                title: Text(
                  "Kisah Nabi Ibrahim",
                  style: TextStyle(color: PaletteColor.primarybg, fontSize: 16),
                ),
                color: Color(0xFF9F5A2A),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NabiIbrahimPage(),
                    ),
                  );
                },
              ),
              _cardStry(
                image: 'assets/images/nabi_musa.png',
                title: Text(
                  "Kisah Nabi Musa",
                  style: TextStyle(color: Color(0xFF620101), fontSize: 16),
                ),
                color: Color(0xFFF7EAC0),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NabiMusaPage(),
                    ),
                  );
                },
              ),
              _cardStry(
                image: 'assets/images/nabi_nuh.png',
                title: Text(
                  "Kisah Nabi Nuh",
                  style: TextStyle(color: PaletteColor.primarybg, fontSize: 16),
                ),
                color: Color(0xFF8DAA3C),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NabihNuhPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget ViewUstaz() {
    return Column(
      children: [
        Column(
          children: [
            Container(
              height: 130,
              alignment: Alignment.bottomRight,
              margin: const EdgeInsets.only(
                  top: SpacingDimens.spacing16,
                  left: SpacingDimens.spacing16,
                  right: SpacingDimens.spacing16,
                  bottom: SpacingDimens.spacing12),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF6EEA91), Color(0xFF008165)],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    child: Image.asset(
                      'assets/images/Quran.png',
                    ),
                    height: 100,
                    alignment: Alignment.bottomRight,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.only(
                      left: SpacingDimens.spacing12,
                      top: SpacingDimens.spacing16,
                    ),
                    height: 130,
                    child: Row(
                      children: [
                        Icon(
                          Icons.people,
                          color: PaletteColor.primarybg,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          "Studens",
                          style: TypographyStyle.subtitle2.merge(
                              TextStyle(color: PaletteColor.primarybg)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(
                      left: 50,
                      top: SpacingDimens.spacing8,
                    ),
                    child: Text(
                      "${_kelas.jumlahSantri}",
                      style: TypographyStyle.title.merge(
                          TextStyle(color: PaletteColor.primarybg)),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    margin: const EdgeInsets.only(
                      left: SpacingDimens.spacing12,
                      bottom: SpacingDimens.spacing16,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: SpacingDimens.spacing8),
                      child: Text(
                        " ${_kelas.nama}",
                        style: TypographyStyle.subtitle2.merge(
                            TextStyle(
                                color: PaletteColor.primarybg,
                                fontWeight: FontWeight.w100)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      right: SpacingDimens.spacing8),
                  height: 10,
                  width: 20,
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius.all(Radius.circular(10)),
                      color: PaletteColor.primary),
                ),
                Container(
                  height: 10,
                  width: 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: PaletteColor.grey60),
                    color: PaletteColor.primarybg2,
                  ),
                ),
              ],
            ),
          ],
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => StudensPage(
                          codeKelas: _profile.codeKelas,
                          uid: _user.uid,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 65,
                    width: 150,
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          margin: const EdgeInsets.all(
                              SpacingDimens.spacing8),
                          decoration: BoxDecoration(
                              color:
                              PaletteColor.primary.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(100)),
                          child: Icon(
                            Icons.book,
                            color: PaletteColor.primary,
                          ),
                        ),
                        Container(
                          width: 70,
                          padding: const EdgeInsets.only(
                              bottom: SpacingDimens.spacing12,
                              left: SpacingDimens.spacing12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              Text(
                                "قيم",
                                style: TypographyStyle.subtitle1.merge(
                                    TextStyle(
                                        color: PaletteColor.primary,
                                        fontSize: 20)),
                              ),
                              Text("Nilai",
                                  style: TypographyStyle.subtitle2
                                      .merge(TextStyle(fontSize: 12))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: SpacingDimens.spacing12,
              ),
              Card(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => StoryPage()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 65,
                    width: 150,
                    child: Row(
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          margin: const EdgeInsets.all(
                              SpacingDimens.spacing8),
                          decoration: BoxDecoration(
                              color:
                              PaletteColor.primary.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(100)),
                          child: Icon(
                            Icons.collections_bookmark_sharp,
                            color: PaletteColor.primary,
                          ),
                        ),
                        Container(
                          width: 60,
                          padding: const EdgeInsets.only(
                              bottom: SpacingDimens.spacing12,
                              left: SpacingDimens.spacing12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment:
                            CrossAxisAlignment.center,
                            children: [
                              Text(
                                "قصة",
                                style: TypographyStyle.subtitle1.merge(
                                    TextStyle(
                                        color: PaletteColor.primary,
                                        fontSize: 20)),
                              ),
                              Text(
                                "Cerita",
                                style: TypographyStyle.subtitle2.merge(
                                  TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _cardStry({
  required image,
  required title,
  required color,
  required onTap,
}) {
  return Card(
    color: color,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: TextButton(
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0)),
      ),
      onPressed: onTap,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: SpacingDimens.spacing8),
            child: Align(
              child: Image.asset(
                image,
                height: 100,
              ),
              alignment: Alignment.bottomLeft,
            ),
          ),
          Container(
            width: 120,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: title,
            ),
          ),
        ],
      ),
    ),
  );
}
