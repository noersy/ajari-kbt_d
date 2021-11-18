import 'package:ajari/providers/kelas_providers.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
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
  DateTime selectedTimeStart = DateTime.now();
  DateTime selectedTimeEnd = DateTime.now();
  DateFormat formattedDate = DateFormat('yyyy-MM-dd');
  String _stringDate = "Select Date";
  String _stringTimeStartAt = "Start At";
  String _stringTimeEndAt = "End At";

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

  Future<void> _selectStartTime(BuildContext context) async {
    TimeOfDay _selectedTimeStart = TimeOfDay.now();
    
    final TimeOfDay? _pickedS = await showTimePicker(
      context: context,
      initialTime: _selectedTimeStart,
    );

    if (_pickedS != null && _pickedS != _selectedTimeStart) {
      setState(() {
        selectedTimeStart = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, _pickedS.hour, _pickedS.minute);
        _stringTimeStartAt = _pickedS.format(context);
      }); 
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    TimeOfDay _selectedTimeEnd = TimeOfDay.now();
    final TimeOfDay? _pickedS = await showTimePicker(
      context: context,
      initialTime: _selectedTimeEnd,
    );

    if (_pickedS != null && _pickedS != _selectedTimeEnd) {
      setState(() {
        selectedTimeEnd = DateTime(selectedDate.year, selectedDate.month, selectedDate.day, _pickedS.hour, _pickedS.minute);
        _stringTimeEndAt =  _pickedS.format(context);
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
            const SizedBox(height: SpacingDimens.spacing16),
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
            const SizedBox(height: SpacingDimens.spacing16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: PaletteColor.primarybg,
                onPrimary: PaletteColor.primary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  side: BorderSide(color: PaletteColor.primary.withOpacity(0.5)),
                ),
              ),
              onPressed: () {
                _selectStartTime(context);
              },
              child: SizedBox(
                width: double.infinity,
                height: SpacingDimens.spacing44,
                child: Center(
                  child: Text(
                    _stringTimeStartAt,
                    style: TypographyStyle.button2
                        .copyWith(color: PaletteColor.grey80),
                  ),
                ),
              ),
            ),
            const SizedBox(height: SpacingDimens.spacing8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: PaletteColor.primarybg,
                onPrimary: PaletteColor.primary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  side: BorderSide(color: PaletteColor.primary.withOpacity(0.5)),
                ),
              ),
              onPressed: () {
                _selectEndTime(context);
              },
              child: SizedBox(
                width: double.infinity,
                height: SpacingDimens.spacing44,
                child: Center(
                  child: Text(
                    _stringTimeEndAt,
                    style: TypographyStyle.button2.copyWith(color: PaletteColor.grey80),
                  ),
                ),
              ),
            ),
            const SizedBox(height: SpacingDimens.spacing8),
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
                      if (_stringDate == "Select Date" || _stringTimeStartAt == "Start At" || _stringTimeEndAt == "End At"){
                        Navigator.of(context).pop("Please select to submit absents.");
                        return;
                      }
                      
                      if(selectedTimeStart.compareTo(selectedTimeEnd) > 0){
                        Navigator.of(context).pop("Failed, make sure you select right.");
                        return;
                      }

                      Provider.of<KelasProvider>(context, listen: false).createAbsen(
                        date:  DateTime(selectedDate.year, selectedDate.month, selectedDate.day, selectedTimeStart.hour, selectedTimeStart.minute) ,
                        startAt: selectedTimeStart,
                        endAt: selectedTimeEnd,
                      );

                      Navigator.of(context).pop("Success create absent.");
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
