import 'package:ajari/model/profile.dart';
import 'package:ajari/providers/profile_providers.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:provider/provider.dart';

class MeetList extends StatefulWidget {
  final Map<String, dynamic> meet;
  final DateTime date;

  const MeetList({
    Key? key,
    required this.meet,
    required this.date,
  }) : super(key: key);

  @override
  State<MeetList> createState() => _MeetListState();
}

class _MeetListState extends State<MeetList> {
  @override
  Widget build(BuildContext context) {
    final Profile _profile = Provider.of<ProfileProvider>(context).profile;

    String _subject = widget.meet["subject"];
    String _serverURL = widget.meet["serverURL"];
    String _codeMeet = widget.meet["codeMeet"];

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: SpacingDimens.spacing12,
                left: SpacingDimens.spacing8,
              ),
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 40.0),
                    width: MediaQuery.of(context).size.width - 145,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: PaletteColor.primarybg,
                        elevation: 2,
                        padding: const EdgeInsets.all(SpacingDimens.spacing8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () => _joinMeeting(
                        profile: _profile,
                        codeRoom: _codeMeet,
                        urlServer: _serverURL,
                        subject: _subject,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(_subject, style: TypographyStyle.paragraph,),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: PaletteColor.primary,
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            padding: const EdgeInsets.only(
                              left: SpacingDimens.spacing8,
                              right: SpacingDimens.spacing8,
                              top: SpacingDimens.spacing4,
                              bottom: SpacingDimens.spacing4,
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "Gabung",
                                  style: TypographyStyle.button2.copyWith(color: PaletteColor.primarybg),
                                ),
                                const SizedBox(width: 2),
                                const Icon(Icons.meeting_room_outlined, size: 20,)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 20,
                        width: 3.5,
                        decoration: BoxDecoration(
                          color: PaletteColor.grey60,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.only(
                            left: SpacingDimens.spacing16 + 1.8),
                      ),
                      Container(
                        height: 8,
                        width: 8,
                        margin: const EdgeInsets.only(
                          top: 2,
                          bottom: 2,
                          left: SpacingDimens.spacing16 - 0.5,
                        ),
                        decoration: BoxDecoration(
                          color: PaletteColor.primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Container(
                        height: 20,
                        width: 3.5,
                        decoration: BoxDecoration(
                          color: PaletteColor.grey60,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        margin: const EdgeInsets.only(
                            left: SpacingDimens.spacing16 + 1.8),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
  }

  _joinMeeting({
    required subject,
    required urlServer,
    required codeRoom,
    required profile,
  }) async {
    try {
      var user = FirebaseAuth.instance.currentUser;

      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      featureFlag.meetingNameEnabled = true;
      featureFlag.resolution = FeatureFlagVideoResolution
          .MD_RESOLUTION; // Limit video resolution to 360p

      if (profile == "Santri") {
        featureFlag.addPeopleEnabled = false;
        featureFlag.kickOutEnabled = false;
      }

      var options = JitsiMeetingOptions(room: codeRoom)
        ..serverURL = urlServer
        ..subject = subject
        ..userDisplayName = user?.displayName ?? ""
        ..userEmail = user?.email ?? ""
        ..userAvatarURL = user?.photoURL ?? "" // or .png
        ..audioMuted = true
        ..videoMuted = true;

      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      debugPrint("error: $error");
    }
  }
}
