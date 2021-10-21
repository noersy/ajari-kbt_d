import 'package:ajari/component/AppBar/AppBarNotification.dart';
import 'package:ajari/component/Indicator/IndicatorLoad.dart';
import 'package:ajari/firebase/DataKelasProvider.dart';
import 'package:ajari/firebase/DataProfileProvider.dart';
import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/theme/TypographyStyle.dart';
import 'package:ajari/view/DashboardPage/KelasPage/RoomPage/RoomPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClassPage extends StatefulWidget {
  final User user;

  ClassPage({required this.user});

  @override
  _ClassPageState createState() => _ClassPageState();
}

class _ClassPageState extends State<ClassPage> {
  String code_kelas = '';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<DataProfileProvider>(context)
          .getProfile(userUid: widget.user.uid),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error initializing Firebase');
        } else if (snapshot.connectionState == ConnectionState.done) {
          this.code_kelas = snapshot.data!.get('code_kelas');
          return Scaffold(
            backgroundColor: PaletteColor.primarybg,
            appBar: AppBarNotification(
              ctx: context,
              title: 'Class',
            ),
            body: snapshot.data!.get('role') == "Santri"
                ? santriContainer()
                : pengajarContainer(),
          );
        }
        return Scaffold(
          backgroundColor: PaletteColor.primarybg,
          appBar: AppBarNotification(
            ctx: context,
            title: "Class",
          ),
          body: indicatorLoad(),
        );
      },
    );
  }

  Widget joinedContainer(AsyncSnapshot<DocumentSnapshot> kelas) {
    return Container(
      child: Column(
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
                          "${kelas.data!.get('nama')}",
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
                                "${kelas.data!.get('pengajar')}",
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
                                " ${kelas.data!.get('jumlah_santri')} Santri",
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
                            "${kelas.data!.get('kelas_id')}",
                            style: TypographyStyle.button1.merge(
                              TextStyle(
                                  fontSize: 12,
                                  color:
                                      PaletteColor.primarybg2.withOpacity(0.8),
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
          Container(
            margin: const EdgeInsets.only(
              top: SpacingDimens.spacing28,
              left: SpacingDimens.spacing16,
              right: SpacingDimens.spacing16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                dateCard(hari: "Sun", tgl: "12", color: PaletteColor.primary),
                dateCard(hari: "Mon", tgl: "13", color: PaletteColor.grey80),
                dateCard(hari: "Tue", tgl: "14", color: PaletteColor.grey80),
                dateCard(hari: "Wed", tgl: "15", color: PaletteColor.grey80),
                dateCard(hari: "Thu", tgl: "16", color: PaletteColor.grey80),
                dateCard(hari: "Sat", tgl: "17", color: PaletteColor.grey80),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: SpacingDimens.spacing28,
              left: SpacingDimens.spacing16,
            ),
            child: Row(
              children: [
                Stack(
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
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(0)),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RoomPage()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              style: TypographyStyle.button1.merge(
                                TextStyle(color: PaletteColor.primarybg),
                              ),
                            ),
                            Container(
                              height: 45,
                              width: 45,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color:
                                      PaletteColor.primarybg.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Text("0+", style: TypographyStyle.button1),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          height: 25,
                          width: 3.5,
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
                                  TextStyle(color: PaletteColor.primary),
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              ),
                              Text(
                                "WIB",
                                style: TypographyStyle.mini.merge(
                                  TextStyle(color: PaletteColor.primary),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 6,
                          width: 6,
                          margin: const EdgeInsets.only(
                              bottom: SpacingDimens.spacing8),
                          decoration: BoxDecoration(
                            color: PaletteColor.primary,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 3.5,
                          decoration: BoxDecoration(
                            color: PaletteColor.grey60,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ],
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

  Widget santriContainer() {
    return FutureBuilder(
      future: Provider.of<DataKelasProvider>(context)
          .getKelas(codeKelas: code_kelas),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (code_kelas == '') {
          return joinKelasContainer();
        } else if (snapshot.hasError) {
          return Center(child: Text('Error initializing Firebase'));
        } else if (snapshot.connectionState == ConnectionState.done) {
          return joinedContainer(snapshot);
        }
        return Scaffold(
          backgroundColor: PaletteColor.primarybg,
          body: indicatorLoad(),
        );
      },
    );
  }

  Widget pengajarContainer() {
    return FutureBuilder(
      future: Provider.of<DataKelasProvider>(context)
          .getKelas(codeKelas: code_kelas),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (code_kelas == '') {
          return createKContainer();
        } else if (snapshot.hasError) {
          return Text('Error initializing Firebase');
        } else if (snapshot.connectionState == ConnectionState.done) {
          return joinedContainer(snapshot);
        }
        return Scaffold(
          backgroundColor: PaletteColor.primarybg,
          body: indicatorLoad(),
        );
      },
    );
  }

  Widget createKContainer() {
    return Container(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: SpacingDimens.spacing12,
              right: SpacingDimens.spacing12,
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: SpacingDimens.spacing28,
                          bottom: SpacingDimens.spacing28),
                      child: Text("you not have class yet"),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: SpacingDimens.spacing24,
              right: SpacingDimens.spacing24,
              top: SpacingDimens.spacing8,
            ),
            child: Card(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: FlatButton(
                  color: PaletteColor.primary,
                  splashColor: PaletteColor.primary80,
                  height: 48,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.0),
                    side: BorderSide(
                      color: PaletteColor.green,
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return createKelas();
                      },
                    );
                  },
                  child: Text(
                    "Create",
                    style: TypographyStyle.button1.merge(
                      TextStyle(
                        color: PaletteColor.primarybg,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget joinKelasContainer() {
    TextEditingController santriInput = new TextEditingController();
    return Container(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: SpacingDimens.spacing12,
              right: SpacingDimens.spacing12,
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: SpacingDimens.spacing16,
                          top: SpacingDimens.spacing12,
                          bottom: SpacingDimens.spacing8),
                      child: Text("Not have class yet"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(SpacingDimens.spacing8),
                    child: TextFormField(
                      controller: santriInput,
                      decoration: InputDecoration(
                        labelText: "Codeclass",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(
              left: SpacingDimens.spacing24,
              right: SpacingDimens.spacing24,
              top: SpacingDimens.spacing8,
            ),
            child: Card(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: FlatButton(
                  color: PaletteColor.primary,
                  splashColor: PaletteColor.primary80,
                  height: 48,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.0),
                    side: BorderSide(
                      color: PaletteColor.green,
                    ),
                  ),
                  onPressed: () {
                    joinkelas(santriInput);
                    setState(() {
                      santriInput.value = TextEditingValue(text: santriInput.text);
                    });
                  },
                  child: Text(
                    "Join",
                    style: TypographyStyle.button1.merge(
                      TextStyle(
                        color: PaletteColor.primarybg,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void joinkelas(santriInput) async {
    code_kelas = await DataKelasProvider.joinKelas(
        codeKelas: santriInput.text, user: widget.user);
  }

  Widget createKelas() {
    return Container(
      decoration: BoxDecoration(
          color: PaletteColor.primarybg,
          borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.only(
        left: SpacingDimens.spacing28,
        right: SpacingDimens.spacing28,
        top: SpacingDimens.spacing36,
        bottom: SpacingDimens.spacing36,
      ),
      child: Scaffold(
        backgroundColor: PaletteColor.primarybg.withOpacity(0),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: SpacingDimens.spacing28,
                bottom: SpacingDimens.spacing8,
              ),
              child: Text(
                'Create New Class',
                style: TypographyStyle.subtitle2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(SpacingDimens.spacing16),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Name'),
              ),
            ),
            Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.only(
                left: SpacingDimens.spacing16,
                right: SpacingDimens.spacing16,
              ),
              child: FlatButton(
                color: PaletteColor.primary,
                splashColor: PaletteColor.primary80,
                height: 48,
                minWidth: MediaQuery.of(context).size.width,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.0),
                  side: BorderSide(
                    color: PaletteColor.green,
                  ),
                ),
                onPressed: () {
                  DataKelasProvider.createKelas(
                      namaKelas: 'nama', user: widget.user);
                },
                child: Text(
                  "Create",
                  style: TypographyStyle.button1.merge(
                    TextStyle(
                      color: PaletteColor.primarybg,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: SpacingDimens.spacing16,
            ),
          ],
        ),
      ),
    );
  }
}

Widget dateCard({hari, tgl, color}) {
  return Container(
    child: Column(
      children: [
        Text(
          hari,
          style: TextStyle(color: color),
        ),
        Text(tgl, style: TextStyle(color: color)),
        SizedBox(height: SpacingDimens.spacing4),
        Container(
          height: 2,
          width: 20,
          decoration: BoxDecoration(
            color: color,
          ),
        ),
      ],
    ),
  );
}
