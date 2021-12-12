import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:flutter/material.dart';

class UstazHomePageButtonExtend extends StatelessWidget {
  final IconData icon;
  final double? iconSize;
  final String titleArab;
  final String title;
  final Widget target;

  const UstazHomePageButtonExtend({
    Key? key,
    required this.icon,
    required this.titleArab,
    required this.title,
    required this.target,
    this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: SpacingDimens.spacing8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 4,
            primary: const Color(0xFF42BF80),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
            padding: const EdgeInsets.all(0),
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
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(
                    top: 50, left: SpacingDimens.spacing12),
                child: Text(
                  // "قيم",
                  titleArab,
                  style: TypographyStyle.subtitle1
                      .copyWith(color: PaletteColor.primarybg, fontSize: 70),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: Text(
                  // "Nilai",
                  title,
                  style: TypographyStyle.title.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: PaletteColor.primarybg,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UstazHomePageButtonList extends StatelessWidget {
  final IconData icon;
  final double? iconSize;
  final String titleArab;
  final String title;
  final Widget target;

  const UstazHomePageButtonList({
    Key? key,
    this.iconSize,
    required this.icon,
    required this.titleArab,
    required this.title,
    required this.target,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SpacingDimens.spacing8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 4,
          primary: const Color(0xFF42BF80),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0),
          ),
          padding: const EdgeInsets.all(0),
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
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              padding:
                  const EdgeInsets.only(top: 50, left: SpacingDimens.spacing12),
              child: Text(
                // "قيم",
                titleArab,
                style: TypographyStyle.subtitle1
                    .copyWith(color: PaletteColor.primarybg, fontSize: 70),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Text(
                // "Nilai",
                title,
                style: TypographyStyle.title.copyWith(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: PaletteColor.primarybg,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
