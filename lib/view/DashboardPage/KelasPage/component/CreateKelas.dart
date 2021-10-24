

import 'package:ajari/firebase/DataKelasProvider.dart';
import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/theme/TypographyStyle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateKelas extends StatelessWidget {
  final BuildContext ctx;
  final User user;

  const CreateKelas({required this.ctx, required this.user});

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
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: SpacingDimens.spacing28,
                        bottom: SpacingDimens.spacing28),
                    child: Text("you not have class yet"),
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
                  showDialog(
                    context: context,
                    builder: (context) {
                      return createKelas();
                    },
                  );
                },
                child: Text(
                  "Create",
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

  Widget createKelas() {
    return Container(
      decoration: BoxDecoration(
          color: PaletteColor.primarybg,
          borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.only(
        left: SpacingDimens.spacing28,
        right: SpacingDimens.spacing28,
        top: SpacingDimens.spacing36,
        bottom: SpacingDimens.spacing36,
      ),
      child: Scaffold(
        backgroundColor: PaletteColor.primarybg.withOpacity(0),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: SpacingDimens.spacing28,
                bottom: SpacingDimens.spacing8,
              ),
              child: Text(
                'Create New Class',
                style: TypographyStyle.subtitle2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(SpacingDimens.spacing16),
              child: TextFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Name'),
              ),
            ),
            Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.only(
                left: SpacingDimens.spacing16,
                right: SpacingDimens.spacing16,
              ),
              child: FlatButton(
                color: PaletteColor.primary,
                splashColor: PaletteColor.primary80,
                height: 48,
                minWidth: MediaQuery.of(ctx).size.width,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.0),
                  side: BorderSide(
                    color: PaletteColor.green,
                  ),
                ),
                onPressed: () {
                  DataKelasProvider.createKelas(
                      namaKelas: 'nama', user: user);
                },
                child: Text(
                  "Create",
                  style: TypographyStyle.button1.merge(
                    TextStyle(
                      color: PaletteColor.primarybg,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: SpacingDimens.spacing16,
            ),
          ],
        ),
      ),
    );
  }

}
