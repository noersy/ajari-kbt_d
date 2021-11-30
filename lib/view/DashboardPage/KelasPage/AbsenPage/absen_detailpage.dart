import 'package:ajari/component/appbar/appbar_back.dart';
import 'package:ajari/providers/kelas_providers.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:ajari/view/DashboardPage/KelasPage/AbsenPage/component/update_absent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class AbsenDetailPage extends StatefulWidget {
  final DateTime dateTIme;
  final DateTime startAt;
  final DateTime endAt;
  final String id;


  const AbsenDetailPage({Key? key, required this.dateTIme, required this.startAt, required this.endAt, required this.id}) : super(key: key);

  @override
  _AbsenDetailPageState createState() => _AbsenDetailPageState();
}

class _AbsenDetailPageState extends State<AbsenDetailPage> {

  @override
  Widget build(BuildContext context) {
    final _text = DateFormat("yyyy-MM-dd").format(widget.dateTIme);

    return Scaffold(
      backgroundColor: PaletteColor.primarybg,
      appBar: AppBarBack(
          ctx: context,
          title: _text,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextButton.icon(
                style: TextButton.styleFrom(
                  primary: PaletteColor.grey,
                ),
                onPressed: () async {
                  var result = await showDialog(
                    context: context,
                    builder: (context) => DialogUpdateAbsen(id: widget.id,date: widget.dateTIme, endAt: widget.endAt, startAt: widget.startAt,),
                  ) ?? "Cancel";

                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.mode_edit_outlined,
                  color: PaletteColor.text,
                ),
                label: const Text(
                  "Edit",
                  style: TypographyStyle.button1,
                ),
              ),
            )
          ]
      ),
      body: StreamBuilder<QuerySnapshot?>(
        stream: Provider.of<KelasProvider>(context).getsAbsenStudents(widget.id),
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
            child:  Text(kehadiran ? "Hadir": "Tidak Hadir",
                style: TypographyStyle.caption2.copyWith(
                  color: PaletteColor.primarybg,
                ),
            ),
        ),
      ),
    );
  }

}
