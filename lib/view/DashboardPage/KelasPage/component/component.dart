import 'package:ajari/providers/profile_providers.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/view/DashboardPage/KelasPage/AbsenPage/component/create_absen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DateCard extends StatefulWidget {
  final hari, tgl, color, onTap, haveEvent;
  final DateTime dateTime;
  final VoidCallback callback;

  const DateCard({
    Key? key,
    required this.dateTime,
    this.hari,
    this.tgl,
    this.color,
    this.onTap,
    this.haveEvent,
    required this.callback,
  }) : super(key: key);

  @override
  _DateCardState createState() => _DateCardState();
}

class _DateCardState extends State<DateCard> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    var profile = Provider.of<ProfileProvider>(context).profile;

    return Padding(
      padding: const EdgeInsets.only(left: 2, right: 2),
      child: ElevatedButton(
        onPressed: widget.onTap,
        onLongPress: profile.role == "Santri"
            ? null
            : () async {
                setState(() => !_selected ? _selected = true : false);

                var result = await showDialog(
                      context: context,
                      builder: (context) => DialogCreateAbsen(date: widget.dateTime),
                    ) ?? "Cancel";


                widget.callback();

                setState(() => _selected ? _selected = false : true);

                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
              },
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(0),
          primary: PaletteColor.primary,
          backgroundColor: _selected ? PaletteColor.primary : PaletteColor.primarybg,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
        ),
        child: SizedBox.expand(
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
