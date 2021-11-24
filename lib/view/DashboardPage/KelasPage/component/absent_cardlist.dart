import 'package:ajari/providers/kelas_providers.dart';
import 'package:ajari/providers/profile_providers.dart';
import 'package:ajari/route/route_transisition.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:ajari/view/DashboardPage/KelasPage/AbsenPage/absen_detailpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AbsentList extends StatefulWidget {
  final DateTime startAt, endAt;
  final DateTime date;
  final String id;

  const AbsentList({
    Key? key,
    required this.startAt,
    required this.endAt,
    required this.date,
    required this.id,
  }) : super(key: key);

  @override
  _AbsentListState createState() => _AbsentListState();
}

class _AbsentListState extends State<AbsentList> {
  DateFormat formattedDate = DateFormat('hh:mm');
  bool _isPresent = true;
  int _absentCount = 0;
  String _uid = "-";
  String _role = "-";

  void getCountAbsent() async {
    var data = await Provider.of<KelasProvider>(context, listen: false).getsAbsenStudents(widget.id);

    if(data == null) return;
    if (!mounted) return;
      setState(() {
        _absentCount = data.docs.where((element) => element["kehadiran"] == true).length;
      });

  }

  void getKehadiran(uid) async {
    var data = await Provider.of<KelasProvider>(context, listen: false).getsAbsenStudents(widget.id);
    if(data == null) return;
    if (!mounted) return;
      var santri = data.docs.where((element) => element["uid"] == uid).first.data() as Map<String, dynamic>;
      setState(() {
        _isPresent = santri["kehadiran"];
      });
  }

  @override
  void initState() {
    _role = Provider.of<ProfileProvider>(context, listen: false).profile.role;
    _uid = FirebaseAuth.instance.currentUser?.uid ?? "-";

    if(_role == "Pengajar") getCountAbsent();
    if(_role == "Santri") getKehadiran(_uid);


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                width: _isPresent ? 240.0 : 290.0,
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
                    if (_role == "Pengajar") {
                      Navigator.of(context).push(routeTransition(
                          AbsenDetailPage(dateTIme: widget.date, startAt: widget.startAt, endAt: widget.endAt, id: widget.id,)));
                    } else if (_role == "Santri") {
                      Provider.of<KelasProvider>(context, listen: false).absent(uid: _uid, id: widget.id);
                      getKehadiran(_uid);
                    }
                  },
                  child: AnimatedBuilder(
                      animation: Provider.of<KelasProvider>(context),
                      builder: (context, snapshot) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
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
                                    formattedDate.format(widget.startAt),
                                    style: TypographyStyle.button1,
                                  ),
                                  const SizedBox(width: SpacingDimens.spacing4),
                                  const Text(
                                    "-",
                                    style: TypographyStyle.button1,
                                  ),
                                  const SizedBox(width: SpacingDimens.spacing4),
                                  Text(
                                    formattedDate.format(widget.endAt),
                                    style: TypographyStyle.button1,
                                  ),
                                ],
                              ),
                            ),
                            if (_role != "Santri") Container(
                                    decoration: BoxDecoration(
                                        color: PaletteColor.grey40,
                                        borderRadius:
                                            BorderRadius.circular(4.0)),
                                    padding: const EdgeInsets.only(
                                      left: SpacingDimens.spacing8,
                                      right: SpacingDimens.spacing8,
                                      top: SpacingDimens.spacing4,
                                      bottom: SpacingDimens.spacing4,
                                    ),
                                    child: Row(
                                      children: [
                                        Text("$_absentCount",
                                            style: TypographyStyle.button2),
                                        const SizedBox(
                                            width: SpacingDimens.spacing4),
                                        const Icon(
                                          Icons.people,
                                          color: PaletteColor.grey,
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                  ) else AnimatedContainer(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.ease,
                                    width: _isPresent ? 70 : 112,
                                    height: _isPresent ? 26 : 26,
                                    decoration: BoxDecoration(
                                        color: _isPresent
                                            ? PaletteColor.primary
                                            : Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(4.0)),
                                    padding: const EdgeInsets.only(
                                      left: SpacingDimens.spacing8,
                                      right: SpacingDimens.spacing8,
                                      top: SpacingDimens.spacing4,
                                      bottom: SpacingDimens.spacing4,
                                    ),
                                    child: Stack(
                                      children: [
                                        AnimatedOpacity(
                                          duration: const Duration(
                                              milliseconds: 1000),
                                          opacity: _isPresent ? 0 : 1,
                                          child: Text(
                                            "Belum Present",
                                            style: TypographyStyle.button2
                                                .copyWith(
                                                    color:
                                                        PaletteColor.primarybg),
                                          ),
                                        ),
                                        AnimatedOpacity(
                                          duration: const Duration(
                                              milliseconds: 1000),
                                          opacity: _isPresent ? 1 : 0,
                                          child: Text(
                                            "Present",
                                            style: TypographyStyle.button2
                                                .copyWith(
                                              color: PaletteColor.primarybg,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        );
                      }),
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
