import 'package:ajari/component/appbar/appbar_back.dart';
import 'package:ajari/providers/kelas_providers.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AbsenDetailPage extends StatefulWidget {
  final DateTime dateTIme;

  const AbsenDetailPage({Key? key, required this.dateTIme}) : super(key: key);

  @override
  _AbsenDetailPageState createState() => _AbsenDetailPageState();
}

class _AbsenDetailPageState extends State<AbsenDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColor.primarybg,
      appBar: AppBarBack(ctx: context, title: "List Santri"),
      body: StreamBuilder<QuerySnapshot>(
        stream: Provider.of<KelasProvider>(context)
            .getsAbsenStudents(widget.dateTIme),
        builder: (BuildContext context, snapshot) {
          if(!snapshot.hasData || snapshot.data!.size <= 0){
            return const Center(child: Text("No has data."));
          }

          return Column(
            children: snapshot.data!.docs.map((e) => santriContainer(
              name: e.get('name'),
              imageUrl: e.get('photo'),
              kehadiran: e.get("kehadiran"),
            )).toList(),
          );
        },
      ),
    );
  }

  Widget santriContainer({name, inTo, imageUrl, alamat, email, required bool kehadiran}) {
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
            backgroundImage: NetworkImage(imageUrl),
          ),
        ),
        title: Container(
          margin: const EdgeInsets.only(left: SpacingDimens.spacing8),
          padding: const EdgeInsets.all(SpacingDimens.spacing8),
          decoration: BoxDecoration(
            color: PaletteColor.grey60.withOpacity(0.1),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Text(name),
        ),
        trailing: Container(
            margin: const EdgeInsets.only(left: SpacingDimens.spacing8),
            padding: const EdgeInsets.all(SpacingDimens.spacing8),
            decoration: BoxDecoration(
              color: kehadiran ? PaletteColor.primary : Colors.red,
              borderRadius: BorderRadius.circular(7),
            ),
            child:  Text("Tidak Hadir",
                style: TypographyStyle.caption2.copyWith(
                  color: PaletteColor.primarybg,
                ),
            ),
        ),
      ),
    );
  }

}
