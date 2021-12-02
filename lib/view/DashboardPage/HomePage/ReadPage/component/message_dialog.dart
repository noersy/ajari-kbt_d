import 'dart:io';

import 'package:ajari/component/dialog/dialog_failed.dart';
import 'package:ajari/config/path_iqro.dart';
import 'package:ajari/providers/kelas_providers.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class MessageDialog extends StatefulWidget {
  final BuildContext homePageCtx, sheetDialogCtx;
  final String nomorJilid, nomorHalaman, uid, codeKelas, role;
  final bool isPlayed;

  const MessageDialog({
    Key? key,
    required this.homePageCtx,
    required this.sheetDialogCtx,
    required this.nomorJilid,
    required this.nomorHalaman,
    required this.uid,
    required this.codeKelas,
    required this.role,
    required this.isPlayed,
  }) : super(key: key);

  @override
  State<MessageDialog> createState() => _MessageDialogState();
}

class _MessageDialogState extends State<MessageDialog> {
  @override
  Widget build(BuildContext context) {
    return widget.codeKelas != "-"
        ? contentBox(context)
        : DialogFailed(
            content: "You not join class yet",
            onPressedFunction: () {
              Navigator.of(context).pop();
            },
          );
  }

  final TextEditingController _editingController = TextEditingController();

  late DateTime _dateTime;

  bool _first = true;

