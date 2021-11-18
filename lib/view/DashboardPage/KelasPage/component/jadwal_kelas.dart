import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:ajari/view/DashboardPage/KelasPage/component/component.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

class JadwalKelas extends StatefulWidget {
  const JadwalKelas({Key? key}) : super(key: key);

  @override
  State<JadwalKelas> createState() => _JadwalKelasState();
}

class _JadwalKelasState extends State<JadwalKelas> {
  final List<String> _listDate = [];
  final DateTime _dateTime = DateTime.now();
  late PageController _pageController;
  int _index = 0;
  int _indexCurret = 0;
  final List<String> _listDay = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];

  @override
  void initState() {
    var weekDay = _dateTime.weekday;
    for (int i = 0; i < 7; i++) {
      int _date = _dateTime.subtract(Duration(days: weekDay - i - 1)).day;
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
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: 60,
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemExtent: 50,
              itemCount: 7,
              padding: const EdgeInsets.only(
                top: SpacingDimens.spacing8,
                left: SpacingDimens.spacing16,
                right: SpacingDimens.spacing16,
              ),
              itemBuilder: (BuildContext context, int index) {
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
                  _listPage(),
                  const Center(child: Text("2")),
                  const Center(child: Text("3")),
                  const Center(child: Text("4")),
                  const Center(child: Text("5")),
                  const Center(child: Text("6")),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _listPage() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: SpacingDimens.spacing16 + 2,
                top: SpacingDimens.spacing28,
            ),
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
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.all(0)),
                    onPressed: () => _joinMeeting(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          style: TypographyStyle.button1.merge(
                            const TextStyle(color: PaletteColor.primarybg),
                          ),
                        ),
                        Container(
                          height: 45,
                          width: 45,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: PaletteColor.primarybg.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(15)),
                          child:
                              const Text("0+", style: TypographyStyle.button1),
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 25,
                      width: 3.5,
                      margin: const EdgeInsets.only(
                        left: SpacingDimens.spacing16 + 1.7,
                      ),
                      decoration: BoxDecoration(
                        color: PaletteColor.grey60,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: SpacingDimens.spacing4,
                        bottom: SpacingDimens.spacing4,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "08:40",
                            style: TypographyStyle.button2.merge(
                              const TextStyle(color: PaletteColor.primary),
                            ),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            "WIB",
                            style: TypographyStyle.mini.merge(
                              const TextStyle(color: PaletteColor.primary),
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
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    Container(
                      height: 30,
                      width: 3.5,
                      margin: const EdgeInsets.only(
                          left: SpacingDimens.spacing16 + 1.5),
                      decoration: BoxDecoration(
                        color: PaletteColor.grey60,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ],
                ),
              ],
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
