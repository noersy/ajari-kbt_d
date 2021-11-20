import 'package:ajari/providers/kelas_providers.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:ajari/view/DashboardPage/KelasPage/component/component.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class JadwalKelas extends StatefulWidget {
  const JadwalKelas({Key? key}) : super(key: key);

  @override
  State<JadwalKelas> createState() => _JadwalKelasState();
}

class _JadwalKelasState extends State<JadwalKelas> {
  final List<String> _listDate = [];
  final List<DateTime> _listRealDate = [];
  final DateTime _dateTime = DateTime.now();
  final DateFormat _formatTime = DateFormat('hh:mm');
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
      final _date = _dateTime.subtract(Duration(days: weekDay - i - 1));
      _listRealDate.add(_date);
      _listDate.add(_date.day.toString());

      if (_dateTime.day == _date.day) {
        _index = i;
        _indexCurret = i;
        _pageController = PageController(initialPage: i);
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: Provider.of<KelasProvider>(context).getsAbsents(),
        builder: (context, snapshot) {
          List<QueryDocumentSnapshot<Object?>>? _absen;

          if (snapshot.hasData) {
            _absen = snapshot.data?.docs.toList();
          }

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
                        for (var item in _listRealDate)
                          SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(height: SpacingDimens.spacing28),
                                for (var itm in _absen ?? [])
                                  if (item.day == itm.get('datetime').toDate().day)
                                    _listAbsent( _formatTime.format(itm.get('start_at').toDate()), _formatTime.format(itm.get('end_at').toDate()))
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Widget _listAbsent(String startAt, String endAt) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: SpacingDimens.spacing16 + 2,
          ),
          child: Stack(
            children: [
              Container(
                alignment: Alignment.centerRight,
                width: 160.0,
                margin: const EdgeInsets.only(
                  top: 37.0,
                  left: 70.0,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: PaletteColor.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: const EdgeInsets.all(0),
                  ),
                  onPressed: () => {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(
                        Icons.people,
                        color: PaletteColor.primarybg,
                      ),
                      Text(
                        "Join",
                        style: TypographyStyle.button1.merge(
                          const TextStyle(color: PaletteColor.primarybg),
                        ),
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
                    height: 20,
                    width: 3.5,
                    alignment: Alignment.centerLeft,
                    color: PaletteColor.grey60,
                    margin: const EdgeInsets.only(left: SpacingDimens.spacing16 + 1.8),
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
                          startAt,
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
                    height: 30,
                    width: 4,
                    margin: const EdgeInsets.only(
                      left: SpacingDimens.spacing16 + 1.5,
                    ),
                    decoration: BoxDecoration(
                      color: PaletteColor.primary,
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
                          endAt,
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
                    height: 20,
                    width: 3.5,
                    color: PaletteColor.grey60,
                    margin: const EdgeInsets.only(left: SpacingDimens.spacing16 + 1.8),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
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
