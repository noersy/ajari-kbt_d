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
    return Padding(
      padding: const EdgeInsets.all(SpacingDimens.spacing8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 1,
          primary: const Color(0xFF42BF80),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
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
        child: SizedBox(
          height: 200,
          child: Stack(
            children: [
              // Positioned(
              //   right: 0,
              //   bottom: 0,
              //   child: SizedBox(
              //     width: 60,
              //     child: Image.asset('assets/images/img_cerita.png'),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(
                  left: SpacingDimens.spacing12,
                ),
                child: Stack(
                  children: [
                    const SizedBox(width: double.infinity, height: 500),
                    Padding(
                      padding: const EdgeInsets.only(top: 50),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          // "قيم",
                          titleArab,
                          style: TypographyStyle.subtitle1.copyWith(color: PaletteColor.primarybg, fontSize: 78),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 0,
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
            ],
          ),
        ),
      ),
    );
  }
}
