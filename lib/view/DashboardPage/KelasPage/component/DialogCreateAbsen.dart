import 'package:ajari/firebase/DataKelasProvider.dart';
import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/theme/TypographyStyle.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DialogCreateAbsen extends StatefulWidget {
  const DialogCreateAbsen({Key? key}) : super(key: key);

  @override
  State<DialogCreateAbsen> createState() => _DialogCreateAbsenState();
}

class _DialogCreateAbsenState extends State<DialogCreateAbsen> {
  DateTime selectedDate = DateTime.now();
  String _stringDate = "Select Date";
  final TextEditingController _editingController = TextEditingController();
  DateFormat formattedDate = DateFormat('yyyy-MM-dd');

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        _stringDate = formattedDate.format(picked);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: AlertDialog(
        backgroundColor: PaletteColor.primarybg,
        contentPadding: EdgeInsets.all(0.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              SpacingDimens.spacing4,
            ),
          ),
        ),
        elevation: 5,
        content: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(SpacingDimens.spacing24),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: PaletteColor.primarybg,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Create",
                style: TypographyStyle.subtitle1.merge(
                  TextStyle(
                    color: PaletteColor.black,
                  ),
                ),
              ),
              SizedBox(
                height: SpacingDimens.spacing16,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: PaletteColor.primarybg,
                  onPrimary: PaletteColor.primary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      side: BorderSide(
                          color: PaletteColor.primary.withOpacity(0.5))),
                ),
                onPressed: () {
                  _selectDate(context);
                },
                child: SizedBox(
                  width: double.infinity,
                  height: SpacingDimens.spacing44,
                  child: Center(
                    child: Text(
                      _stringDate,
                      style: TypographyStyle.button2
                          .copyWith(color: PaletteColor.grey80),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: SpacingDimens.spacing16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: PaletteColor.primary,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                      onPressed: () {
                        DataKelasProvider.createAbsen(
                          date: selectedDate,
                        );
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Submit',
                        style: TypographyStyle.button2.merge(
                          TextStyle(
                            color: PaletteColor.primarybg,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
