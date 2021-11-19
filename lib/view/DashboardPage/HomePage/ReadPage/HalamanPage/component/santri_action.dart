import 'dart:io';
import 'dart:typed_data';

import 'package:ajari/component/dialog/dialog_confirmation.dart';
import 'package:ajari/component/dialog/dialog_delete.dart';
import 'package:ajari/theme/costume_icons.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/view/DashboardPage/HomePage/ReadPage/component/message_dialog.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:record/record.dart';

import 'component.dart';

class SantriAction extends StatefulWidget {
  final String uid, grade, codeKelas, nomorJilid, nomorHalaman, role;

  const SantriAction({
    Key? key,
    required this.uid,
    required this.grade,
    required this.codeKelas,
    required this.nomorJilid,
    required this.nomorHalaman,
    required this.role,
  }) : super(key: key);

  @override
  State<SantriAction> createState() => _SantriActionState();
}

class _SantriActionState extends State<SantriAction> {
  final assetsAudioPlayerRecord = AssetsAudioPlayer();
  final Record _recorder = Record();

  bool _playRecord = true;
  bool _downloadAudio = false;
  bool permissionsGranted = false;
  bool isComplete = false;
  bool isNotStart = true;
  String? _path;


  @override
  void initState() {
    _setRecord();
    super.initState();
  }

  @override
  dispose() {
    assetsAudioPlayerRecord.dispose();
    _recorder.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
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
                        offset:
                            const Offset(0, 1), // changes position of shadow
                      ),
                    ]),
                padding: const EdgeInsets.all(SpacingDimens.spacing16),
                child: GestureDetector(
                  onTap: () {
                    if (_downloadAudio) {
                      showDialog(
                        context: context,
                        builder: (context) => DialogDelete(
                          content: "Ini akan menghapus record audio.",
                          onPressedFunction: () {},
                        ),
                      );
                    } else if (_path != null) {
                      _sendFile();
                      setState(() {
                        _downloadAudio = true;
                      });
                    }
                  },
                  child: Icon(
                    _downloadAudio
                        ? Icons.delete
                        : CostumeIcons.uploadCloudOutline,
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
                        offset:
                            const Offset(0, 1), // changes position of shadow
                      ),
                    ]),
                padding: const EdgeInsets.all(SpacingDimens.spacing16),
                child: InkWell(
                  onTap: () {
                    _startRecord();
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
                      Duration _duartion = snapshot.data?.audio.duration ??
                          const Duration(seconds: 0);
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

  void _setRecord() async {
    try {
      permissionsGranted = await checkPermission();

      final String filepath = await getFilePath() + 'record.m4a';

      String? path = await downloadFile(filepath, widget.nomorHalaman);

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

  void _sendFile() async {
    showDialog(
      context: context,
      builder: (_) {
        return DialogConfirmation(
          title: "Kirim Audio",
          content: "Ini akan mengirim record ke ustaz",
          onPressedFunction: () {
            _sendRecored(_path);
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Future<Uri?> _saveFile({filepath}) async {
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

  void _startRecord() async {
    try {
      if (permissionsGranted && isNotStart) {
        setState(() {
          isNotStart = false;
        });

        final String filepath = await getFilePath() + 'record.m4a';

        await _saveFile(filepath: filepath);
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

  void _sendRecored(filePath) async {
    try {
      File file = File(filePath);

      await FirebaseStorage.instance
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
      },
    );
  }
}
