import 'package:ajari/route/RouteTransisition.dart';
import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/TypographyStyle.dart';
import 'package:flutter/material.dart';

class AppBarNotification extends StatelessWidget
    implements PreferredSizeWidget {
  final BuildContext ctx;
  final String title;

  const AppBarNotification({Key? key, required this.ctx, required this.title}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        backgroundColor: PaletteColor.primarybg,
        elevation: 0,
        title: Text(
          title,
          style: TypographyStyle.subtitle1,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              // IconComponent.notification,
              Icons.wysiwyg,
            ),
            color: PaletteColor.primary,
            iconSize: 20,
            onPressed: () {
              Navigator.of(ctx).push(
                routeTransition(
                  Container(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
