import 'package:ajari/model/profile.dart';
import 'package:ajari/providers/kelas_providers.dart';
import 'package:ajari/providers/profile_providers.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:ajari/view/LoginPage/component/auth_login.dart';
import 'package:ajari/view/SplashScreenPage/splash_screenpage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfirmationLogoutDialog extends StatelessWidget {
  final BuildContext homePageCtx, sheetDialogCtx;

  const ConfirmationLogoutDialog({
    Key? key,
    required this.homePageCtx,
    required this.sheetDialogCtx,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          8.0,
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          padding: const EdgeInsets.all(SpacingDimens.spacing24),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: PaletteColor.primarybg,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Confirmation Logout',
                style: TypographyStyle.subtitle1.merge(
                  const TextStyle(
                    color: PaletteColor.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 22,
              ),
              Text(
                'Are you sure you want to logout now?',
                style: TypographyStyle.paragraph.merge(
                  const TextStyle(
                    color: PaletteColor.grey60,
                  ),
                ),
              ),
              const SizedBox(
                height: 38,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 3.2,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: PaletteColor.primarybg,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          side: const BorderSide(color: PaletteColor.primary),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'No',
                        style: TypographyStyle.button2.merge(
                          const TextStyle(
                            color: PaletteColor.primary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 3.2,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: PaletteColor.primary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(sheetDialogCtx);
                        logOut(homePageCtx);
                      },
                      child: Text(
                        'Yes',
                        style: TypographyStyle.button2.merge(
                          const TextStyle(
                            color: PaletteColor.primarybg,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  void logOut(BuildContext context) async {
    try {
      await AuthLogin.signOut(context: context);
      // Provider.of<KelasProvider>(context, listen: false).closeKelasService();
      context.read<KelasProvider>().closeKelasService();
      Provider.of<KelasProvider>(context, listen: false).clearData();
      Provider.of<KelasProvider>(context, listen: false).deleteLocalKelas();
      Provider.of<ProfileProvider>(context, listen: false).deleteLocalProfile();
      Provider.of<ProfileProvider>(context, listen: false).setProfile(Profile.blankProfile());

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const SplashScreenPage(),
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}