import 'package:ajari/theme/costume_icons.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:ajari/view/DashboardPage/HomePage/StudensPage/studens_page.dart';
import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final IconData icon;
  final double? iconSize;
  final String titleArab;
  final String title;
  final Widget target;

  const HomeButton({
    Key? key,
    required this.icon,
    required this.titleArab,
    required this.title,
    required this.target,
    this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 1,
          primary: PaletteColor.primarybg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          side: BorderSide(
            color: PaletteColor.grey80.withOpacity(0.08),
          ),
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              // builder: (context) => const StudensPage(),
              builder: (_) => target,
            ),
          );
        },
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              margin: const EdgeInsets.all(SpacingDimens.spacing8),
              decoration: BoxDecoration(
                color: PaletteColor.primary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Icon(
                // CostumeIcons.holyQuran,
                icon,
                color: PaletteColor.primary,
                size: iconSize ?? 32.0,
              ),
            ),
            Container(
              width: 75,
              padding: const EdgeInsets.only(
                bottom: SpacingDimens.spacing12,
                left: SpacingDimens.spacing12,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    // "قيم",
                    titleArab,
                    style: TypographyStyle.subtitle1.copyWith(
                        color: PaletteColor.primary, fontSize: 20,
                    ),
                  ),
                  Text(
                    // "Nilai",
                    title,
                    style: TypographyStyle.subtitle2.copyWith(fontSize: 12),
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
