import 'dart:io';

import 'package:ajari/component/Dialog/DialogFailed.dart';
import 'package:ajari/firebase/DataKelasProvider.dart';
import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/theme/TypographyStyle.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class MessageDialog extends StatefulWidget {
  final BuildContext homePageCtx, sheetDialogCtx;
  final String nomorJilid, nomorHalaman, uid, codeKelas, role;
  final bool isPlayed;

  MessageDialog({
    required this.homePageCtx,
    required this.sheetDialogCtx,
    required this.nomorJilid,
    required this.nomorHalaman,
    required this.uid,
    required this.codeKelas,
    required this.role,
    required this.isPlayed,
  });

  @override
  State<MessageDialog> createState() => _MessageDialogState();
}

class _MessageDialogState extends State<MessageDialog> {
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
      print(created.path);
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

  void _downloadFileExample() async {
    try {
      print(await _checkPermission());

      File downloadToFile =
          File('${_getFilePath()}audio_${widget.nomorHalaman}.m4a');

      String url = await firebase_storage.FirebaseStorage.instance
          .ref('uploads/audio_${widget.nomorHalaman}.m4a')
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

      print("Open : " + downloadToFile.path);
      return;
    } on FirebaseException catch (e) {
      print("$e");
      return;
    } catch (e) {
      print("$e");
    }
  }

  @override
  void initState() {
    _downloadFileExample();
    super.initState();
  }

