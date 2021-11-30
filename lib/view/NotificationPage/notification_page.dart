import 'package:ajari/component/appbar/silver_appbar_back.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SilverAppBarBack(
        barTitle: 'Notification',
        floating: true,
        pinned: true,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(SpacingDimens.spacing12),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  padding: const EdgeInsets.all(SpacingDimens.spacing12),
                  elevation: 2,
                  onPrimary: Theme.of(context).primaryColor,
                  primary: Theme.of(context).backgroundColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Absen", style: Theme.of(context).textTheme.subtitle1),
                    const SizedBox(height: SpacingDimens.spacing4),
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_filled,
                          color: PaletteColor.grey80,
                          size: 15,
                        ),
                        const SizedBox(width: SpacingDimens.spacing4),
                        Text("7:00 WIB - 8:40 WIB", style: Theme.of(context).textTheme.caption),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(left: SpacingDimens.spacing36),
        alignment: Alignment.bottomCenter,
        child: ElevatedButton.icon(
          style: TextButton.styleFrom(
            elevation: 1,
            padding: const EdgeInsets.only(
              left: SpacingDimens.spacing8,
              right: SpacingDimens.spacing12,
              top: SpacingDimens.spacing8,
              bottom: SpacingDimens.spacing8,
            ),
            backgroundColor: Theme.of(context).backgroundColor,
            primary: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          onPressed: () {},
          icon: const Icon(Icons.clear, size: 21),
          label: const Text("Clear"),
        ),
      ),
    );
  }
}
