import 'dart:io';

import 'package:ajari/component/AppBar/AppBarBack.dart';
import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/theme/TypographyStyle.dart';
import 'package:ajari/view/DashboardPage/HomePage/ReadPage/component/MessageDialog.dart';
import 'package:ajari/view/DashboardPage/StudensPage/componen/NilaiDialog.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

class HalamanPage extends StatefulWidget {
  final String pathBacaan;
  final String pathAudio;
  final String nomorHalaman, nomorJilid, uid, codeKelas, role, grade;

  const HalamanPage({
    required this.pathBacaan,
    required this.pathAudio,
    required this.nomorHalaman,
    required this.nomorJilid,
    required this.uid,
    required this.role,
    required this.grade,
    required this.codeKelas,
  });

  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<HalamanPage> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  final Record _recorder = Record();

  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String appDocPath = '';

  bool permissionsGranted = false;
  bool isComplete = false;
  bool isNotStart = true;
  bool _play = true;
  String? path = " ";

  void setRecord() async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      appDocPath = appDocDir.path;

      Map<Permission, PermissionStatus> permissions = await [
        Permission.storage,
        Permission.microphone,
      ].request();

      permissionsGranted = permissions[Permission.storage]!.isGranted &&
          permissions[Permission.microphone]!.isGranted;
    } catch (e) {
      // print("$e");
    }
  }

  Future<void> uploadExample(filePath) async {
    try {
      File file = File(filePath);

      await firebase_storage.FirebaseStorage.instance
          .ref('uploads/audio_${widget.nomorHalaman}.m4a')
          .putFile(file);
    } on FirebaseException catch (e) {
      print(e);
    } catch (e){
      print(e);
    }
  }

  void startRecord() async {
    try {
      if (permissionsGranted && isNotStart) {
        print("start record");
        setState(() {
          isNotStart = false;
        });

        Directory appFolder = Directory(appDocPath);
        bool appFolderExists = await appFolder.exists();
        if (!appFolderExists) {
          final created = await appFolder.create(recursive: true);
          print(created.path);
        }

        final filepath = appDocPath +
            '/' +
            DateTime.now().millisecondsSinceEpoch.toString() +
            '.m4a';
        print(filepath);
        await _recorder.start(path: filepath);
      } else {
        path = await _recorder.stop();

        await uploadExample(path).whenComplete(() => {
              print("stop record : $path"),
            });

        setState(() {
          isNotStart = true;
        });
      }
    } catch (e) {
      // print("$e");
    }
  }

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
    _recorder.dispose();
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
                final _data = snapshot.data ?? Duration(seconds: 0);

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
                          "${twoDigits(_data.inMinutes.remainder(60))}:${twoDigits(_data.inSeconds.remainder(60))}",
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
                              left: _data.inSeconds.toDouble(),
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
            widget.role == 'Santri'
                ? actionSantriContainer()
                : actionUstazContainer(),
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
                          uid: widget.uid,
                          grade: widget.grade,
                          codeKelas: widget.codeKelas,
                          nomorJilid: widget.nomorJilid,
                          nomorHalaman: widget.nomorHalaman,
                        );
                      },
                    );
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    padding: EdgeInsets.all(SpacingDimens.spacing16),
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
                  onTap: () {},
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
                    startRecord();
                  },
                  child: Icon(!isNotStart ? Icons.stop : Icons.mic),
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
