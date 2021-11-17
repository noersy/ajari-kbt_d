import 'package:ajari/providers/kelas_provider.dart';
import 'package:ajari/providers/profile_provider.dart';
import 'package:ajari/model/kelas.dart';
import 'package:ajari/model/profile.dart';
import 'package:ajari/route/route_transisition.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:ajari/view/DashboardPage/KelasPage/AbsenPage/absen_page.dart';
import 'package:ajari/view/DashboardPage/KelasPage/StudentListPage/studen_listpage.dart';
import 'package:ajari/view/DashboardPage/KelasPage/component/create_kelas.dart';
import 'package:ajari/view/DashboardPage/KelasPage/component/join_kelas.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:provider/provider.dart';

import 'component/component.dart';

class ClassPage extends StatefulWidget {
  const ClassPage({Key? key}) : super(key: key);

  @override
  _ClassPageState createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  late PageController _pageController;
  final List<String> _listDay = [
    '-',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];
  final List<String> _listDate = [];
  final DateTime _dateTime = DateTime.now();
  Profile _profile = Profile.blankProfile();
  int _index = 0;
  int _indexCurret = 0;
  User? user = FirebaseAuth.instance.currentUser;
  Kelas _kelas = Kelas.blankKelas();

  void freshState({required Kelas value}) {
    setState(() {
      _kelas = value;
    });
  }

