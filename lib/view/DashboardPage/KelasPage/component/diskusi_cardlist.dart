import 'package:ajari/model/profile.dart';
import 'package:ajari/providers/profile_providers.dart';
import 'package:ajari/route/route_transisition.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:ajari/view/DashboardPage/KelasPage/DiskusiPage/diskusi_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:provider/provider.dart';

class DiskusiList extends StatefulWidget {
  final DocumentReference<Object?> diskusi;
  final DateTime date;
  final String id;

  const DiskusiList({
    Key? key,
    required this.diskusi,
    required this.date, required this.id,
  }) : super(key: key);

  @override
  State<DiskusiList> createState() => _DiskusiListState();
}

class _DiskusiListState extends State<DiskusiList> {
  @override
  Widget build(BuildContext context) {

    return FutureBuilder<DocumentSnapshot>(
      future: widget.diskusi.get(),
      builder: (context, snapshot) {
        String _subject = snapshot.data?.get("subject") ?? "-";

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
                      onPressed: (){
                        Navigator.of(context).push(routeTransition(DiskusiPage(subject: _subject, id: widget.id)));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  _subject,
                                  style: TypographyStyle.paragraph,
                                ),
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
                                const Icon(Icons.chat, size: 18)
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
                            left: SpacingDimens.spacing16 + 1.8,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      },
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
