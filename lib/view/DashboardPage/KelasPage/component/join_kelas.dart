import 'package:ajari/component/indicator/indicator_load.dart';
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
  final Function freshState;

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
    try{
      _loading = true;

      if(_user == null) throw Exception("Not login yet.");

      await Provider.of<KelasProvider>(context, listen: false)
          .joinKelas(codeKelas: santriInput.text, user: _user!)
          .then((value) {
        _codeKelas = value;
      });

      await Provider.of<ProfileProvider>(context, listen: false).getProfile(userUid: _user!);
      var value = await Provider.of<KelasProvider>(context, listen: false).getKelas(codeKelas: _codeKelas);
      widget.freshState(value: value);

      _loading = false;
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
    }
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
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(
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
                          side: const BorderSide(
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
                              const TextStyle(
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
