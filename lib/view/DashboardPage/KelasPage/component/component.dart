import 'package:ajari/providers/profile_providers.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/view/DashboardPage/KelasPage/component/dialog_create.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DateCard extends StatefulWidget {
  final String hari, tgl;
  final Color color;
  final Function()? onTap;
  final bool haveEvent;
  final DateTime dateTime;

  const DateCard({
    Key? key,
    required this.dateTime,
    required this.hari,
    required this.tgl,
    required this.color,
    required this.onTap,
    required this.haveEvent,
  }) : super(key: key);

  @override
  _DateCardState createState() => _DateCardState();
}

class _DateCardState extends State<DateCard> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    var profile = Provider.of<ProfileProvider>(context).profile;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 2.0, right: 2.0, bottom: 4.0, top: 8.0),
        child: ElevatedButton(
          onPressed: widget.onTap,
          onLongPress: profile.role != "Santri"
              ? () async {
                  setState(() => !_selected ? _selected = true : false);
                  await showDialog(
                    context: context,
                    builder: (context) => DialogCreate(
                      dateTime: widget.dateTime,
                    ),
                  );
                  setState(() => _selected ? _selected = false : true);
                }
              : null,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(0),
            primary: PaletteColor.primary,
            backgroundColor: _selected ? PaletteColor.primary : PaletteColor.primarybg,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.hari,
                style: TextStyle(
                    color: _selected ? PaletteColor.primarybg : widget.color,
                    fontWeight: FontWeight.w400,
                    fontSize: 12),
              ),
              const SizedBox(height: 2.0),
              Text(
                widget.tgl,
                style: TextStyle(
                  color: _selected ? PaletteColor.primarybg : widget.color,
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 1),
              Container(
                height: 1.6,
                width: 24,
                decoration: BoxDecoration(
                  color: widget.haveEvent
                      ? PaletteColor.primary.withOpacity(0.6)
                      : _selected
                          ? PaletteColor.primarybg
                          : widget.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
