import 'package:ajari/config/globals.dart' as globals;
import 'package:ajari/model/Kelas.dart';
import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/theme/TypographyStyle.dart';
import 'package:ajari/view/DashboardPage/KelasPage/component/JoinKelas.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'RoomPage/RoomPage.dart';
import 'component/component.dart';

class ClassPage extends StatefulWidget {
  const ClassPage();

  @override
  _ClassPageState createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  late PageController _pageController;
  List<String> _listDay = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  List<String> _listDate = [];
  DateTime _dateTime = DateTime.now();
  int _index = 0;
  int _indexCurret = 0;
  late Kelas _kelas;

  void freshState({required Kelas value}) {
    setState(() {
      _kelas = value;
    });
  }

  @override
  void initState() {
    var weekDay = _dateTime.weekday;

    for (int i = 0; i <= 7; i++) {
      int _date = _dateTime.subtract(Duration(days: weekDay - i)).day;
      _listDate.add(_date.toString());

      if (_dateTime.day == _date) {
        _index = i;
        _indexCurret = i;
        _pageController = new PageController(initialPage: i);
      }
    }

    if (globals.kelas != null) _kelas = globals.kelas!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PaletteColor.primarybg,
        elevation: 0,
        title: Text(
          "Class",
          style: TypographyStyle.subtitle1,
        ),
      ),
      body: _kelas.kelasId == "-"
          ? JoinKelas(
              freshState: freshState,
            )
          : Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(
                    SpacingDimens.spacing12,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
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
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: SpacingDimens.spacing16,
                                top: SpacingDimens.spacing12,
                                bottom: SpacingDimens.spacing8,
                              ),
                              child: Text(
                                "${_kelas.nama}",
                                style: TypographyStyle.title.merge(
                                  TextStyle(
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
                                    Icon(
                                      Icons.person,
                                      color: PaletteColor.primarybg2,
                                    ),
                                    Text(
                                      "${_kelas.pengajar}",
                                      style: TypographyStyle.button1.merge(
                                        TextStyle(
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
                                    Icon(
                                      Icons.people,
                                      size: 18,
                                      color: PaletteColor.primarybg2,
                                    ),
                                    Text(
                                      " ${_kelas.jumlahSantri} Santri",
                                      style: TypographyStyle.button1.merge(
                                        TextStyle(
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
                                  "${_kelas.kelasId}",
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
                      return dateCard(
                        hari: _listDay[index],
                        tgl: "${_listDate[index]}",
                        color: _index != index
                            ? _indexCurret != index
                                ? PaletteColor.grey80
                                : PaletteColor.primary.withOpacity(0.6)
                            : PaletteColor.primary,
                        onTap: () {
                          print(index);
                          setState(() {
                            _index = index;
                            _pageController.animateToPage(
                              index,
                              duration: Duration(milliseconds: 500),
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
                      controller: _pageController,
                      children: [
                        ListView(
                          physics: BouncingScrollPhysics(),
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
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          padding: const EdgeInsets.all(0)),
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RoomPage()));
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
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
                                              TextStyle(
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
                                            child: Text("0+",
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
                                                TextStyle(
                                                    color:
                                                        PaletteColor.primary),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              "WIB",
                                              style: TypographyStyle.mini.merge(
                                                TextStyle(
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
                        Center(child: Text("2")),
                        Center(child: Text("3")),
                        Center(child: Text("4")),
                        Center(child: Text("5")),
                        Center(child: Text("6")),
                        Center(child: Text("7"))
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
