import 'package:ajari/firebase/DataKelasProvider.dart';
import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/theme/TypographyStyle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MessageDialog extends StatelessWidget {
  final BuildContext homePageCtx, sheetDialogCtx;
  final String nomorJilid, nomorHalaman, uid, codeKelas, role;

  MessageDialog(
      {required this.homePageCtx,
      required this.sheetDialogCtx,
      required this.nomorJilid,
      required this.nomorHalaman,
      required this.uid,
      required this.codeKelas,
      required this.role});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          8.0,
        ),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  TextEditingController _editingController = new TextEditingController();
  late DateTime _dateTime;
  bool _first = true;

  contentBox(context) {
    return Container(
      height: MediaQuery.of(context).size.height - 200,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: PaletteColor.primarybg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Halaman ' + nomorHalaman,
                        style: TypographyStyle.subtitle1.merge(
                          TextStyle(
                            color: PaletteColor.black,
                          ),
                        ),
                      ),
                    ),
                    Divider(),
                  ],
                ),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: PaletteColor.grey60),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    left: SpacingDimens.spacing4),
                                child: Icon(Icons.play_circle_fill),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "00:00",
                                  style: TypographyStyle.caption2,
                                ),
                              ),
                              Expanded(
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(7),
                                      child: Container(
                                        height: 2,
                                        decoration: BoxDecoration(
                                          color: PaletteColor.grey80,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 16,
                                      height: 16,
                                      decoration: BoxDecoration(
                                          color: PaletteColor.primary,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Icon(
                                          Icons.pause_outlined,
                                          size: 14,
                                          color: PaletteColor.primarybg,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: SpacingDimens.spacing8,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 22),
                      StreamBuilder<QuerySnapshot>(
                        stream: Provider.of<DataKelasProvider>(context)
                            .getMassage(
                                uid: uid,
                                codeKelas: codeKelas,
                                nomorJilid: nomorJilid,
                                nomorHalaman: nomorHalaman),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData)
                            return Center(child: Text("Tidak ada pesan."));
                          if (snapshot.data!.docChanges.length == 0)
                            return Center(child: Text("Tidak ada pesan."));
                          // return Text("data : " + snapshot.data!.docChanges.single.doc.get('message'));
                          return Expanded(
                            child: ListView(
                              physics: BouncingScrollPhysics(),
                              children: snapshot.data!.docs.map((e) {
                                String _role = e.get('role');
                                DateTime date = e.get('dateTime').toDate();
                                DateTime dateTime = DateTime(date.year, date.month, date.day);
                                DateTime _now = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
                                if(_first){
                                  _dateTime = DateTime(date.year, date.month, date.day);
                                  _first = false;
                                }
                                if(_dateTime != dateTime){
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(2),
                                        child: Center(
                                            child: Text(
                                              DateFormat('yyyy-MM-dd').format(dateTime),
                                              style: TypographyStyle.mini,
                                        )),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                          left: SpacingDimens.spacing16,
                                          right: SpacingDimens.spacing16,
                                          bottom: SpacingDimens.spacing8,
                                        ),
                                        alignment: _role == role
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft,
                                        child: Container(
                                          padding: const EdgeInsets.all(
                                              SpacingDimens.spacing4),
                                          decoration: BoxDecoration(
                                              color: _role == role
                                                  ? PaletteColor.primary
                                                  .withOpacity(0.5)
                                                  : PaletteColor.grey60
                                                  .withOpacity(0.5),
                                              borderRadius: BorderRadius.circular(5)),
                                          child: Stack(
                                            alignment: _role == role
                                                ? Alignment.bottomRight
                                                : Alignment.bottomLeft,
                                            children: [
                                              Container(
                                                height: 20,
                                                padding: _role == role
                                                    ? const EdgeInsets.only(right: 40, left: 4)
                                                    : const EdgeInsets.only(left: 40, right: 4),
                                                child: Text(e.get('message')),
                                              ),
                                              Container(
                                                alignment: _role == role
                                                    ? Alignment.bottomRight
                                                    : Alignment.bottomLeft,
                                                height: 20,
                                                width: 50,
                                                child: Text(
                                                  DateFormat('kk:mm').format(
                                                      e.get('dateTime').toDate()),
                                                  style: TypographyStyle.mini,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                }
                                _dateTime = DateTime(date.year, date.month, date.day);
                                return Column(
                                  children: [
                                    _first
                                    ? Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Center(
                                          child: Text(DateFormat('yyyy-MM-dd').format(dateTime),
                                            style: TypographyStyle.mini,
                                          )),
                                    )
                                    : SizedBox.shrink(),
                                    Container(
                                      margin: const EdgeInsets.only(
                                        left: SpacingDimens.spacing16,
                                        right: SpacingDimens.spacing16,
                                        bottom: SpacingDimens.spacing8,
                                      ),
                                      alignment: _role == role
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                      child: Container(
                                        padding: const EdgeInsets.all(
                                            SpacingDimens.spacing4),
                                        decoration: BoxDecoration(
                                            color: _role == role
                                                ? PaletteColor.primary
                                                    .withOpacity(0.5)
                                                : PaletteColor.grey60
                                                    .withOpacity(0.5),
                                            borderRadius: BorderRadius.circular(5)),
                                        child: Stack(
                                          alignment: _role == role
                                              ? Alignment.bottomRight
                                              : Alignment.bottomLeft,
                                          children: [
                                            Container(
                                              height: 20,
                                              padding: _role == role
                                                  ? const EdgeInsets.only(right: 40, left: 4)
                                                  : const EdgeInsets.only(left: 40, right: 4),
                                              child: Text(e.get('message')),
                                            ),
                                            Container(
                                              alignment: _role == role
                                                  ? Alignment.bottomRight
                                                  : Alignment.bottomLeft,
                                              height: 20,
                                              width: 50,
                                              child: Text(
                                                DateFormat('kk:mm').format(
                                                    e.get('dateTime').toDate()),
                                                style: TypographyStyle.mini,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: PaletteColor.primary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                bottomLeft: Radius.circular(2),
                bottomRight: Radius.circular(2),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(SpacingDimens.spacing8),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: PaletteColor.primarybg,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextFormField(
                        controller: _editingController,
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: SpacingDimens.spacing8,
                            vertical: SpacingDimens.spacing8,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: SpacingDimens.spacing8,
                  ),
                  SizedBox(
                    width: 50,
                    child: FlatButton(
                      onPressed: () {
                        DataKelasProvider.sendMessage(
                          uid: uid,
                          codeKelas: codeKelas,
                          nomorJilid: nomorJilid,
                          nomorHalaman: nomorHalaman,
                          message: _editingController.text,
                          role: role,
                        );
                        _editingController.clear();
                      },
                      child: Icon(
                        Icons.send,
                        color: PaletteColor.primarybg,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
