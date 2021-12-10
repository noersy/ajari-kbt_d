import 'dart:async';

import 'package:ajari/config/path_iqro.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'component.dart';

class AudioTop extends StatefulWidget {
  final String nomorHalaman, nomorJilid;

  const AudioTop(
      {Key? key, required this.nomorHalaman, required this.nomorJilid})
      : super(key: key);

  @override
  _AudioTopState createState() => _AudioTopState();
}

class _AudioTopState extends State<AudioTop> {
  final assetsAudioPlayer = AssetsAudioPlayer();

  bool isComplete = false;
  bool isNotStart = true;
  bool _play = true;

  void getAudio() async {
    try {
      var audioPath = PathIqro.mainAudioPath +
          "/jilid${widget.nomorJilid}" +
          "/halaman${widget.nomorHalaman}" +
          ".mp3";

      await rootBundle.load(audioPath);

      Audio _audio = Audio(audioPath);

      assetsAudioPlayer.open(
        _audio,
        showNotification: true,
        autoStart: false,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  initState() {
    getAudio();
    super.initState();
  }

  @override
  dispose() {
    assetsAudioPlayer.dispose();
    super.dispose();
  }

  Stream<List> mergedStream() {
    final s1 = assetsAudioPlayer.currentPosition;
    final s2 = assetsAudioPlayer.onReadyToPlay;
    return StreamZip([s1, s2]);
  }

  Duration _duration = const Duration(seconds: 0);
  Duration _duration2 = const Duration(seconds: 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: SpacingDimens.spacing8,
        left: SpacingDimens.spacing16,
        right: SpacingDimens.spacing16,
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
      child: FutureBuilder(
        future: assetsAudioPlayer.onReadyToPlay.first,
        builder: (BuildContext context, AsyncSnapshot<PlayingAudio?> snapshot) {
          _duration2 = snapshot.data?.duration ?? const Duration(seconds: 0);
          return StreamBuilder<Duration>(
            stream: assetsAudioPlayer.currentPosition,
            builder: (_, AsyncSnapshot<Duration> snapshot) {
              _duration = snapshot.data ?? const Duration(seconds: 0);
              String _time = "${twoDigits(_duration.inMinutes.remainder(60))}:${twoDigits(_duration.inSeconds.remainder(60))}";
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
                            borderRadius: BorderRadius.circular(50)),
                        padding: const EdgeInsets.all(0),
                        backgroundColor: PaletteColor.grey,
                      ),
                      onPressed: () {
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
                      child: Icon(
                        _play
                            ? Icons.play_arrow_outlined
                            : Icons.pause_outlined,
                        color: PaletteColor.primarybg,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _time,
                      style: TypographyStyle.subtitle2,
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      children: [
                        const SizedBox(height: 26),
                        Container(
                          height: 3,
                          margin: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 4),
                          decoration: BoxDecoration(
                            color: PaletteColor.grey60,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        AnimatedPositioned(
                          left: _play ? 0 : 218,
                          duration: _duration2,
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
