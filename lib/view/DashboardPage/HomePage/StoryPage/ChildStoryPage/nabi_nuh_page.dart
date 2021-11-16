import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:flutter/material.dart';

class NabihNuhPage extends StatefulWidget {
  const NabihNuhPage({Key? key}) : super(key: key);

  @override
  _NabiIbrahimPageState createState() => _NabiIbrahimPageState();
}

class _NabiIbrahimPageState extends State<NabihNuhPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColor.primarybg,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            height: 300,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF9F5A2A),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Stack(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration : BoxDecoration(
                        color: PaletteColor.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(100)
                    ),
                    padding: const EdgeInsets.all(SpacingDimens.spacing12),
                    margin: const EdgeInsets.only(
                      top: SpacingDimens.spacing16,
                      left: SpacingDimens.spacing16,
                    ),
                    child: const Icon(
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
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Text(
                            "Kisah",
                            style: TypographyStyle.title.merge(
                              const TextStyle(
                                color: PaletteColor.primarybg,
                                fontSize: 36,
                              ),
                            ),
                          ),
                          Text(
                            "Kisah Nabi Ibrahim",
                            style: TypographyStyle.title.merge(
                              const TextStyle(color: PaletteColor.primarybg),
                            ),
                          ),
                        ],
                      ),
                      Image.asset(
                        'assets/images/nabi_ibrahim.png',
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
              left: SpacingDimens.spacing16,
              right: SpacingDimens.spacing16,
            ),
            child: const Text(
              "Nabi Ibrahim AS adalah salah satu Nabi dari ke-25 yang wajib diimani oleh setiap umat Islam. Kisah Nabi Ibrahim AS pun perlu diketahui oleh umat Islam. Maka dari itu, berikut ini Suara.com sajikan kisah Nabi Ibrahim AS mulai dari kecil hingga perjuangannya melawan Raja Namrud.",
              style: TypographyStyle.paragraph,
            ),
          ),
          Image.asset(
            'assets/images/story/ibrahim/foto.png',
            scale: 2.5,
          ),
          Container(
            margin: const EdgeInsets.only(
              left: SpacingDimens.spacing16,
              right: SpacingDimens.spacing16,
            ),
            child: const Text(
              "Nabi Ibrahim AS merupakan ulul azmi yakni golongan nabi yang memiliki ketabahan yang luar biasa dalam perjuangan dakwahnya. Rasul yang termasuk ulul azmi adalah Nabi Nuh AS, Nabi Ibrahim AS, Nabi Musa AS, Nabi Isa AS, serta Nabi Muhammad SAW.",
              style: TypographyStyle.paragraph,
            ),
          ),
        ],
      ),
    );
  }
}
