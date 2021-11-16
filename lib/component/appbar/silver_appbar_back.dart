import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:flutter/material.dart';

class SilverAppBarBack extends StatelessWidget {
  final Widget body;
  final String barTitle;

  const SilverAppBarBack({
    Key? key,
    required this.barTitle,
    required this.body,
    required,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NestedScrollView(
        physics: const BouncingScrollPhysics(),
        body: body,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: PaletteColor.primarybg,
              iconTheme: const IconThemeData(color: PaletteColor.primary),
              title: Text(barTitle, style: TypographyStyle.subtitle1),
              pinned: false,
              floating: true,
              forceElevated: innerBoxIsScrolled,
            ),
          ];
        },
      ),
    );
  }
}
