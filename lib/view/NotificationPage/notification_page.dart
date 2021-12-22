import 'package:ajari/component/appbar/silver_appbar_back.dart';
import 'package:ajari/providers/notification_providers.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  void dissmisAll() {
    // setState(() => _list.clear());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColor.primarybg,
      body: SilverAppBarBack(
          barTitle: 'Notification',
          floating: true,
          pinned: true,
          body: AnimatedBuilder(
            animation: Provider.of<NotificationProvider>(context),
            builder: (BuildContext context, Widget? child) {
              return ListView.builder(
                itemCount: Provider.of<NotificationProvider>(context).notification.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = Provider.of<NotificationProvider>(context).notification[index];

                  return Dismissible(
                    key: Key(item?.title ?? ""),
                    onDismissed: (DismissDirection direction) {
                      // setState(() => _list.removeAt(index));
                      Provider.of<NotificationProvider>(context, listen: false).dismissAtIndex(index);
                    },
                    child: ListCard(
                      title: item?.title ?? "",
                      body: item?.body ?? "",
                    ),
                  );
                },
              );
            },
          ),
      ),











      floatingActionButton: Container(
        margin: const EdgeInsets.only(left: SpacingDimens.spacing36),
        alignment: Alignment.bottomCenter,
        child: ElevatedButton.icon(
          style: TextButton.styleFrom(
            elevation: 5,
            padding: const EdgeInsets.only(
              left: SpacingDimens.spacing8,
              right: SpacingDimens.spacing12,
              top: SpacingDimens.spacing8,
              bottom: SpacingDimens.spacing8,
            ),
            backgroundColor: PaletteColor.primarybg,
            primary: PaletteColor.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          onPressed: dissmisAll,
          icon: const Icon(Icons.clear, size: 21),
          label: const Text("Clear"),
        ),
      ),
    );
  }
}

class ListCard extends StatelessWidget {
  final String title, body;

  const ListCard({Key? key, required this.title, required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: SpacingDimens.spacing12,
        vertical: SpacingDimens.spacing4,
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          padding: const EdgeInsets.all(SpacingDimens.spacing12),
          elevation: 3,
          onPrimary: PaletteColor.primary,
          primary: PaletteColor.grey40,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TypographyStyle.subtitle2),
            const SizedBox(height: SpacingDimens.spacing4),
            Row(
              children: [
                const Icon(
                  Icons.access_time_filled,
                  color: PaletteColor.grey80,
                  size: 15,
                ),
                const SizedBox(width: SpacingDimens.spacing4),
                Text(body, style: TypographyStyle.caption1),
              ],
            )
          ],
        ),
      ),
    );
  }
}
