import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/view/DashboardPage/KelasPage/AbsenPage/component/create_absen.dart';
import 'package:flutter/material.dart';

class DateCard extends StatefulWidget {
  final hari, tgl, color, onTap, haveEvent;
  final DateTime dateTime;

  const DateCard({
    Key? key,
    required this.dateTime,
    this.hari,
    this.tgl,
    this.color,
    this.onTap,
    this.haveEvent,
  }) : super(key: key);

  @override
  _DateCardState createState() => _DateCardState();
}

class _DateCardState extends State<DateCard> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return dateCard(widget.hari, widget.tgl, widget.color, widget.onTap, widget.haveEvent, widget.dateTime);
  }

  Widget dateCard(hari, tgl, color, onTap, haveEvent, DateTime date) {
    return Padding(
      padding: const EdgeInsets.only(left: 2, right: 2),
      child: ElevatedButton(
        onPressed: onTap,
        onLongPress: () async {
          setState(() {
            if(!_selected) _selected = true;
          });
          var result = await showDialog(
            context: context,
            builder: (context) => DialogCreateAbsen(date: date),
          );
          setState(() {
            if(_selected) _selected = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
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
                hari,
                style: TextStyle(color: _selected ? PaletteColor.primarybg : color, fontWeight: FontWeight.w400, fontSize: 12),
              ),
              const SizedBox(height: 2),
              Text(tgl,
                  style: TextStyle(
                      color: _selected ? PaletteColor.primarybg : color,
                      fontWeight: FontWeight.normal,
                      fontSize: 18)),
              const SizedBox(height: 1),
              Container(
                height: 1.6,
                width: 24,
                decoration: BoxDecoration(
                  color: haveEvent ? PaletteColor.primary.withOpacity(0.6) : _selected ? PaletteColor.primarybg : color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
