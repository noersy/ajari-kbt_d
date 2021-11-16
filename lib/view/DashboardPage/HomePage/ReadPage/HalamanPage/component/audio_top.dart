import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

import 'component.dart';

class AudioTop extends StatefulWidget {
  const AudioTop({Key? key}) : super(key: key);

  @override
  _AudioTopState createState() => _AudioTopState();
}

class _AudioTopState extends State<AudioTop> {
  final assetsAudioPlayer = AssetsAudioPlayer();

  bool isComplete = false;
  bool isNotStart = true;
  bool _play = true;

  @override
  initState() {
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
      child: StreamBuilder(
          stream: assetsAudioPlayer.currentPosition,
          builder: (context, AsyncSnapshot<Duration> snapshot) {
            final _data = snapshot.data ?? const Duration(seconds: 0);
            String _time =
                "${twoDigits(_data.inMinutes.remainder(60))}:${twoDigits(_data.inSeconds.remainder(60))}";

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
                      _play ? Icons.play_arrow_outlined : Icons.pause_outlined,
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
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        decoration: BoxDecoration(
                          color: PaletteColor.grey60,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Positioned(
                        left: _data.inSeconds.toDouble(),
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
          }),
    );
  }
}