  @override
  void dispose() {
    _assetsAudioPlayerRecord.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.codeKelas != "-"
        ? Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                8.0,
              ),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: contentBox(context),
          )
        : DialogFailed(
            content: "You not join class yet",
            onPressedFunction: () {
              Navigator.of(context).pop();
            },
          );
  }

  TextEditingController _editingController = new TextEditingController();

  late DateTime _dateTime;

  bool _first = true;

  contentBox(context) {
    return Container(
      height: MediaQuery.of(context).size.height - 200,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: PaletteColor.primarybg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Halaman ' + widget.nomorHalaman,
                        style: TypographyStyle.subtitle1.merge(
                          TextStyle(
                            color: PaletteColor.black,
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: PaletteColor.grey60),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: StreamBuilder<Playing?>(
                              stream: _assetsAudioPlayerRecord.current,
                              builder: (context, snapshot) {
                                final _duartion =
                                    snapshot.data?.audio.duration ??
                                        Duration(seconds: 0);
                                return StreamBuilder<Duration>(
                                    stream: _assetsAudioPlayerRecord
                                        .currentPosition,
                                    builder: (context,
                                        AsyncSnapshot<Duration> snapshot) {
                                      Duration _data =
                                          snapshot.data ?? Duration(seconds: 0);
                                      String _time = "${twoDigits(
                                        _duartion.inMinutes.remainder(60) -
                                            _data.inMinutes,
                                      )}:${twoDigits(
                                        _duartion.inSeconds.remainder(60) -
                                            _data.inSeconds,
                                      )}";
                                      return Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (!_play) {
                                                  _assetsAudioPlayerRecord
                                                      .play();
                                                  _play = true;
                                                } else {
                                                  _assetsAudioPlayerRecord
                                                      .pause();
                                                  _play = false;
                                                }
                                              });
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  left: SpacingDimens.spacing4),
                                              child: Icon(
                                                !_play
                                                    ? Icons.play_circle_fill
                                                    : Icons
                                                        .pause_circle_outline_outlined,
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
                                                  padding:
                                                      const EdgeInsets.all(7),
                                                  child: Container(
                                                    height: 2,
                                                    decoration: BoxDecoration(
                                                      color:
                                                          PaletteColor.grey80,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: _data.inSeconds
                                                      .toDouble(),
                                                  child: Container(
                                                    width: 16,
                                                    height: 16,
                                                    decoration: BoxDecoration(
                                                        color: PaletteColor
                                                            .primary,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Icon(
                                                      Icons.pause_outlined,
                                                      size: 14,
                                                      color: PaletteColor
                                                          .primarybg,
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
                                      );
                                    });
                              }),
                        ),
                      ),
                      SizedBox(height: 22),
                      StreamBuilder<QuerySnapshot>(
                        stream: Provider.of<DataKelasProvider>(context)
                            .getMassage(
                                uid: widget.uid,
                                codeKelas: widget.codeKelas,
                                nomorJilid: widget.nomorJilid,
                                nomorHalaman: widget.nomorHalaman),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return Center(child: Text("Tidak ada pesan."));
                          if (snapshot.data!.docChanges.length == 0)
                            return Center(child: Text("Tidak ada pesan."));
                          return Expanded(
                            child: ListView(
                              physics: BouncingScrollPhysics(),
                              children: snapshot.data!.docs.map((e) {
                                String _role = e.get('role');
                                DateTime date = e.get('dateTime').toDate();
                                DateTime dateTime =
                                    DateTime(date.year, date.month, date.day);
                                if (_first) {
                                  _dateTime =
                                      DateTime(date.year, date.month, date.day);
                                  _first = false;
                                }
                                if (_dateTime != dateTime) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Center(
                                            child: Text(
                                          DateFormat('yyyy-MM-dd')
                                              .format(dateTime),
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
                                          padding: const EdgeInsets.all(
                                              SpacingDimens.spacing4),
                                          decoration: BoxDecoration(
                                              color: _role == widget.role
                                                  ? PaletteColor.primary
                                                      .withOpacity(0.5)
                                                  : PaletteColor.grey60
                                                      .withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: Stack(
                                            alignment: _role == widget.role
                                                ? Alignment.bottomRight
                                                : Alignment.bottomLeft,
                                            children: [
                                              Container(
                                                height: 20,
                                                padding: _role == widget.role
                                                    ? const EdgeInsets.only(
                                                        right: 40, left: 4)
                                                    : const EdgeInsets.only(
                                                        left: 40, right: 4),
                                                child: Text(e.get('message')),
                                              ),
                                              Container(
                                                alignment: _role == widget.role
                                                    ? Alignment.bottomRight
                                                    : Alignment.bottomLeft,
                                                height: 20,
                                                width: 50,
                                                child: Text(
                                                  DateFormat('kk:mm').format(e
                                                      .get('dateTime')
                                                      .toDate()),
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
                                _dateTime =
                                    DateTime(date.year, date.month, date.day);
                                return Column(
                                  children: [
                                    _first
                                        ? Padding(
                                            padding: const EdgeInsets.all(2),
                                            child: Center(
                                                child: Text(
                                              DateFormat('yyyy-MM-dd')
                                                  .format(dateTime),
                                              style: TypographyStyle.mini,
                                            )),
                                          )
                                        : SizedBox.shrink(),
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
                                        padding: const EdgeInsets.all(
                                            SpacingDimens.spacing4),
                                        decoration: BoxDecoration(
                                            color: _role == widget.role
                                                ? PaletteColor.primary
                                                    .withOpacity(0.5)
                                                : PaletteColor.grey60
                                                    .withOpacity(0.5),
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Stack(
                                          alignment: _role == widget.role
                                              ? Alignment.bottomRight
                                              : Alignment.bottomLeft,
                                          children: [
                                            Container(
                                              height: 20,
                                              padding: _role == widget.role
                                                  ? const EdgeInsets.only(
                                                      right: 40, left: 4)
                                                  : const EdgeInsets.only(
                                                      left: 40, right: 4),
                                              child: Text(e.get('message')),
                                            ),
                                            Container(
                                              alignment: _role == widget.role
                                                  ? Alignment.bottomRight
                                                  : Alignment.bottomLeft,
                                              height: 20,
                                              width: 50,
                                              child: Text(
                                                DateFormat('kk:mm').format(
                                                    e.get('dateTime').toDate()),
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: PaletteColor.primary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                bottomLeft: Radius.circular(2),
                bottomRight: Radius.circular(2),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(SpacingDimens.spacing8),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: PaletteColor.primarybg,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        controller: _editingController,
                        decoration: InputDecoration(
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
                  SizedBox(
                    width: SpacingDimens.spacing8,
                  ),
                  SizedBox(
                    width: 50,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          padding: const EdgeInsets.all(0)),
                      onPressed: () {
                        if (_editingController.text.isEmpty) return;

                        DataKelasProvider.sendMessage(
                          uid: widget.uid,
                          codeKelas: widget.codeKelas,
                          nomorJilid: widget.nomorJilid,
                          nomorHalaman: widget.nomorHalaman,
                          message: _editingController.text,
                          role: widget.role,
                        );
                        _editingController.clear();
                      },
                      child: Icon(
                        Icons.send,
                        color: PaletteColor.primarybg,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
