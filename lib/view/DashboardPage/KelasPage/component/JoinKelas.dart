import 'package:ajari/component/Indicator/IndicatorLoad.dart';
import 'package:ajari/config/globals.dart' as globals;
import 'package:ajari/firebase/DataKelasProvider.dart';
import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/theme/TypographyStyle.dart';
import 'package:flutter/material.dart';

class JoinKelas extends StatefulWidget {
  final Function freshState;

  const JoinKelas({required this.freshState});

  @override
  _JoinKelasState createState() => _JoinKelasState();
}

class _JoinKelasState extends State<JoinKelas> {
  TextEditingController santriInput = new TextEditingController();
  String _codeKelas = '';
  bool _loading = false;

  void joinkelas(santriInput) async {
    _loading = true;

    await DataKelasProvider.joinKelas(
      codeKelas: santriInput.text,
      user: globals.Get.usr(),
    ).then((value) {
      _codeKelas = value;
    });

    await DataKelasProvider.getKelas(codeKelas: _codeKelas).then((value) {
      widget.freshState(value: value);
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? indicatorLoad()
        : Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  left: SpacingDimens.spacing12,
                  right: SpacingDimens.spacing12,
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: SpacingDimens.spacing16,
                              top: SpacingDimens.spacing12,
                              bottom: SpacingDimens.spacing8),
                          child: Text("Not have class yet"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(SpacingDimens.spacing8),
                        child: TextFormField(
                          controller: santriInput,
                          decoration: InputDecoration(
                            labelText: "Codeclass",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: SpacingDimens.spacing24,
                  right: SpacingDimens.spacing24,
                  top: SpacingDimens.spacing8,
                ),
                child: Card(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: PaletteColor.primary,
                        primary: PaletteColor.primary80,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.0),
                          side: BorderSide(
                            color: PaletteColor.green,
                          ),
                        ),
                      ),
                      onPressed: () {
                        joinkelas(santriInput);
                        setState(() {
                          santriInput.value =
                              TextEditingValue(text: santriInput.text);
                        });
                      },
                      child: SizedBox(
                        height: 48,
                        child: Center(
                          child: Text(
                            "Join",
                            style: TypographyStyle.button1.merge(
                              TextStyle(
                                color: PaletteColor.primarybg,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
