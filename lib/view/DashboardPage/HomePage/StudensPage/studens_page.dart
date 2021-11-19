import 'package:ajari/component/appbar/silver_appbar_back.dart';
import 'package:ajari/providers/kelas_providers.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'jilid_page.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({Key? key}) : super(key: key);

  @override
  _StudentsPageState createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  @override
  Widget build(BuildContext context) {
    final String _codeKelas = context.read<KelasProvider>().kelas.kelasId;

    return Scaffold(
      backgroundColor: PaletteColor.primarybg2,
      // appBar: AppBarBack(ctx: context, title: "Santri"),
      body: SilverAppBarBack(
        barTitle: 'Santri',
        pinned: true,
        floating: true,
        body: StreamBuilder<QuerySnapshot>(
          stream: Provider.of<KelasProvider>(context)
              .getSantri(codeKelas: _codeKelas),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: SpacingDimens.spacing28),
                        child: Image.asset("assets/images/not_found.png"),
                      ),
                      Text("Belum ada santri disini."),
                    ],
                  ),
                  Container(
                    color: PaletteColor.primarybg.withOpacity(0.25),
                    child: const SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                    ),
                  ),
                ],
              );
            }

            if (snapshot.data!.size <= 0) {
              return Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: SpacingDimens.spacing28),
                          child: Image.asset("assets/images/not_found.png"),
                      ),
                      Text("Belum ada santri disini."),
                    ],
                  ),
                  Container(
                    color: PaletteColor.primarybg.withOpacity(0.25),
                    child: const SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                    ),
                  ),
                ],
              );
            }

            return ListView(
              physics: const BouncingScrollPhysics(),
              children: snapshot.data!.docChanges
                  .map(
                    (e) => _santriContainer(
                      name: "${e.doc.get('name')}",
                      imageUrl: e.doc.get('photo'),
                      inTo: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => JilidPage(
                              role: 'santri',
                              uid: e.doc.get('uid'),
                              codeKelas: _codeKelas,
                            ),
                          ),
                        );
                      },
                    ),
                  )
                  .toList(),
            );
          },
        ),
      ),
    );
  }

  Widget _santriContainer({name, inTo, imageUrl}) {
    return Container(
      margin: const EdgeInsets.only(
        left: SpacingDimens.spacing16,
        right: SpacingDimens.spacing16,
        top: SpacingDimens.spacing8,
        bottom: SpacingDimens.spacing8,
      ),
      decoration: BoxDecoration(
        color: PaletteColor.primarybg,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          height: 36,
          width: 36,
          margin: const EdgeInsets.all(SpacingDimens.spacing8),
          decoration: BoxDecoration(
            color: PaletteColor.grey60.withOpacity(0.2),
            borderRadius: BorderRadius.circular(100),
          ),
          child: CircleAvatar(
            foregroundColor: PaletteColor.primary,
            backgroundImage: CachedNetworkImageProvider(imageUrl),
          ),
        ),
        title: Container(
          decoration: BoxDecoration(
            color: PaletteColor.grey60.withOpacity(0.1),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Container(
            width: 100,
            margin: const EdgeInsets.only(left: SpacingDimens.spacing8),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(SpacingDimens.spacing8),
                  child: Text(name),
                )
              ],
            ),
          ),
        ),
        trailing: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
          ),
          child: TextButton(
            onPressed: inTo,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(0),
            ),
            child: const Icon(
              Icons.arrow_forward,
              color: PaletteColor.grey,
            ),
          ),
        ),
      ),
    );
  }
}
