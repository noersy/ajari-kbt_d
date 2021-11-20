import 'package:ajari/providers/kelas_providers.dart';
import 'package:ajari/route/route_transisition.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:ajari/view/DashboardPage/KelasPage/AbsenPage/absen_detailpage.dart';
import 'package:ajari/view/DashboardPage/KelasPage/component/component.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:provider/provider.dart';

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
        List<QueryDocumentSnapshot<Object?>>? _absen = [];

        if (snapshot.hasData) {
          _absen = snapshot.data?.docs.toList();
        }

        return Expanded(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: SpacingDimens.spacing4),
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
                    right: SpacingDimens.spacing16,
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
                        _absen!.where((element) => element.get("datetime").toDate().day == item.day).isNotEmpty ?
                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: SpacingDimens.spacing28),
                              for (var itm in _absen ?? []) ...[
                                if (item.day == itm.get('datetime').toDate().day) ...[
                                  _listAbsent(context, itm.get('datetime').toDate(), _formatTime.format(itm.get('start_at').toDate()), _formatTime.format(itm.get('end_at').toDate()))
                                ],
                              ],
                            ],
                          ),
                        ) :
                         Center(
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: const [
                                 Icon(Icons.notification_add_outlined, color: PaletteColor.grey60, size: 30),
                                 SizedBox(width: SpacingDimens.spacing4),
                                 Text("Tidak ada jadwal", style: TextStyle(color: PaletteColor.grey60))
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
      },
    );
  }

  Widget _listAbsent(BuildContext ctx, DateTime date, String startAt, String endAt, ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: SpacingDimens.spacing12,
            left: SpacingDimens.spacing8,
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                width: 240.0,
                margin: const EdgeInsets.only(left: 40.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: PaletteColor.primarybg,
                    elevation: 2,
                    padding: const EdgeInsets.all(SpacingDimens.spacing8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () => Navigator.of(ctx).push(routeTransition(AbsenDetailPage(dateTIme: date))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:  [
                      // const Text(
                      //   "Kehadiran",
                      //   style: TypographyStyle.button1,
                      // ),
                      Container(
                        decoration: BoxDecoration(
                            color: PaletteColor.grey40,
                            borderRadius: BorderRadius.circular(4.0)
                        ),
                        padding: const EdgeInsets.only(
                          left: SpacingDimens.spacing8,
                          right: SpacingDimens.spacing8,
                          top: SpacingDimens.spacing4,
                          bottom: SpacingDimens.spacing4,
                        ),
                        child: Row(
                          children:  [
                            const Icon(Icons.access_time, color: PaletteColor.grey, size: 18,),
                            const SizedBox(width: SpacingDimens.spacing8),
                            Text(startAt, style: TypographyStyle.button1,),
                            const SizedBox(width: SpacingDimens.spacing4),
                            const Text("-", style: TypographyStyle.button1,),
                            const SizedBox(width: SpacingDimens.spacing4),
                            Text(endAt, style: TypographyStyle.button1,),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: PaletteColor.grey40,
                          borderRadius: BorderRadius.circular(4.0)
                        ),
                        padding: const EdgeInsets.only(
                          left: SpacingDimens.spacing8,
                          right: SpacingDimens.spacing8,
                          top: SpacingDimens.spacing4,
                          bottom: SpacingDimens.spacing4,
                        ),
                        child: Row(
                          children: const [
                            Text("0", style: TypographyStyle.button2),
                            SizedBox(width: SpacingDimens.spacing4),
                            Icon(
                              Icons.people,
                              color: PaletteColor.grey,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 20,
                    width: 3.5,
                    decoration: BoxDecoration(
                      color: PaletteColor.grey60,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.only(
                        left: SpacingDimens.spacing16 + 1.8),
                  ),
                  Container(
                    height: 8,
                    width: 8,
                    margin: const EdgeInsets.only(
                      top: 2,
                      bottom: 2,
                      left: SpacingDimens.spacing16 - 0.5,
                    ),
                    decoration: BoxDecoration(
                      color: PaletteColor.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  Container(
                    height: 20,
                    width: 3.5,
                    decoration: BoxDecoration(
                      color: PaletteColor.grey60,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.only(
                        left: SpacingDimens.spacing16 + 1.8),
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
