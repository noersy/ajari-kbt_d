import 'package:ajari/route/RouteTransisition.dart';
import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/theme/TypographyStyle.dart';
import 'package:ajari/view/ProfilePage/ProfilePage.dart';
import 'package:flutter/material.dart';

import 'component/ConfirmationLogoutDialog.dart';
import 'package:ajari/config/globals.dart' as globals;

class UserBottomSheetDialog extends StatelessWidget {
  final BuildContext ctx;

  UserBottomSheetDialog({required this.ctx});

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Container(
          height: 280.0,
          padding: EdgeInsets.symmetric(
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
                margin: EdgeInsets.only(
                  top: SpacingDimens.spacing16,
                  bottom: SpacingDimens.spacing8,
                ),
                child: Row(
                  children: [
                    Container(
                      height: 65.0,
                      width: 65.0,
                      child: CircleAvatar(
                        backgroundColor: PaletteColor.grey40,
                        backgroundImage: NetworkImage(
                            '${globals.user!.photoURL!}'),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: SpacingDimens.spacing24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Text(
                              "${globals.user!.displayName}",
                              style: TypographyStyle.subtitle2,
                            ),
                          ),
                          SizedBox(
                            height: SpacingDimens.spacing8,
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding : const EdgeInsets.all(SpacingDimens.spacing4),
                            decoration: BoxDecoration(
                              color: PaletteColor.primary,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              globals.profile!.role,
                              style: TypographyStyle.subtitle2.merge(
                                TextStyle(
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
                margin: EdgeInsets.only(
                  top: SpacingDimens.spacing8,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(ctx).push(
                    routeTransition(
                      ProfilePage(user: globals.user!, role: globals.profile!.role,),
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
        padding: EdgeInsets.symmetric(
          vertical: SpacingDimens.spacing16,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 25,
              color: PaletteColor.primary,
            ),
            SizedBox(
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
