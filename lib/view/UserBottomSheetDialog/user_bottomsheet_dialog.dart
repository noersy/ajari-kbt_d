import 'package:ajari/model/profile.dart';
import 'package:ajari/providers/profile_providers.dart';
import 'package:ajari/route/route_transisition.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:ajari/view/ProfilePage/profile_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'component/confirmation_logoutdialog.dart';

class UserBottomSheetDialog extends StatelessWidget {
  final BuildContext ctx;

  UserBottomSheetDialog({Key? key, required this.ctx}) : super(key: key);

  final User? _user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final Profile _profile = Provider.of<ProfileProvider>(context, listen: false).profile;

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Container(
          height: 280.0,
          padding: const EdgeInsets.symmetric(
            horizontal: SpacingDimens.spacing24,
            vertical: SpacingDimens.spacing16,
          ),
          color: PaletteColor.primarybg,
          child: Column(
            children: [
              Container(
                height: 5,
                width: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: PaletteColor.grey60,
                ),
              ),
              ProfileTile(user: _user, profile: _profile),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: PaletteColor.primarybg2,
                margin: const EdgeInsets.only(
                  top: SpacingDimens.spacing8,
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  primary: PaletteColor.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {

                },
                child: actionBottomSheet(
                  icon: Icons.help_outline,
                  title: "About",
                ),
              ),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: PaletteColor.primarybg2,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  primary: PaletteColor.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ConfirmationLogoutDialog(
                        homePageCtx: ctx,
                        sheetDialogCtx: context,
                      );
                    },
                  );
                },
                child: actionBottomSheet(
                  icon: Icons.logout,
                  title: "Logout",
                ),
              ),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: PaletteColor.primarybg2,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget actionBottomSheet({required IconData icon, required String title}) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: SpacingDimens.spacing16,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 25,
            color: PaletteColor.primary,
          ),
          const SizedBox(
            width: SpacingDimens.spacing24,
          ),
          Text(
            title,
            style: TypographyStyle.subtitle2,
          ),
        ],
      ),
    );
  }
}

class ProfileTile extends StatelessWidget {
  final User? user;
  final Profile profile;

  const ProfileTile({Key? key, required this.user, required this.profile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: SpacingDimens.spacing16,
        bottom: SpacingDimens.spacing8,
      ),
      child: ElevatedButton(
        onPressed: (){
          if (user != null) {
            Navigator.of(context).push(
              routeTransition(
                ProfilePage(
                  user: user!,
                  role: profile.role,
                ),
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          primary: PaletteColor.primarybg,
          onPrimary: PaletteColor.primary.withOpacity(0.5),
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          )
        ),
        child: Row(
          children: [
            SizedBox(
              height: 65.0,
              width: 65.0,
              child: CircleAvatar(
                backgroundColor: PaletteColor.grey40,
                backgroundImage: user != null
                    ? CachedNetworkImageProvider(user!.photoURL!)
                    : null,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: SpacingDimens.spacing24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.displayName ?? "",
                    style: TypographyStyle.subtitle2,
                  ),
                  const SizedBox(
                    height: SpacingDimens.spacing8,
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(SpacingDimens.spacing4),
                    decoration: BoxDecoration(
                      color: PaletteColor.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      profile.role,
                      style: TypographyStyle.subtitle2.merge(
                        const TextStyle(
                          color: PaletteColor.primarybg,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
