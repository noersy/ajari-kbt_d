import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/theme/TypographyStyle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NabiMusaPage extends StatefulWidget {
  @override
  _NabiIbrahimPageState createState() => _NabiIbrahimPageState();
}

class _NabiIbrahimPageState extends State<NabiMusaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColor.primarybg,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFFF7EAC0),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Stack(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: PaletteColor.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(100)),
                    padding: const EdgeInsets.all(SpacingDimens.spacing12),
                    margin: const EdgeInsets.only(
                      top: SpacingDimens.spacing16,
                      left: SpacingDimens.spacing16,
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: PaletteColor.primarybg,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Text(
                            "Kisah",
                            style: TypographyStyle.title.merge(
                              TextStyle(
                                color: Color(0xFF620101),
                                fontSize: 36,
                              ),
                            ),
                          ),
                          Text(
                            "Kisah Nabi Musa",
                            style: TypographyStyle.title.merge(
                              TextStyle(
                                color: Color(0xFF620101),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Image.asset(
                        'assets/images/nabi_musa.png',
                        scale: 0.95,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: SpacingDimens.spacing24,
              bottom: SpacingDimens.spacing12,
              left: SpacingDimens.spacing16,
              right: SpacingDimens.spacing16,
            ),
            child: Text(
              "Nabi Musa AS merupakan nabi yang diutus Allah SWT di tengah kekejaman Raja Firaun. Kisahnya saat berperang melawan penyihir kerajaan merupakan salah satu tanda kekuasaan Allah SWT.",
              style: TypographyStyle.paragraph,
            ),
          ),
          Image.asset(
            'assets/images/story/musa/foto.jpg',
            scale: 2.5,
          ),
          Container(
            margin: const EdgeInsets.only(
              top: SpacingDimens.spacing12,
              left: SpacingDimens.spacing16,
              right: SpacingDimens.spacing16,
            ),
            child: Text(
              "Nabi Musa AS merupakan nabi ke-14 dalam silsilah 25 nabi yang wajib kita imani. Kisah Nabi Musa AS diceritakan dalam Al Quran dan berbagai riwayat.",
              style: TypographyStyle.paragraph,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              left: SpacingDimens.spacing16,
              right: SpacingDimens.spacing16,
              top: SpacingDimens.spacing12,
            ),
            child: Text(
              "Diceritakan dalam buku Musa 'Alaihissalam karya Abu Haafizh Abdurrahman, Raja Firaun adalah raja yang berkuasa di Mesir pada waktu itu. Bahkan ia mengaku sebagai Tuhan. Sehingga seluruh rakyat harus tunduk padanya.",
              style: TypographyStyle.paragraph,
            ),
          ),
        ],
      ),
    );
  }
}
