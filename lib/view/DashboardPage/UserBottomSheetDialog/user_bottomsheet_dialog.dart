import 'package:ajari/config/globals.dart' as globals;
import 'package:ajari/model/profile.dart';
import 'package:ajari/route/route_transisition.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:ajari/view/ProfilePage/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'component/confirmation_logoutdialog.dart';

class UserBottomSheetDialog extends StatelessWidget {
  final BuildContext ctx;

  UserBottomSheetDialog({Key? key, required this.ctx}) : super(key: key);

  final Profile _profile = globals.Get.prf();
  final User _user = globals.Get.usr();

  @override
  Widget build(BuildContext context) {
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
              Container(
                margin: const EdgeInsets.only(
                  top: SpacingDimens.spacing16,
                  bottom: SpacingDimens.spacing8,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      height: 65.0,
                      width: 65.0,
                      child: CircleAvatar(
                        backgroundColor: PaletteColor.grey40,
                        backgroundImage: NetworkImage(_user.photoURL!),
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
                            "${_user.displayName}",
                            style: TypographyStyle.subtitle2,
                          ),
                          const SizedBox(
                            height: SpacingDimens.spacing8,
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding:
                                const EdgeInsets.all(SpacingDimens.spacing4),
                            decoration: BoxDecoration(
                              color: PaletteColor.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              _profile.role,
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
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: PaletteColor.primarybg2,
                margin: const EdgeInsets.only(
                  top: SpacingDimens.spacing8,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(ctx).push(
                    routeTransition(
                      ProfilePage(
                        user: _user,
                        role: _profile.role,
                      ),
                    ),
                  );
                },
                child: actionBottomSheet(
                  icon: Icons.person,
                  title: "My Profile",
                ),
              ),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                color: PaletteColor.primarybg2,
              ),
              GestureDetector(
                onTap: () {
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
    return Container(
      color: PaletteColor.primarybg,
      child: Padding(
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
      ),
    );
  }
}
