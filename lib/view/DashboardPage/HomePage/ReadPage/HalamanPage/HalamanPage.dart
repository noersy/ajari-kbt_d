import 'dart:io';
import 'dart:typed_data';

import 'package:ajari/component/AppBar/AppBarBack.dart';
import 'package:ajari/component/Dialog/DialogConfirmation.dart';
import 'package:ajari/component/Dialog/DialogDelete.dart';
import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/theme/TypographyStyle.dart';
import 'package:ajari/theme/costume_icons.dart';
import 'package:ajari/view/DashboardPage/HomePage/ReadPage/component/MessageDialog.dart';
import 'package:ajari/view/DashboardPage/StudensPage/componen/NilaiDialog.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

class HalamanPage extends StatefulWidget {
  final String pathBacaan;
  final String pathAudio;
  final String nomorHalaman, nomorJilid, uid, codeKelas, role, grade;

   const HalamanPage({Key? key,
    required this.pathBacaan,
    required this.pathAudio,
    required this.nomorHalaman,
    required this.nomorJilid,
    required this.uid,
    required this.role,
    required this.grade,
    required this.codeKelas,
  }) : super(key: key);

  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<HalamanPage> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  final assetsAudioPlayerRecord = AssetsAudioPlayer();
  final Record _recorder = Record();

  String twoDigits(int n) => n.toString().padLeft(2, "0");

