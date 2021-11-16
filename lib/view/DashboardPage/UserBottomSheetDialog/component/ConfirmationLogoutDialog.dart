import 'package:ajari/config/globals.dart' as globals;
import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/theme/TypographyStyle.dart';
import 'package:ajari/view/LoginPage/component/AuthLogin.dart';
import 'package:ajari/view/SplashScreenPage/SplashScreenPage.dart';
import 'package:flutter/material.dart';

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
          width: MediaQuery.of(context).size.width,
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
                    width: MediaQuery.of(context).size.width / 3.2,
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
                    width: MediaQuery.of(context).size.width / 3.2,
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

  void logOut(context) async {
    await AuthLogin.signOut(context: context);

    globals.Set.clearAll();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const SplashScreenPage(),
      ),
    );
  }
}
