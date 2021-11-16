import 'package:ajari/firebase/KelasProvider.dart';
import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/theme/TypographyStyle.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DialogCreateAbsen extends StatefulWidget {
  const DialogCreateAbsen({Key? key}) : super(key: key);

  @override
  State<DialogCreateAbsen> createState() => _DialogCreateAbsenState();
}

class _DialogCreateAbsenState extends State<DialogCreateAbsen> {
  DateTime selectedDate = DateTime.now();
  String _stringDate = "Select Date";
  DateFormat formattedDate = DateFormat('yyyy-MM-dd');

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _stringDate = formattedDate.format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: PaletteColor.primarybg,
      contentPadding: const EdgeInsets.all(0.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            SpacingDimens.spacing4,
          ),
        ),
      ),
      elevation: 5,
      content: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(SpacingDimens.spacing24),
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
                const TextStyle(
                  color: PaletteColor.black,
                ),
              ),
            ),
            const SizedBox(
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
            const SizedBox(
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
                      if (_stringDate == "Select Date") return;

                      Provider.of<KelasProvider>(context, listen: false).createAbsen(
                        date: selectedDate,
                      );

                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Submit',
                      style: TypographyStyle.button2.merge(
                        const TextStyle(
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
    );
  }
}
