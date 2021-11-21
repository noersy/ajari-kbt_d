import 'package:ajari/model/profile.dart';
import 'package:ajari/providers/kelas_providers.dart';
import 'package:ajari/providers/profile_providers.dart';
import 'package:ajari/route/route_transisition.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:ajari/view/DashboardPage/KelasPage/AbsenPage/absen_detailpage.dart';
import 'package:ajari/view/DashboardPage/KelasPage/component/component.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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
                    return DateCard(
                      dateTime: _listRealDate[index],
                      hari: _listDay[index],
                      tgl: _listDate[index],
                      haveEvent: _absen!.where((element) => element.get("datetime").toDate().day == _listRealDate[index].day).isNotEmpty,
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
                        _absen!.where((element) => element.get("datetime").toDate().day == item.day,).isNotEmpty
                            ? SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                        height: SpacingDimens.spacing28),
                                    for (var itm in _absen) ...[
                                      if (item.day == itm.get('datetime').toDate().day) ...[
                                        ListAbsent(
                                          present: itm.reference,
                                          date: itm.get('datetime').toDate(),
                                          startAt: _formatTime.format(itm.get('start_at').toDate()), endAt: _formatTime.format(itm.get('end_at').toDate()),
                                        )
                                      ],
                                    ],
                                  ],
                                ),
                              )
                            : Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(Icons.notification_add_outlined,
                                        color: PaletteColor.grey60, size: 30),
                                    SizedBox(width: SpacingDimens.spacing4),
                                    Text("Tidak ada jadwal",
                                        style: TextStyle(color: PaletteColor.grey60))
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

class ListAbsent extends StatefulWidget {
  final DocumentReference<Object?> present;
  final String startAt, endAt;
  final DateTime date;

  const ListAbsent({
    Key? key,
    required this.present,
    required this.startAt,
    required this.endAt,
    required this.date,
  }) : super(key: key);

  @override
  _ListAbsentState createState() => _ListAbsentState();
}

class _ListAbsentState extends State<ListAbsent> {
  bool isPresent = true;
  int _absentCount = 0;
  String _uid = "-";

  Future<bool> present() async {
    try {
      DocumentSnapshot _absent = await widget.present.collection('santri').doc(_uid).get();
      if (mounted) {
        setState(() {
          isPresent = _absent.get('kehadiran');
        });
      }
      return _absent.get('kehadiran');
    }catch(e){
      if (kDebugMode) {
        print(e.runtimeType);
        print(e);
      }
    }
    return false;
  }

  Future<bool> presentCount() async {
    try {
      QuerySnapshot _absent = await widget.present.collection('santri').get();
      if (mounted) {
        setState(() {
          _absentCount = _absent.docs.where((element) {
            return element.get("kehadiran");
          }).length;
          print(_absent.docs.length);
        });
      }
    }catch(e){
      if (kDebugMode) {
        print(e.runtimeType);
        print(e);
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    String _role = Provider.of<ProfileProvider>(context, listen: false).profile.role;
    _uid = FirebaseAuth.instance.currentUser?.uid ?? "-";

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
              AnimatedContainer(
                duration: const Duration(milliseconds: 800),
                curve: Curves.ease,
                width: isPresent ? 240.0 : 290.0,
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
                  onPressed: () {
                    if(_role == "Pengajar"){
                      Navigator.of(context).push(routeTransition(AbsenDetailPage(dateTIme: widget.date)));
                    }else if(_role == "Santri"){
                      Provider.of<KelasProvider>(context, listen: false).absent(date: widget.date, uid: _uid);
                    }
                  },
                  child: FutureBuilder<bool>(
                    future: _role != "Santri" ? presentCount() : present(),
                    builder: (context, snapshot) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // const Text(
                          //   "Kehadiran",
                          //   style: TypographyStyle.button1,
                          // ),
                          Container(
                            decoration: BoxDecoration(
                                color: PaletteColor.grey40,
                                borderRadius: BorderRadius.circular(4.0)),
                            padding: const EdgeInsets.only(
                              left: SpacingDimens.spacing8,
                              right: SpacingDimens.spacing8,
                              top: SpacingDimens.spacing4,
                              bottom: SpacingDimens.spacing4,
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  color: PaletteColor.grey,
                                  size: 18,
                                ),
                                const SizedBox(width: SpacingDimens.spacing8),
                                Text(
                                  widget.startAt,
                                  style: TypographyStyle.button1,
                                ),
                                const SizedBox(width: SpacingDimens.spacing4),
                                const Text(
                                  "-",
                                  style: TypographyStyle.button1,
                                ),
                                const SizedBox(width: SpacingDimens.spacing4),
                                Text(
                                  widget.endAt,
                                  style: TypographyStyle.button1,
                                ),
                              ],
                            ),
                          ),
                          _role != "Santri"
                              ? Container(
                                decoration: BoxDecoration(
                                    color: PaletteColor.grey40,
                                    borderRadius: BorderRadius.circular(4.0)),
                                padding: const EdgeInsets.only(
                                  left: SpacingDimens.spacing8,
                                  right: SpacingDimens.spacing8,
                                  top: SpacingDimens.spacing4,
                                  bottom: SpacingDimens.spacing4,
                                ),
                                child: Row(
                                  children: [
                                    Text("$_absentCount", style: TypographyStyle.button2),
                                    const SizedBox(width: SpacingDimens.spacing4),
                                    const Icon(
                                      Icons.people,
                                      color: PaletteColor.grey,
                                      size: 18,
                                    ),
                                  ],
                                ),
                              )
                              : AnimatedContainer(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                            width: isPresent ? 70 : 112,
                            height: isPresent ? 26 : 26,
                            decoration: BoxDecoration(
                                color:
                                    isPresent ? PaletteColor.primary : Colors.red,
                                borderRadius: BorderRadius.circular(4.0)),
                            padding: const EdgeInsets.only(
                              left: SpacingDimens.spacing8,
                              right: SpacingDimens.spacing8,
                              top: SpacingDimens.spacing4,
                              bottom: SpacingDimens.spacing4,
                            ),
                            child: Stack(
                              children: [
                                AnimatedOpacity(
                                  duration: const Duration(milliseconds: 1000),
                                  opacity: isPresent ? 0 : 1,
                                  child: Text(
                                    "Belum Present",
                                    style: TypographyStyle.button2
                                        .copyWith(color: PaletteColor.primarybg),
                                  ),
                                ),
                                AnimatedOpacity(
                                  duration: const Duration(milliseconds: 1000),
                                  opacity: isPresent ? 1 : 0,
                                  child: Text(
                                    "Present",
                                    style: TypographyStyle.button2.copyWith(
                                      color: PaletteColor.primarybg,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
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
}