  bool permissionsGranted = false;
  bool isComplete = false;
  bool isNotStart = true;
  bool _play = true;
  bool _playRecord = true;
  bool _downloadAudio = false;
  String? _path;

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
    assetsAudioPlayerRecord.dispose();
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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: PaletteColor.grey60),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: StreamBuilder(
                    stream: assetsAudioPlayer.currentPosition,
                    builder: (context, AsyncSnapshot<Duration> snapshot) {
                      final _data = snapshot.data ?? const Duration(seconds: 0);
                      return Row(
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
                              child: Icon(
                                _play
                                    ? Icons.play_circle_fill
                                    : Icons.pause_circle_outline_outlined,
                              ),
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
                                    decoration: const BoxDecoration(
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Icon(
                                      Icons.pause_outlined,
                                      size: 14,
                                      color: PaletteColor.primarybg,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: SpacingDimens.spacing8,
                          ),
                        ],
                      );
                    }),
              ),
              const SizedBox(height: SpacingDimens.spacing12),
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
              const SizedBox(height: SpacingDimens.spacing8),
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
              widget.codeKelas != "-"
                  ? widget.role == "Santri"
                      ? _actionSantriContainer()
                      : _actionUstazContainer()
                  : _notJoinAction(),
              _actionPage(),
              // actionPage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionUstazContainer() {
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
                        offset: const Offset(0, 1), // changes position of shadow
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
                    padding: const EdgeInsets.all(SpacingDimens.spacing16),
                  ),
                  child: const Text(
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
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(SpacingDimens.spacing16),
                child: InkWell(
                  onTap: () {
                    _showdialog(false);
                  },
                  child: const Icon(Icons.insert_comment_outlined),
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
                        offset: const Offset(0, 1), // changes position of shadow
                      ),
                    ]),
                padding: const EdgeInsets.all(SpacingDimens.spacing16),
                child: InkWell(
                  onTap: () {
                    if (_path != null) {
                      _showdialog(true);
                    }
                  },
                  child: const Icon(Icons.play_arrow),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionSantriContainer() {
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
                    color: _path != null
                        ? PaletteColor.primary
                        : PaletteColor.primarybg,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: const Offset(0, 1), // changes position of shadow
                      ),
                    ]),
                padding: const EdgeInsets.all(SpacingDimens.spacing16),
                child: GestureDetector(
                  onTap: () {
                    if (_downloadAudio) {
                      showDialog(
                        context: context,
                        builder: (context) => DialogDelete(
                          content: "This will delete the recorded audio.",
                          onPressedFunction: () {},
                        ),
                      );
                    } else if(_path != null) {
                      sendFile();
                      setState(() {
                        _downloadAudio = true;
                      });
                    }
                  },
                  child: Icon(
                    _downloadAudio ? Icons.delete : CostumeIcons.upload_cloud_outline,
                    color: _path != null
                        ? PaletteColor.primarybg
                        : PaletteColor.grey80,
                  ),
                ),
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
                        offset: const Offset(0, 1), // changes position of shadow
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
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(SpacingDimens.spacing4),
                child: StreamBuilder(
                    stream: assetsAudioPlayerRecord.current,
                    builder: (context, AsyncSnapshot<Playing?> snapshot) {
                      Duration _duartion =
                          snapshot.data?.audio.duration ?? const Duration(seconds: 0);
                      return StreamBuilder(
                          stream: assetsAudioPlayerRecord.currentPosition,
                          builder: (context, AsyncSnapshot<Duration> snapshot) {
                            Duration _data =
                                snapshot.data ?? const Duration(seconds: 0);
                            String _time = "${twoDigits(
                              _duartion.inMinutes.remainder(60) -
                                  _data.inMinutes,
                            )}:${twoDigits(
                              _duartion.inSeconds.remainder(60) -
                                  _data.inSeconds,
                            )}";
                            return GestureDetector(
                              onTap: () {
                                if (_path != null) {
                                  setState(() {
                                    if (_playRecord) {
                                      assetsAudioPlayerRecord.play();
                                      _playRecord = false;
                                    } else {
                                      assetsAudioPlayerRecord.stop();
                                      _playRecord = true;
                                    }
                                  });
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: SpacingDimens.spacing4,
                                  right: SpacingDimens.spacing12,
                                ),
                                child: Row(
                                  children: [
                                    Icon(_playRecord
                                        ? Icons.play_arrow
                                        : Icons.pause),
                                    const SizedBox(
                                      width: SpacingDimens.spacing4,
                                    ),
                                    Text(
                                      _time,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    }),
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
                  offset: const Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            padding: const EdgeInsets.all(SpacingDimens.spacing16),
            child: InkWell(
              onTap: () {
                setState(() {
                  _playRecord = false;
                  _play = false;
                });
                _recorder.stop();
                assetsAudioPlayerRecord.stop();
                _showdialog(false);
              },
              child: const Icon(Icons.insert_comment_outlined),
            ),
          ),
        ],
      ),
    );
  }

  Widget _notJoinAction() {
    return const Padding(
      padding: EdgeInsets.only(
        top: SpacingDimens.spacing12,
        bottom: SpacingDimens.spacing8,
      ),
      child: Text("You not join class yet"),
    );
  }

  void _showdialog(isPlayed) {
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
            isPlayed: isPlayed,
          );
        });
  }

  Widget _actionPage() {
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
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(
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
                      padding: EdgeInsets.only(
                        left: SpacingDimens.spacing24,
                        right: SpacingDimens.spacing24,
                      ),
                      child: Text("1"),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
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
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(SpacingDimens.spacing4),
                child: Row(
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(SpacingDimens.spacing4),
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

  Future<bool> _checkPermission() async {
    Map<Permission, PermissionStatus> permissions = await [
      Permission.storage,
      Permission.microphone,
    ].request();

    return permissions[Permission.storage]!.isGranted &&
        permissions[Permission.microphone]!.isGranted;
  }

  void setRecord() async {
    try {
      permissionsGranted = await _checkPermission();

      final String filepath = await getFilePath() + 'record.m4a';

      String? path = await _downloadFileExample(filepath);

      if (path != null) {
        await assetsAudioPlayerRecord.open(Audio.file(path), autoStart: false);

        setState(() {
          _downloadAudio = true;
          _path = path;
        });
      }
    } catch (e) {
      // print("$e");
    }
  }

  Future<String> getFilePath() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String filePath = '$appDocPath/'; // 3

    Directory appFolder = Directory(appDocPath);
    bool appFolderExists = await appFolder.exists();
    if (!appFolderExists) {
      final created = await appFolder.create(recursive: true);
      if (kDebugMode) {
        print(created.path);
      }
    }

    return filePath;
  }

  void _sendRecored(filePath) async {
    try {
      File file = File(filePath);

      await firebase_storage.FirebaseStorage.instance
          .ref('uploads/audio_${widget.nomorHalaman}.m4a')
          .putFile(file);
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<String?> _downloadFileExample(filePath) async {
    File downloadToFile = File('$filePath');
    try {
      await firebase_storage.FirebaseStorage.instance
          .ref('uploads/audio_${widget.nomorHalaman}.m4a')
          .writeToFile(downloadToFile);
      return downloadToFile.path;
    } on FirebaseException catch (e) {
      return "Not found $e";
    }
  }

  void sendFile() async {
    showDialog(
      context: context,
      builder: (_) {
        return DialogConfirmation(
          title: "title",
          content: "content",
          onPressedFunction: () {
            _sendRecored(_path);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Future<Uri?> saveFile({filepath}) async {
    try {
      File file = File(filepath);
      Uint8List bytes = await file.readAsBytes();
      file.writeAsBytes(bytes);
      if (kDebugMode) {
        print(file.uri);
      }
      return file.uri;
    } catch (e, r) {
      if (kDebugMode) {
        print("$e $r");
      }
    }
    return null;
  }

  void startRecord() async {
    try {
      if (permissionsGranted && isNotStart) {
        setState(() {
          isNotStart = false;
        });

        final String filepath = await getFilePath() + 'record.m4a';

        await saveFile(filepath: filepath);
        await _recorder.start(path: filepath);
      } else {
        _path = await _recorder.stop();

        assetsAudioPlayerRecord.open(
          Audio.file(_path!),
          autoStart: false,
        );

        setState(() {
          isNotStart = true;
        });
      }
    } catch (e) {
      // print("$e");
    }
  }
}
