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

class CreateKelas extends StatefulWidget {
  final BuildContext ctx;
  final Function freshState;

   const CreateKelas({Key? key,
    required this.ctx,
    required this.freshState,
  }) : super(key: key);

  @override
  State<CreateKelas> createState() => _CreateKelasState();
}

class _CreateKelasState extends State<CreateKelas> {
  final TextEditingController _editingController = TextEditingController();
  final User? user = FirebaseAuth.instance.currentUser;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {

    String _codeKelas = context.read<KelasProvider>().kelas.kelasId;


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
                    children: const [
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(
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
                          side: const BorderSide(
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
            const Padding(
              padding: EdgeInsets.only(
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
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Name'),
              ),
            ),
            const Expanded(child: SizedBox()),
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
                    side: const BorderSide(
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

  void _createKelas() async {
    try{
      _loading = true;

      String _codeKelas = await Provider.of<KelasProvider>(context, listen: false).createKelas(namaKelas: _editingController.text, user: user);
      await Provider.of<ProfileProvider>(context, listen: false).getProfile(userUid: user?.uid ?? "");
      Kelas? value = await Provider.of<KelasProvider>(context, listen: false).getKelas(codeKelas: _codeKelas);
      widget.freshState(value: value);

      _loading = false;
    }catch(e){
      if (kDebugMode) {
        print("$e");
      }
    }

  }
}
