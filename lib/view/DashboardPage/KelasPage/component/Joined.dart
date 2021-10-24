import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/theme/TypographyStyle.dart';
import 'package:ajari/view/DashboardPage/KelasPage/RoomPage/RoomPage.dart';
import 'package:ajari/view/DashboardPage/KelasPage/component/component.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Joined extends StatelessWidget{
  final AsyncSnapshot<DocumentSnapshot> data;

  const Joined({required this.data});

  @override
  Widget build(BuildContext context) {
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
                          "${data.data!.get('nama')}",
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
                                "${data.data!.get('pengajar')}",
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
                                " ${data.data!.get('jumlah_santri')} Santri",
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
                            "${data.data!.get('kelas_id')}",
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
}
