import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SilverMainAppBar extends StatefulWidget {
  final Widget body;
  final Widget action;
  final bool pinned, floating;
  final List<Widget> banner;
  final List<Widget> barTitle;
  final ScrollController scrollController;

  const SilverMainAppBar({
    Key? key,
    required this.barTitle,
    required this.body,
    required this.pinned,
    required this.floating,
    required this.scrollController,
    required this.banner,
    required this.action,
  }) : super(key: key);

  @override
  State<SilverMainAppBar> createState() => _SilverMainAppBarState();
}

class _SilverMainAppBarState extends State<SilverMainAppBar> {
  final _pageViewController = PageController();

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      controller: widget.scrollController,
      physics: const BouncingScrollPhysics(),
      body: widget.body,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            elevation: 5,
            toolbarHeight: 60.0,
            primary: true,
            backgroundColor: PaletteColor.primarybg,
            actions: [
              widget.action
            ],
            iconTheme: const IconThemeData(color: PaletteColor.primary),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.barTitle,
            ),
            pinned: widget.pinned,
            floating: widget.floating,
            forceElevated: innerBoxIsScrolled,
          ),
          SliverAppBar(
            elevation: 0,
            primary: false,
            titleSpacing: 0,
            toolbarHeight: 190.0,
            backgroundColor: Colors.transparent,
            title: Container(
              margin: const EdgeInsets.only(
                  top: SpacingDimens.spacing12,
                  bottom: SpacingDimens.spacing24,
              ),
              decoration: BoxDecoration(
                color: PaletteColor.primarybg,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(35.0),
                  bottomRight: Radius.circular(35.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: PaletteColor.grey40.withOpacity(0.1),
                    spreadRadius: 3.5,
                  ),
                  BoxShadow(
                    color: PaletteColor.grey40.withOpacity(0.2),
                    spreadRadius: 3,
                  ),
                  BoxShadow(
                    color: PaletteColor.grey40.withOpacity(0.2),
                    spreadRadius: 2.5,
                  ),
                  BoxShadow(
                    color: PaletteColor.grey60.withOpacity(0.05),
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    color: PaletteColor.grey60.withOpacity(0.1),
                    spreadRadius: 1.5,
                  ),
                  BoxShadow(
                    color: PaletteColor.grey60.withOpacity(0.2),
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: PaletteColor.grey60.withOpacity(0.2),
                    spreadRadius: 0.5,
                  ),
                ]
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 170,
                    child: PageView(
                      physics: const BouncingScrollPhysics(),
                      controller: _pageViewController,
                      children: widget.banner,
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: _pageViewController,
                    count: 2,
                    axisDirection: Axis.horizontal,
                    onDotClicked: (i) {
                      _pageViewController.animateToPage(
                        i,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                    effect: const ExpandingDotsEffect(
                      expansionFactor: 3,
                      spacing: 8,
                      radius: 16,
                      dotWidth: 10,
                      dotHeight: 10,
                      dotColor: PaletteColor.grey40,
                      activeDotColor: PaletteColor.primary,
                      paintStyle: PaintingStyle.fill,
                    ),
                  ),
                  const SizedBox(height: SpacingDimens.spacing8)
                ],
              ),
            ),
            pinned: false,
            floating: false,
            forceElevated: innerBoxIsScrolled,
          ),
        ];
      },
    );
  }
}
