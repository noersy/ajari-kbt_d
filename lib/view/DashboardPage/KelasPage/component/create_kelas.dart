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

class CreateKelas extends StatefulWidget {
  const CreateKelas({Key? key}) : super(key: key);

  @override
  State<CreateKelas> createState() => _CreateKelasState();
}

class _CreateKelasState extends State<CreateKelas> {
  final TextEditingController _editingController = TextEditingController();

  final User? user = FirebaseAuth.instance.currentUser;

  bool _loading = false;

  void _createKelas(ctx) async {
    try {
      setState(() {
        _loading = true;
      });

      var data = await Provider.of<KelasProvider>(context, listen: false).createKelas(namaKelas: _editingController.text, user: user);
      await Provider.of<ProfileProvider>(context, listen: false).getProfile(userUid: user?.uid ?? "");
      Provider.of<KelasProvider>(context, listen: false).instalizeKelasService();

      if (data == 400) throw Exception("Create Kelas failed");
    } catch (e) {
      if (kDebugMode) {
        print("$e");
      }
    }

    if (!mounted) return;
    setState(() {
      _loading = false;
    });
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
                const SizedBox(height: SpacingDimens.spacing8),
                const Text("Mulai mengajar santri kamu.",
                    style: TypographyStyle.paragraph),
                const SizedBox(height: SpacingDimens.spacing52),
                SizedBox(
                  height: 250,
                  child: Image.asset('assets/images/teach.png'),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  AlertDialog createKelas() {
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
                controller: _editingController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name Kelas',
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
                  _createKelas(context);
                  Navigator.of(context).pop();
                },
                child: SizedBox(
                  height: 48,
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "Buat",
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
}
