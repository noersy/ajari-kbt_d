import 'package:ajari/component/AppBar/AppBarBack.dart';
import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/theme/TypographyStyle.dart';
import 'package:ajari/view/DashboardPage/HomePage/ReadPage/component/MessageDialog.dart';
import 'package:ajari/view/DashboardPage/StudensPage/componen/NilaiDialog.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class HalamanPage extends StatefulWidget {
  final String pathBacaan;
  final String pathAudio;
  final String nomorHalaman, nomorJilid, uid, codeKelas, role;

  const HalamanPage({
    required this.pathBacaan,
    required this.pathAudio,
    required this.nomorHalaman,
    required this.nomorJilid,
    required this.uid,
    required this.role,
    required this.codeKelas,
  });

  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<HalamanPage> {
  final assetsAudioPlayer = AssetsAudioPlayer();

  bool isComplete = false;
  bool isStart = false;

  String twoDigits(int n) => n.toString().padLeft(2, "0");
  late String duration;

  bool _play = true;

  void setRecord() async {}

  @override
  initState() {
    setRecord();

    assetsAudioPlayer.open(
      Audio("assets/audio/jilid1/halaman1.mp3"),
      showNotification: true,
      autoStart: false,
    );
    super.initState();
  }

  @override
  dispose() {
    assetsAudioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColor.primarybg,
      appBar: AppBarBack(
        ctx: context,
        title: "Halaman ${widget.nomorHalaman}",
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: SpacingDimens.spacing16,
          right: SpacingDimens.spacing16,
        ),
        child: ListView(
          // physics: BouncingScrollPhysics(),
          children: [
            StreamBuilder(
              stream: assetsAudioPlayer.currentPosition,
              builder:
                  (BuildContext context, AsyncSnapshot<Duration> snapshot) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: PaletteColor.grey60),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (_play) {
                              assetsAudioPlayer.play();
                              _play = false;
                            } else {
                              assetsAudioPlayer.pause();
                              _play = true;
                            }
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              left: SpacingDimens.spacing4),
                          child: _play
                              ? Icon(Icons.play_circle_fill)
                              : Icon(Icons.pause_circle_outline_outlined),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${twoDigits(snapshot.data!.inMinutes.remainder(60))}:${twoDigits(snapshot.data!.inSeconds.remainder(60))}",
                          style: TypographyStyle.caption2,
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(7),
                              child: Container(
                                height: 2,
                                decoration: BoxDecoration(
                                  color: PaletteColor.grey80,
                                ),
                              ),
                            ),
                            Positioned(
                              left: snapshot.data!.inSeconds.toDouble(),
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                    color: PaletteColor.primary,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Icon(
                                  Icons.pause_outlined,
                                  size: 14,
                                  color: PaletteColor.primarybg,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: SpacingDimens.spacing8,
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: SpacingDimens.spacing12),
            Container(
              padding: const EdgeInsets.only(
                left: SpacingDimens.spacing16,
                right: SpacingDimens.spacing8,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: PaletteColor.grey),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Container(
                margin: const EdgeInsets.all(SpacingDimens.spacing4),
                padding: const EdgeInsets.all(SpacingDimens.spacing4),
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/iqro/bismilah.png',
                  height: 60,
                ),
              ),
            ),
            SizedBox(height: SpacingDimens.spacing8),
            Container(
              padding: const EdgeInsets.only(
                top: SpacingDimens.spacing16,
                left: SpacingDimens.spacing16,
                right: SpacingDimens.spacing8,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: PaletteColor.grey),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Container(
                margin: const EdgeInsets.all(SpacingDimens.spacing4),
                alignment: Alignment.center,
                child: Image.asset(
                  widget.pathBacaan,
                ),
              ),
            ),
            actionSantriContainer(),
            // actionPage(),
          ],
        ),
      ),
    );
  }

  Widget actionUstazContainer() {
    return Container(
      padding: const EdgeInsets.only(
        left: SpacingDimens.spacing16,
        right: SpacingDimens.spacing8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 100,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(
                  top: SpacingDimens.spacing8,
                  bottom: SpacingDimens.spacing16,
                ),
                decoration: BoxDecoration(
                    color: PaletteColor.primarybg,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ]),
                child: TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return NilaiDialog(
                          homePageCtx: context,
                          sheetDialogCtx: context,
                        );
                      },
                    );
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
                    padding: MaterialStateProperty.all(
                        EdgeInsets.all(SpacingDimens.spacing16)),
                  ),
                  child: Text(
                    "Nilai",
                    style: TypographyStyle.button1,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: SpacingDimens.spacing8,
                  bottom: SpacingDimens.spacing16,
                ),
                decoration: BoxDecoration(
                  color: PaletteColor.primarybg,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(SpacingDimens.spacing16),
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return MessageDialog(
                          uid: widget.uid,
                          role: widget.role,
                          codeKelas: widget.codeKelas,
                          homePageCtx: context,
                          sheetDialogCtx: context,
                          nomorJilid: widget.nomorJilid,
                          nomorHalaman: widget.nomorHalaman,
                        );
                      },
                    );
                  },
                  child: Icon(Icons.insert_comment_outlined),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: SpacingDimens.spacing8,
                  bottom: SpacingDimens.spacing16,
                  left: SpacingDimens.spacing12,
                ),
                decoration: BoxDecoration(
                    color: PaletteColor.primarybg,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ]),
                padding: const EdgeInsets.all(SpacingDimens.spacing16),
                child: InkWell(
                  onTap: () {
                    setState(
                      () {},
                    );
                  },
                  child: Icon(true ? Icons.play_arrow : Icons.pause),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget actionSantriContainer() {
    return Container(
      padding: const EdgeInsets.only(
        left: SpacingDimens.spacing16,
        right: SpacingDimens.spacing8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: SpacingDimens.spacing8,
                  bottom: SpacingDimens.spacing16,
                  right: SpacingDimens.spacing8,
                ),
                decoration: BoxDecoration(
                    color: PaletteColor.primarybg,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ]),
                padding: const EdgeInsets.all(SpacingDimens.spacing16),
                child: Icon(Icons.send),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: SpacingDimens.spacing8,
                  bottom: SpacingDimens.spacing16,
                ),
                decoration: BoxDecoration(
                    color: PaletteColor.primarybg,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ]),
                padding: const EdgeInsets.all(SpacingDimens.spacing16),
                child: InkWell(
                  onTap: () {
                    if (isStart) {
                    } else {}
                  },
                  child: Icon(isStart ? Icons.stop : Icons.mic),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: SpacingDimens.spacing8,
                  bottom: SpacingDimens.spacing16,
                  left: SpacingDimens.spacing8,
                ),
                decoration: BoxDecoration(
                  color: PaletteColor.primarybg,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(SpacingDimens.spacing4),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: SpacingDimens.spacing12,
                    right: SpacingDimens.spacing12,
                  ),
                  child: Text("00:00"),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(
              top: SpacingDimens.spacing8,
              bottom: SpacingDimens.spacing16,
            ),
            decoration: BoxDecoration(
              color: PaletteColor.primarybg,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            padding: const EdgeInsets.all(SpacingDimens.spacing16),
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return MessageDialog(
                      uid: widget.uid,
                      role: widget.role,
                      codeKelas: widget.codeKelas,
                      homePageCtx: context,
                      sheetDialogCtx: context,
                      nomorJilid: widget.nomorJilid,
                      nomorHalaman: widget.nomorHalaman,
                    );
                  },
                );
              },
              child: Icon(Icons.insert_comment_outlined),
            ),
          ),
        ],
      ),
    );
  }

  Widget actionPage() {
    return Container(
      padding: const EdgeInsets.only(
        left: SpacingDimens.spacing16,
        right: SpacingDimens.spacing8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(SpacingDimens.spacing4),
                margin: const EdgeInsets.only(
                    top: SpacingDimens.spacing8,
                    bottom: SpacingDimens.spacing16,
                    left: SpacingDimens.spacing8,
                    right: SpacingDimens.spacing16),
                decoration: BoxDecoration(
                  color: PaletteColor.primarybg,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: SpacingDimens.spacing8,
                        right: SpacingDimens.spacing8,
                      ),
                      child: Text(
                        "",
                        style:
                            TextStyle(color: PaletteColor.grey60, fontSize: 12),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: SpacingDimens.spacing24,
                        right: SpacingDimens.spacing24,
                      ),
                      child: Text("1"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: SpacingDimens.spacing8,
                        right: SpacingDimens.spacing8,
                      ),
                      child: Text(
                        "2",
                        style:
                            TextStyle(color: PaletteColor.grey60, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: SpacingDimens.spacing8,
                  bottom: SpacingDimens.spacing16,
                  left: SpacingDimens.spacing8,
                ),
                decoration: BoxDecoration(
                  color: PaletteColor.primarybg,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(SpacingDimens.spacing4),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(SpacingDimens.spacing4),
                      child: Icon(
                        Icons.arrow_forward,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<bool> checkPermission() async {
    Map<Permission, PermissionStatus> statuses =
        await [Permission.storage, Permission.microphone].request();

    print(statuses[Permission.location]);

    return statuses[Permission.microphone] == PermissionStatus.granted;
  }
}
