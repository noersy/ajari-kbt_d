import 'package:ajari/component/appbar/appbar_back.dart';
import 'package:ajari/component/appbar/silver_appbar_back.dart';
import 'package:ajari/providers/kelas_providers.dart';
import 'package:ajari/route/route_transisition.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:ajari/view/DashboardPage/HomePage/ReadBottomSheetDialog/read_bottomheet_dialog.dart';
import 'package:ajari/view/DashboardPage/KelasPage/StudentListPage/santri_detailPage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudenListPage extends StatelessWidget {
  final String codeKelas;

  const StudenListPage({Key? key, required this.codeKelas}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColor.primarybg,
      // appBar: AppBarBack(title: 'Student List', ctx: context),
      body: SilverAppBarBack(
        barTitle: "Santri",
        pinned: true,
        floating: true,
        body: StreamBuilder<QuerySnapshot>(
          stream: Provider.of<KelasProvider>(context).getSantri(codeKelas: codeKelas),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: Text("There is no expense"));
            }
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: snapshot.data!.docChanges
                    .map(
                      (e) => santriContainer(
                        name: e.doc.get('name'),
                        imageUrl: e.doc.get('photo'),
                        inTo: () => Navigator.of(context).push(
                          routeTransition(
                            SantriDetail(
                              role: "Santri",
                              name: e.doc.get('name'),
                              email: e.doc.get('email'),
                              photoURL: e.doc.get('photo'),
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget santriContainer({name, inTo, imageUrl, alamat, email}) {
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
          child: Hero(
            tag: "Circle_Photo_Santri",
            child: CircleAvatar(
              foregroundColor: PaletteColor.primary,
              backgroundImage: CachedNetworkImageProvider(imageUrl),
            ),
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
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.all(0)),
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
