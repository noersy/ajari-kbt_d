import 'package:ajari/providers/kelas_providers.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DialogCreateMeet extends StatefulWidget {
  final DateTime? date;

  const DialogCreateMeet({Key? key, this.date}) : super(key: key);

  @override
  _DialogCreateMeetState createState() => _DialogCreateMeetState();
}

class _DialogCreateMeetState extends State<DialogCreateMeet> {
  DateTime selectedDate = DateTime.now();
  final TimeOfDay _ofDay = TimeOfDay.now();
  final TextEditingController _editingController = TextEditingController();
  DateFormat formattedDate = DateFormat('yyyy-MM-dd');
  String _stringDate = "Select Date";

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
    if (widget.date != null) {
      _stringDate = formattedDate.format(widget.date!);
      selectedDate = widget.date!;
    }

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
                    color: PaletteColor.primary.withOpacity(0.5),
                  ),
                ),
              ),
              onPressed: widget.date == null ? () => _selectDate(context) : null,
              child: SizedBox(
                width: double.infinity,
                height: SpacingDimens.spacing44,
                child: Center(
                  child: Text(
                    _stringDate,
                    style: TypographyStyle.button2.copyWith(
                      color: PaletteColor.grey80,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: SpacingDimens.spacing16),
            TextFormField(
              controller: _editingController,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                alignLabelWithHint : true,
                contentPadding: const EdgeInsets.only(
                  left: SpacingDimens.spacing12,
                  right: SpacingDimens.spacing12,
                ),
                enabledBorder:  OutlineInputBorder(
                    borderSide: BorderSide(color: PaletteColor.primary.withOpacity(0.5))
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: PaletteColor.primary.withOpacity(0.5))
                ),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: PaletteColor.primary)
                ),
                label: Center(
                  child: Text(
                    "Subject",
                    style: TypographyStyle.button2.copyWith(
                      color: PaletteColor.grey80,
                    ),
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
                      if (_stringDate == "Select Date" || _editingController.text.isEmpty) {
                        Navigator.of(context).pop("Please select to submit meet.");
                        return;
                      }

                      Provider.of<KelasProvider>(context, listen: false)
                          .createMeet(
                        subject: _editingController.text,
                        date: DateTime(selectedDate.year, selectedDate.month,
                            selectedDate.day, _ofDay.hour, _ofDay.minute),
                      );
                      Navigator.of(context).pop("Success create meet room.");
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
