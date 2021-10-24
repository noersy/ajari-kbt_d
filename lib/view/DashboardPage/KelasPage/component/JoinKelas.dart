

import 'package:ajari/firebase/DataKelasProvider.dart';
import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/theme/TypographyStyle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class JoinKelas extends StatefulWidget {
  final User user;

  const JoinKelas({required this.user});

  @override
  _JoinKelasState createState() => _JoinKelasState();
}

class _JoinKelasState extends State<JoinKelas> {
  TextEditingController santriInput = new TextEditingController();
  String codeKelas = '';

  void joinkelas(santriInput) async {
    codeKelas = await DataKelasProvider.joinKelas(
        codeKelas: santriInput.text, user: widget.user);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
              child: FlatButton(
                color: PaletteColor.primary,
                splashColor: PaletteColor.primary80,
                height: 48,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.0),
                  side: BorderSide(
                    color: PaletteColor.green,
                  ),
                ),
                onPressed: () {
                  joinkelas(santriInput);
                  setState(() {
                    santriInput.value = TextEditingValue(text: santriInput.text);
                  });
                },
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
      ],
    );
  }
}

