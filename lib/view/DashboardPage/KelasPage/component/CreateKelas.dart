import 'package:ajari/component/Indicator/IndicatorLoad.dart';
import 'package:ajari/firebase/KelasProvider.dart';
import 'package:ajari/firebase/ProfileProvider.dart';
import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/theme/TypographyStyle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateKelas extends StatefulWidget {
  final BuildContext ctx;
  final Function freshState;
  final User user;

  const CreateKelas({
    required this.ctx,
    required this.user,
    required this.freshState,
  });

  @override
  State<CreateKelas> createState() => _CreateKelasState();
}

class _CreateKelasState extends State<CreateKelas> {
  final TextEditingController _editingController = TextEditingController();
  bool _loading = false;
  String _codeKelas = '';

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
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: PaletteColor.primary,
                        primary: PaletteColor.green,
                        padding: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(3.0),
                          side: BorderSide(
                            color: PaletteColor.green,
                          ),
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
                      child: SizedBox(
                        height: 48,
                        child: Center(
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
                controller: _editingController,
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
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: PaletteColor.primary,
                  primary: PaletteColor.primary80,
                  padding: const EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.0),
                    side: BorderSide(
                      color: PaletteColor.green,
                    ),
                  ),
                ),
                onPressed: () {
                  _createKelas();
                  Navigator.of(context).pop();
                },
                child: SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: Center(
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
            SizedBox(
              height: SpacingDimens.spacing16,
            ),
          ],
        ),
      ),
    );
  }

  void _createKelas() async {
    _loading = true;

    try {
      await KelasProvider.createKelas(
        namaKelas: _editingController.text,
        user: widget.user,
      ).then((value) {
        setState(() {
          _codeKelas = value;
        });
      });

      await ProfileProvider.getProfile(userUid: widget.user.uid);
      await KelasProvider.getKelas(codeKelas: _codeKelas).then((value) {
        widget.freshState(value: value);
      });
    } catch (e) {}

    _loading = false;
  }
}
