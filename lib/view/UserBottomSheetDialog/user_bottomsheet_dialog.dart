import 'package:ajari/model/profile.dart';
import 'package:ajari/providers/profile_providers.dart';
import 'package:ajari/route/route_transisition.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:ajari/view/ProfilePage/profile_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'component/confirmation_logoutdialog.dart';

class UserBottomSheetDialog extends StatelessWidget {
  final BuildContext ctx;

  const UserBottomSheetDialog({Key? key, required this.ctx}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Profile _profile =
        Provider.of<ProfileProvider>(context, listen: false).profile;

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Container(
          height: 260.0,
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
              ProfileTile(profile: _profile),
              _actionBottomSheet(
                onPressed: () {
                  getPecageInfo(context);
                },
                icon: Icons.help_outline,
                title: "About",
              ),
              Container(
                height: 1.5,
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                    color: PaletteColor.grey40.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(10.0)),
              ),
              _actionBottomSheet(
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
                icon: Icons.logout,
                title: "Logout",
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _actionBottomSheet(
      {required IconData icon,
      required String title,
      required Function() onPressed}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: PaletteColor.primarybg,
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          primary: PaletteColor.primary,
          padding: const EdgeInsets.all(12.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: onPressed,
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
      ),
    );
  }

  void getPecageInfo(context) async {
    // PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // String _appName = packageInfo.appName;
    // String _packageName = packageInfo.packageName;
    // String _version = packageInfo.version;
    // String _buildNumber = packageInfo.buildNumber;

    showAboutDialog(
      context: context,
      applicationName: "Ajari",
      applicationVersion: "1.2.1",
      applicationIcon: SizedBox(
        height: 80.0,
        child: Image.asset("assets/images/logo_login.png"),
      ),
      applicationLegalese: "EC00202148122 ?? 18 Sep 2021",
      children: const [
        SizedBox(height: SpacingDimens.spacing16),
        Text("Ajari adalah aplikasi belajar iqro."),
        SizedBox(height: SpacingDimens.spacing12),
        Text("N. Syahfei, A.Algifary", style: TypographyStyle.mini),
        Text("H. Gagagas. I Sholeh", style: TypographyStyle.mini),
        SizedBox(height: SpacingDimens.spacing8),
        Text('Email Contect : dev.noersy@gmail.com', style: TypographyStyle.mini),
      ],
    );
  }
}

class ProfileTile extends StatelessWidget {
  final Profile profile;

  const ProfileTile({Key? key, required this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: SpacingDimens.spacing12,
        bottom: SpacingDimens.spacing4,
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            routeTransition(
              ProfilePage(
                profile: profile,
              ),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
            primary: PaletteColor.primarybg,
            onPrimary: PaletteColor.primary.withOpacity(0.5),
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        child: Row(
          children: [
            SizedBox(
              height: 65.0,
              width: 65.0,
              child: CircleAvatar(
                backgroundColor: PaletteColor.grey40,
                backgroundImage: CachedNetworkImageProvider(profile.urlImage),
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
                    profile.name,
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