  @override
  void initState() {
    _profile = context.read<ProfileProvider>().profile;
    var weekDay = _dateTime.weekday;
    for (int i = 0; i <= 7; i++) {
      int _date = _dateTime.subtract(Duration(days: weekDay - i)).day;
      _listDate.add(_date.toString());

      if (_dateTime.day == _date) {
        _index = i;
        _indexCurret = i;
        _pageController = PageController(initialPage: i);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    _kelas = context.read<KelasProvider>().kelas;

    return Scaffold(
      backgroundColor: PaletteColor.primarybg2,
      appBar: AppBar(
        backgroundColor: PaletteColor.primarybg,
        elevation: 0,
        title: const Text(
          "Class",
          style: TypographyStyle.subtitle1,
        ),
      ),
      body: _kelas.kelasId == "-"
          ? _profile.role != "Pengajar"
              ? JoinKelas(freshState: freshState)
              : CreateKelas(
                  ctx: context,
                  freshState: freshState,
                )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(SpacingDimens.spacing12),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: 150,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF6EEA91), Color(0xFF008165)],
                              ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: SpacingDimens.spacing16,
                                top: SpacingDimens.spacing12,
                                bottom: SpacingDimens.spacing8,
                              ),
                              child: Text(
                                _kelas.nama,
                                style: TypographyStyle.title.merge(
                                  const TextStyle(
                                    color: PaletteColor.primarybg2,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 150,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: SpacingDimens.spacing16,
                                  bottom: 4,
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.person,
                                      color: PaletteColor.primarybg2,
                                    ),
                                    Text(
                                      _kelas.pengajar,
                                      style: TypographyStyle.button1.merge(
                                        const TextStyle(
                                          fontSize: 18,
                                          color: PaletteColor.primarybg2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 150,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 19,
                                  top: 36,
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.people,
                                      size: 18,
                                      color: PaletteColor.primarybg2,
                                    ),
                                    Text(
                                      " ${_kelas.jumlahSantri}",
                                      style: TypographyStyle.button1.merge(
                                        const TextStyle(
                                          fontSize: 13,
                                          color: PaletteColor.primarybg2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 150,
                            child: Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  bottom: SpacingDimens.spacing8,
                                  right: SpacingDimens.spacing16,
                                ),
                                child: Text(
                                  _kelas.kelasId,
                                  style: TypographyStyle.button1.merge(
                                    TextStyle(
                                        fontSize: 12,
                                        color: PaletteColor.primarybg2
                                            .withOpacity(0.8),
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 120,
                            margin: const EdgeInsets.only(
                              right: SpacingDimens.spacing12,
                            ),
                            alignment: Alignment.topRight,
                            child: Image.asset(
                              'assets/images/lentrn.png',
                            ),
                          ),
                          _profile.role != "Santri"
                              ? Container(
                                  height: 155,
                                  alignment: Alignment.bottomLeft,
                                  child: Row(
                                    children: [
                                      const SizedBox(
                                          width: SpacingDimens.spacing4),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                            primary: PaletteColor.primary,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            )),
                                        onPressed: () =>
                                            Navigator.of(context).push(
                                          routeTransition(
                                            StudenListPage(
                                              codeKelas: _profile.codeKelas,
                                            ),
                                          ),
                                        ),
                                        child: Text(
                                          "Santri List",
                                          style:
                                              TypographyStyle.button2.copyWith(
                                            color: PaletteColor.primarybg2,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(
                                          SpacingDimens.spacing4,
                                        ),
                                        child: SizedBox(
                                          width: 1,
                                          height: SpacingDimens.spacing16,
                                          child: DecoratedBox(
                                            decoration: BoxDecoration(
                                              color: PaletteColor.primarybg2,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          primary: PaletteColor.primary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              routeTransition(
                                                  const AbsenPage()));
                                        },
                                        child: Text(
                                          "Absen",
                                          style:
                                              TypographyStyle.button2.copyWith(
                                            color: PaletteColor.primarybg2,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemExtent: 50,
                    itemCount: 7,
                    padding: const EdgeInsets.only(
                      top: SpacingDimens.spacing12,
                      left: SpacingDimens.spacing16,
                      right: SpacingDimens.spacing16,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      index++;
                      return dateCard(
                        hari: _listDay[index],
                        tgl: _listDate[index],
                        color: _index != index
                            ? _indexCurret != index
                                ? PaletteColor.grey80
                                : PaletteColor.primary.withOpacity(0.6)
                            : PaletteColor.primary,
                        onTap: () {
                          setState(() {
                            _index = index;
                            _pageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          });
                        },
                      );
                    },
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: SpacingDimens.spacing28,
                      left: SpacingDimens.spacing16,
                    ),
                    child: PageView(
                      physics: const BouncingScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (value) {
                        setState(() {
                          _index = value;
                        });
                      },
                      children: [
                        const Center(child: Text("1")),
                        ListView(
                          physics: const BouncingScrollPhysics(),
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: SpacingDimens.spacing16 + 2),
                              child: Stack(
                                children: [
                                  Container(
                                    alignment: Alignment.centerRight,
                                    height: 45,
                                    width: 170,
                                    decoration: BoxDecoration(
                                      color: PaletteColor.primary,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    margin: const EdgeInsets.only(
                                      top: 22,
                                      left: 70,
                                    ),
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                          primary: PaletteColor.primary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          padding: const EdgeInsets.all(0)),
                                      onPressed: () {
                                        _joinMeeting();
                                        // Navigator.of(context).push(
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             RoomPage()));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(
                                              left: SpacingDimens.spacing12,
                                            ),
                                            child: Icon(
                                              Icons.people,
                                              color: PaletteColor.primarybg,
                                            ),
                                          ),
                                          Text(
                                            "Join",
                                            style:
                                                TypographyStyle.button1.merge(
                                              const TextStyle(
                                                  color:
                                                      PaletteColor.primarybg),
                                            ),
                                          ),
                                          Container(
                                            height: 45,
                                            width: 45,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: PaletteColor.primarybg
                                                    .withOpacity(0.8),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: const Text("0+",
                                                style: TypographyStyle.button1),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 25,
                                        width: 3.5,
                                        margin: const EdgeInsets.only(
                                          left: SpacingDimens.spacing16 + 1.7,
                                        ),
                                        decoration: BoxDecoration(
                                          color: PaletteColor.grey60,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: SpacingDimens.spacing4,
                                          bottom: SpacingDimens.spacing4,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              "08:40",
                                              style:
                                                  TypographyStyle.button2.merge(
                                                const TextStyle(
                                                    color:
                                                        PaletteColor.primary),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              "WIB",
                                              style: TypographyStyle.mini.merge(
                                                const TextStyle(
                                                    color:
                                                        PaletteColor.primary),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 6,
                                        width: 6,
                                        margin: const EdgeInsets.only(
                                          left: SpacingDimens.spacing16,
                                          bottom: SpacingDimens.spacing8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: PaletteColor.primary,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      Container(
                                        height: 30,
                                        width: 3.5,
                                        margin: const EdgeInsets.only(
                                            left:
                                                SpacingDimens.spacing16 + 1.5),
                                        decoration: BoxDecoration(
                                          color: PaletteColor.grey60,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const Center(child: Text("2")),
                        const Center(child: Text("3")),
                        const Center(child: Text("4")),
                        const Center(child: Text("5")),
                        const Center(child: Text("6")),
                        const Center(child: Text("7"))
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  _joinMeeting() async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      featureFlag.resolution = FeatureFlagVideoResolution
          .MD_RESOLUTION; // Limit video resolution to 360p

      var options = JitsiMeetingOptions(room: 'myroom')
        ..serverURL = "https://meet.jit.si/myroom"
        ..subject = "Meeting Test"
        ..userDisplayName = user?.displayName ?? ""
        ..userEmail = "myemail@email.com"
        ..userAvatarURL = user?.photoURL ?? "" // or .png
        ..audioMuted = true
        ..videoMuted = true;

      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      debugPrint("erhttps://nhentai.net/g/355004/33/ror: $error");
    }
  }
}