import 'package:ajari/firebase/KelasProvider.dart';
import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/theme/TypographyStyle.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NilaiDialog extends StatefulWidget {
  final String uid, grade, codeKelas, nomorJilid, nomorHalaman;

   const NilaiDialog({Key? key,
    required this.uid,
    required this.grade,
    required this.codeKelas,
    required this.nomorJilid,
    required this.nomorHalaman,
  }) : super(key: key);

  @override
  _NilaiDialogState createState() => _NilaiDialogState();
}

class _NilaiDialogState extends State<NilaiDialog> {
  late String dropdownValue;

  @override
  void initState() {
    dropdownValue = widget.grade;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          8.0,
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      height: MediaQuery.of(context).size.height - 300,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: PaletteColor.primarybg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Column(
            children: [
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Nilai',
                      style: TypographyStyle.title.merge(
                        const TextStyle(
                          color: PaletteColor.black,
                        ),
                      ),
                    ),
                  ),
                  const Divider(),
                ],
              ),
              Column(
                children: [
                  Container(
                    height: 60,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(SpacingDimens.spacing16),
                    padding: const EdgeInsets.all(SpacingDimens.spacing12),
                    decoration: BoxDecoration(
                      color: PaletteColor.blue.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'A : >80, B+ : >=75, B : >=70, C+ : >=60, C : >=55, D : >=40, E : <40',
                      textAlign: TextAlign.center,
                      style: TypographyStyle.caption2.merge(
                        const TextStyle(
                          color: PaletteColor.grey,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: SpacingDimens.spacing12,
                      right: SpacingDimens.spacing8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: PaletteColor.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.only(
                      left: SpacingDimens.spacing24,
                      right: SpacingDimens.spacing24,
                    ),
                    child: DropdownButton<String>(
                      value: dropdownValue,
                      iconSize: 24,
                      elevation: 16,
                      underline: Container(
                        height: 0,
                        color: Colors.transparent,
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      items: <String>['A', 'B', 'C', 'D', 'E']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(SpacingDimens.spacing16),
                    decoration: BoxDecoration(
                      color: PaletteColor.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Provider.of<KelasProvider>(context, listen: false).setGrade(
                          uid: widget.uid,
                          grade: dropdownValue,
                          codeKelas: widget.codeKelas,
                          nomorJilid: widget.nomorJilid,
                          nomorHalaman: widget.nomorHalaman,
                        );

                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Submit",
                        style: TypographyStyle.button1.merge(const TextStyle(
                          color: PaletteColor.primarybg2,
                        )),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.only(top: SpacingDimens.spacing8),
            alignment: Alignment.topRight,
            width: 60,
            height: 60,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(SpacingDimens.spacing8),
                shape: const CircleBorder(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.close,
                color: PaletteColor.grey60,
              ),
            ),
          )
        ],
      ),
    );
  }
}
