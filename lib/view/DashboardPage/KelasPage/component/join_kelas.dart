import 'package:ajari/component/indicator/indicator_load.dart';
import 'package:ajari/model/kelas.dart';
import 'package:ajari/providers/kelas_providers.dart';
import 'package:ajari/providers/profile_providers.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JoinKelas extends StatefulWidget {
  final Function(Kelas) freshState;

  const JoinKelas({Key? key, required this.freshState}) : super(key: key);

  @override
  _JoinKelasState createState() => _JoinKelasState();
}

class _JoinKelasState extends State<JoinKelas> {
  final _user = FirebaseAuth.instance.currentUser;
  TextEditingController santriInput = TextEditingController();
  String _codeKelas = '';
  bool _loading = false;

  void joinkelas(santriInput) async {
    try {
      setState(() {
        _loading = true;
      });

      if (_user == null) throw Exception("Not login yet.");

      await Provider.of<KelasProvider>(context, listen: false)
          .joinKelas(codeKelas: santriInput.text, user: _user!)
          .then((value) {
        _codeKelas = value;
      });

      await Provider.of<ProfileProvider>(context, listen: false)
          .getProfile(userUid: _user!.uid);
      var value = await Provider.of<KelasProvider>(context, listen: false)
          .getKelas(codeKelas: _codeKelas);

      if (value == null) throw Exception("Join failed");

      Provider.of<KelasProvider>(context, listen: false).setKelas(value);

      widget.freshState(value);
      setState(() {
        _loading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Widget _joinKelas() {
    return AlertDialog(
      backgroundColor: PaletteColor.primarybg,
      contentPadding: const EdgeInsets.all(0.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(SpacingDimens.spacing4)),
      ),
      elevation: 5,
      content: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width - 150,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: PaletteColor.primarybg,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 22,
            ),
            Text(
              "Kelas Baru",
              style: TypographyStyle.subtitle1.merge(
                const TextStyle(
                  color: PaletteColor.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(SpacingDimens.spacing16),
              child: TextFormField(
                controller: santriInput,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Code kelas',
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.only(
                left: SpacingDimens.spacing16,
                right: SpacingDimens.spacing16,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: PaletteColor.primary,
                  padding: const EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                ),
                onPressed: () {
                  joinkelas(santriInput);
                  setState(() {
                    santriInput.value =
                        TextEditingValue(text: santriInput.text);
                  });
                  Navigator.of(context).pop();
                },
                child: SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "Join",
                      style: TypographyStyle.button1.merge(
                        const TextStyle(
                          color: PaletteColor.primarybg,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: SpacingDimens.spacing16,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Center(child: indicatorLoad());
    } else {
      return Padding(
        padding: const EdgeInsets.only(
          left: SpacingDimens.spacing24,
          right: SpacingDimens.spacing24,
          top: 32,
        ),
        child: Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: PaletteColor.primary,
                    padding: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(
                        color: PaletteColor.green,
                      ),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return _joinKelas();
                      },
                    );
                  },
                  child: SizedBox(
                    height: 48,
                    child: Center(
                      child: Text(
                        "Join",
                        style: TypographyStyle.button1.merge(
                          const TextStyle(
                            color: PaletteColor.primarybg,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: SpacingDimens.spacing8),
                const Text("Kamu membutuhkan pembimbing.",
                    style: TypographyStyle.paragraph),
                const SizedBox(height: SpacingDimens.spacing52),
                SizedBox(
                  height: 250,
                  child: Image.asset('assets/images/santri_join.png'),
                ),
              ],
            ),
          ),
        ),
      );
    }
    ;
  }
}
