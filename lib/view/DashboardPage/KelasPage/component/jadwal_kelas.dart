import 'package:ajari/providers/kelas_providers.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/view/DashboardPage/KelasPage/component/absent_cardlist.dart';
import 'package:ajari/view/DashboardPage/KelasPage/component/component.dart';
import 'package:ajari/view/DashboardPage/KelasPage/component/diskusi_cardlist.dart';
import 'package:ajari/view/DashboardPage/KelasPage/component/meet_cardlist.dart';
import 'package:flutter/material.dart';
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
    return AnimatedBuilder(
      animation: Provider.of<KelasProvider>(context),
      builder: (context, snapshot) {
        var _diskusi = Provider.of<KelasProvider>(context).listDiskusi;
        var _meet = Provider.of<KelasProvider>(context).listMeet;
        var _absen = Provider.of<KelasProvider>(context).listAbsen;

        return Expanded(
              child: Scaffold(
                floatingActionButton: null,
                body: Column(
                  children: [
                    _tanggal(_absen, _meet, _diskusi),
                    _jadwal(_absen, _meet, _diskusi),
                  ],
                ),
              ),
            );
      },
    );
  }

  bool _checkDataKelas(int index, {required List<Map<String, dynamic>> item}){
    return item.where((element) => element["datetime"].toDate().day == _listRealDate[index].day).isNotEmpty;
  }

  Widget _tanggal(
      List<Map<String, dynamic>> _absen,
      List<Map<String, dynamic>> _meet,
      List<Map<String, dynamic>> _diskusi,
      ) {
    return Container(
      height: 65,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(
        bottom: SpacingDimens.spacing4,
        left: SpacingDimens.spacing12,
        right: SpacingDimens.spacing12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for(int index=0; index < 7; index++)
            DateCard(
              dateTime: _listRealDate[index],
              hari: _listDay[index],
              tgl: _listDate[index],
              haveEvent: _checkDataKelas(index, item: _absen)
                  || _checkDataKelas(index, item: _meet)
                  || _checkDataKelas(index, item: _diskusi),
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
            ),
        ],
      ),
    );
  }


  bool _cekData(item, {required List<Map<String, dynamic>> list}){
    return list.where((element) => element["datetime"].toDate().day == item.day).isNotEmpty;
  }

  Widget _jadwal(_absen, _meet, _diskusi) {
    return Expanded(
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
            for (var item in _listRealDate) ...[
                  _cekData(item, list: _absen) ||
                  _cekData(item, list: _meet) ||
                  _cekData(item, list: _diskusi)
                  ? SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: SpacingDimens.spacing28),
                          for (var itemAbsen in _absen) ...[
                            if (item.day ==
                                itemAbsen['datetime'].toDate().day) ...[
                              AbsentList(
                                id: itemAbsen['id'],
                                date: itemAbsen['datetime'].toDate(),
                                startAt: itemAbsen['start_at'].toDate(),
                                endAt: itemAbsen['end_at'].toDate(),
                              ),
                            ],
                          ],
                          for (var itemMeet in _meet!) ...[
                            if (item.day == itemMeet['datetime'].toDate().day) ...[
                              MeetList(
                                  meet: itemMeet,
                                  date: itemMeet['datetime'].toDate(),
                              ),
                            ],
                          ],
                          for (var itemDiskusi in _diskusi!) ...[
                            if (item.day == itemDiskusi['datetime'].toDate().day) ...[
                              DiskusiList(
                                id: itemDiskusi['id'],
                                diskusi: itemDiskusi,
                                date: itemDiskusi['datetime'].toDate(),
                              ),
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
                              color: PaletteColor.grey60,
                              size: 30,
                          ),
                          SizedBox(width: SpacingDimens.spacing4),
                          Text(
                            "Tidak ada jadwal",
                            style: TextStyle(color: PaletteColor.grey60),
                          )
                        ],
                      ),
                    ),
            ],
          ],
        ),
      ),
    );
  }
}