  contentBox(context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      content: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Halaman ' + widget.nomorHalaman,
                            style: TypographyStyle.subtitle1.merge(
                              const TextStyle(
                                color: PaletteColor.black,
                              ),
                            ),
                          ),
                        ),
                        const Divider(),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          PlayerAudioDown(
                            nomorJilid: widget.nomorJilid,
                            nomorHalaman: widget.nomorHalaman,
                            uid: widget.uid,
                            codeKelas: widget.codeKelas,
                            role: widget.role,
                            isPlayed: widget.isPlayed,
                          ),
                          const SizedBox(height: 22),
                          _message(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: PaletteColor.primary,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, -2),
                        color: PaletteColor.grey80.withOpacity(0.05),
                        spreadRadius: 3)
                  ]),
              child: Padding(
                padding: const EdgeInsets.all(SpacingDimens.spacing8),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: PaletteColor.primarybg,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                offset: const Offset(0, 1),
                                color: PaletteColor.grey.withOpacity(0.1),
                                spreadRadius: 1.5)
                          ],
                        ),
                        child: TextFormField(
                          controller: _editingController,
                          decoration: const InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: SpacingDimens.spacing8,
                              vertical: SpacingDimens.spacing8,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: SpacingDimens.spacing8,
                    ),
                    SizedBox(
                      width: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(0),
                          primary: PaletteColor.primarybg,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                        onPressed: () {
                          if (_editingController.text.isEmpty) return;

                          Provider.of<KelasProvider>(context, listen: false)
                              .sendMessage(
                            uid: widget.uid,
                            codeKelas: widget.codeKelas,
                            nomorJilid: widget.nomorJilid,
                            nomorHalaman: widget.nomorHalaman,
                            message: _editingController.text,
                            role: widget.role,
                          );
                          _editingController.clear();
                        },
                        child: const Icon(
                          Icons.send,
                          color: PaletteColor.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _message() {
    return StreamBuilder<QuerySnapshot>(
      stream: Provider.of<KelasProvider>(context).getMassage(
          uid: widget.uid,
          codeKelas: widget.codeKelas,
          nomorJilid: widget.nomorJilid,
          nomorHalaman: widget.nomorHalaman),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: Text("Tidak ada pesan."));
        }
        if (snapshot.data!.docChanges.isEmpty) {
          return const Center(child: Text("Tidak ada pesan."));
        }
        return Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: snapshot.data!.docs.map((e) {
              String _role = e.get('role');
              DateTime date = e.get('dateTime').toDate();
              DateTime dateTime = DateTime(date.year, date.month, date.day);
              if (_first) {
                _dateTime = DateTime(date.year, date.month, date.day);
                _first = false;
              }
              if (_dateTime != dateTime) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: Center(
                          child: Text(
                        DateFormat('yyyy-MM-dd').format(dateTime),
                        style: TypographyStyle.mini,
                      )),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: SpacingDimens.spacing16,
                        right: SpacingDimens.spacing16,
                        bottom: SpacingDimens.spacing8,
                      ),
                      alignment: _role == widget.role
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        padding: const EdgeInsets.all(SpacingDimens.spacing4),
                        decoration: BoxDecoration(
                            color: _role == widget.role
                                ? PaletteColor.primary.withOpacity(0.5)
                                : PaletteColor.grey60.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(5)),
                        child: Stack(
                          alignment: _role == widget.role
                              ? Alignment.bottomRight
                              : Alignment.bottomLeft,
                          children: [
                            Container(
                              height: 20,
                              padding: _role == widget.role
                                  ? const EdgeInsets.only(right: 40, left: 4)
                                  : const EdgeInsets.only(left: 40, right: 4),
                              child: Text(e.get('message')),
                            ),
                            Container(
                              alignment: _role == widget.role
                                  ? Alignment.bottomRight
                                  : Alignment.bottomLeft,
                              height: 20,
                              width: 50,
                              child: Text(
                                DateFormat('kk:mm')
                                    .format(e.get('dateTime').toDate()),
                                style: TypographyStyle.mini,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              }
              _dateTime = DateTime(date.year, date.month, date.day);
              return Column(
                children: [
                  _first
                      ? Padding(
                          padding: const EdgeInsets.all(2),
                          child: Center(
                              child: Text(
                            DateFormat('yyyy-MM-dd').format(dateTime),
                            style: TypographyStyle.mini,
                          )),
                        )
                      : const SizedBox.shrink(),
                  Container(
                    margin: const EdgeInsets.only(
                      left: SpacingDimens.spacing16,
                      right: SpacingDimens.spacing16,
                      bottom: SpacingDimens.spacing8,
                    ),
                    alignment: _role == widget.role
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(SpacingDimens.spacing4),
                      decoration: BoxDecoration(
                          color: _role == widget.role
                              ? PaletteColor.primary.withOpacity(0.5)
                              : PaletteColor.grey60.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5)),
                      child: Stack(
                        alignment: _role == widget.role
                            ? Alignment.bottomRight
                            : Alignment.bottomLeft,
                        children: [
                          Container(
                            height: 20,
                            padding: _role == widget.role
                                ? const EdgeInsets.only(right: 40, left: 4)
                                : const EdgeInsets.only(left: 40, right: 4),
                            child: Text(e.get('message')),
                          ),
                          Container(
                            alignment: _role == widget.role
                                ? Alignment.bottomRight
                                : Alignment.bottomLeft,
                            height: 20,
                            width: 50,
                            child: Text(
                              DateFormat('kk:mm')
                                  .format(e.get('dateTime').toDate()),
                              style: TypographyStyle.mini,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class PlayerAudioDown extends StatefulWidget {
  final String nomorJilid, nomorHalaman, uid, codeKelas, role;
  final bool isPlayed;

  const PlayerAudioDown({
    Key? key,
    required this.nomorJilid,
    required this.nomorHalaman,
    required this.uid,
    required this.codeKelas,
    required this.role,
    required this.isPlayed,
  }) : super(key: key);

  @override
  _PlayerAudioDownState createState() => _PlayerAudioDownState();
}

class _PlayerAudioDownState extends State<PlayerAudioDown> {
  final _assetsAudioPlayerRecord = AssetsAudioPlayer();

  String twoDigits(int n) => n.toString().padLeft(2, "0");

  bool _play = false;

  Future<String> _getFilePath() async {
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

  Future<bool> _checkPermission() async {
    Map<Permission, PermissionStatus> permissions = await [
      Permission.storage,
      Permission.microphone,
    ].request();

    return permissions[Permission.storage]!.isGranted &&
        permissions[Permission.microphone]!.isGranted;
  }

  void _downloadFileE() async {
    try {
      await _checkPermission();

      File downloadToFile = File(RecordFile.recordFile(
              nomorJilid: widget.nomorJilid,
              nomorHalaman: widget.nomorHalaman) +
          'record.m4a');

      String url = await firebase_storage.FirebaseStorage.instance
          .ref(
            RecordFile.recordFile(
                    nomorJilid: widget.nomorJilid,
                    nomorHalaman: widget.nomorHalaman) +
                'record.m4a',
          )
          .getDownloadURL();

      await _assetsAudioPlayerRecord.open(
        Audio.network(url),
        showNotification: true,
        autoStart: false,
      );

      if (widget.isPlayed) {
        _assetsAudioPlayerRecord.play();
        _play = true;
      }

      if (kDebugMode) {
        print("Open : " + downloadToFile.path);
      }
      return;
    } on FirebaseException catch (e) {
      if (kDebugMode) {
        print("$e");
      }
      return;
    }
  }

  @override
  void initState() {
    _downloadFileE();
    super.initState();
  }

  @override
  void dispose() {
    _assetsAudioPlayerRecord.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: PaletteColor.grey60),
        borderRadius: BorderRadius.circular(10),
      ),
      child: FutureBuilder<PlayingAudio?>(
        future: _assetsAudioPlayerRecord.onReadyToPlay.first,
        builder: (context, snapshot) {
          final _duartion =
              snapshot.data?.duration ?? const Duration(seconds: 0);
          return StreamBuilder<Duration>(
            stream: _assetsAudioPlayerRecord.currentPosition,
            builder: (context, AsyncSnapshot<Duration> snapshot) {
              Duration _duartion2 = snapshot.data ?? const Duration(seconds: 0);
              String _time = "${twoDigits(
                _duartion2.inMinutes.remainder(60),
              )}:${twoDigits(_duartion2.inSeconds.remainder(60))}";
              return Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: SpacingDimens.spacing4,
                      bottom: SpacingDimens.spacing4,
                      left: SpacingDimens.spacing8,
                      right: SpacingDimens.spacing4,
                    ),
                    width: 34,
                    height: 34,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: const EdgeInsets.all(0),
                        backgroundColor: PaletteColor.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          if (!_play) {
                            _assetsAudioPlayerRecord.play();
                            _play = true;
                          } else {
                            _assetsAudioPlayerRecord.pause();
                            _play = false;
                          }
                        });
                      },
                      child: Icon(
                        _play
                            ? Icons.pause_outlined
                            : Icons.play_arrow_outlined,
                        color: PaletteColor.primarybg,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _time,
                      style: TypographyStyle.caption2,
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(7),
                          child: Container(
                            height: 3,
                            margin: const EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              color: PaletteColor.grey60,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        AnimatedPositioned(
                          top: 7,
                          left: _play ? 155 : 0,
                          duration: _duartion,
                          child: Container(
                            width: 26,
                            height: 26,
                            margin: const EdgeInsets.symmetric(vertical: 3),
                            decoration: BoxDecoration(
                              color: PaletteColor.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.pause_outlined,
                              size: 18,
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
            },
          );
        },
      ),
    );
  }
}
