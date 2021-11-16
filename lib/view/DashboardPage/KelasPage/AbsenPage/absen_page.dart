import 'package:ajari/component/appbar/silver_appbar_back.dart';
import 'package:ajari/component/dialog/dialog_delete.dart';
import 'package:ajari/providers/kelas_provider.dart';
import 'package:ajari/route/route_transisition.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:ajari/view/DashboardPage/KelasPage/AbsenPage/absen_detailpage.dart';
import 'package:ajari/view/DashboardPage/KelasPage/component/create_absen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AbsenPage extends StatelessWidget {
  const AbsenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColor.primarybg,
      // appBar: AppBarBack(title: "Absensi", ctx: context),
      body: SilverAppBarBack(
        barTitle: "Absensi",
        body: StreamBuilder<QuerySnapshot>(
            stream: Provider.of<KelasProvider>(context).getsAbsen(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: Text("There is no expense"));
              }
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: snapshot.data!.docs.map((e) {
                    var data = e.data() as Map<String, dynamic>;
                    var datetime = (data["datetime"] as Timestamp).toDate();
                    var _text = DateFormat("yyyy-MM-dd").format(datetime);

                    return Padding(
                      padding: const EdgeInsets.only(
                        top: SpacingDimens.spacing8,
                        left: SpacingDimens.spacing16,
                        right: SpacingDimens.spacing16,
                      ),
                      child: ElevatedButton(
                        onLongPress: () => showDialog(
                          context: context,
                          builder: (context) => DialogDelete(
                            content: "This will delete the selected item.",
                            onPressedFunction: () {
                              Provider.of<KelasProvider>(context, listen: false)
                                  .deleteAbsen(date: datetime);
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        onPressed: () => Navigator.of(context)
                            .push(routeTransition(const AbsenDetailPage())),
                        child: Container(
                          width: double.infinity,
                          height: SpacingDimens.spacing44,
                          alignment: Alignment.centerLeft,
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.date_range,
                                      color: PaletteColor.text,
                                      size: 18,
                                    ),
                                    const SizedBox(width: SpacingDimens.spacing4),
                                    Text(_text, style: TypographyStyle.button2)
                                  ],
                                ),
                                Row(
                                  children: const [
                                    Icon(
                                      Icons.access_time,
                                      color: PaletteColor.text,
                                      size: 18,
                                    ),
                                    SizedBox(width: SpacingDimens.spacing4),
                                    Text("12.00 - 01.00 WIB",
                                        style: TypographyStyle.button2)
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          onPrimary: PaletteColor.primary,
                          primary: PaletteColor.primarybg2,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: PaletteColor.grey80.withOpacity(0.18),
                              ),
                              borderRadius: BorderRadius.circular(4.0)),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: PaletteColor.green,
        backgroundColor: PaletteColor.primary,
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => const DialogCreateAbsen());
        },
      ),
    );
  }
}
