import 'package:ajari/component/appbar/silver_appbar_back.dart';
import 'package:ajari/providers/kelas_providers.dart';
import 'package:ajari/providers/profile_providers.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DiskusiPage extends StatefulWidget {
  final String subject, id;

  const DiskusiPage({Key? key, required this.subject, required this.id})
      : super(key: key);

  @override
  _DiskusiPageState createState() => _DiskusiPageState();
}

class _DiskusiPageState extends State<DiskusiPage> {
  final TextEditingController _editingController = TextEditingController();

  late DateTime _dateTime;

  bool _first = true;

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context).profile;

    return Scaffold(
      backgroundColor: PaletteColor.primarybg2,
      body: Column(
        children: [
          Expanded(
            child: SilverAppBarBack(
              barTitle: widget.subject,
              pinned: true,
              floating: true,
              body: Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: SpacingDimens.spacing16,
                      ),
                      child: _message(profile.role, widget.id),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: SpacingDimens.spacing12,
              right: SpacingDimens.spacing12,
              bottom: SpacingDimens.spacing8,
            ),
            child: Stack(
              children: [
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: PaletteColor.primarybg,
                    ),
                    child: SizedBox(
                      height: 50,
                      child: TextField(
                        controller: _editingController,
                        textAlign: TextAlign.justify,
                        keyboardType: TextInputType.multiline,
                        expands: true,
                        maxLines: null,
                        maxLength: null,
                        cursorColor: PaletteColor.primary,
                        style: TypographyStyle.button1,
                        decoration:  InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              Provider.of<KelasProvider>(context, listen: false).sendMessageDiskusi(
                                  profile: profile,
                                  idDiskusi: widget.id,
                                  message: _editingController.text,
                              );
                              _editingController.clear();
                              FocusScope.of(context).unfocus();
                            },
                            icon: const Icon(Icons.send),
                          ),
                          contentPadding: const EdgeInsets.all(SpacingDimens.spacing12),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _message(role, idDiskusi) {
    return StreamBuilder<QuerySnapshot>(
      stream: Provider.of<KelasProvider>(context)
          .getsMessagesInDiskusi(id: idDiskusi),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: Text("Tidak ada komentar."));
        }
        if (snapshot.data!.docChanges.isEmpty) {
          return const Center(child: Text("Tidak ada komentar."));
        }
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: snapshot.data!.docs.map((e) {
              String _role = e.get('role');
              DateTime date = e.get('datetime').toDate();
              DateTime dateTime = DateTime(date.year, date.month, date.day);
              if (_first) {
                _dateTime = DateTime(date.year, date.month, date.day);
                _first = false;
              }
              if (_dateTime != dateTime) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: Center(
                        child: Text(
                          DateFormat('yyyy-MM-dd').format(dateTime),
                          style: TypographyStyle.mini,
                        ),
                      ),
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
                        padding: const EdgeInsets.all(SpacingDimens.spacing4),
                        decoration: BoxDecoration(
                            color: _role == role
                                ? PaletteColor.primary.withOpacity(0.5)
                                : PaletteColor.grey60.withOpacity(0.5),
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
                              child: Text(
                                e.get('message'),
                              ),
                            ),
                            Container(
                              alignment: _role == role
                                  ? Alignment.bottomRight
                                  : Alignment.bottomLeft,
                              height: 20,
                              width: 50,
                              child: Text(
                                DateFormat('kk:mm')
                                    .format(e.get('dateTime').toDate()),
                                style: TypographyStyle.mini,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
                              child: Text(
                            DateFormat('yyyy-MM-dd').format(dateTime),
                            style: TypographyStyle.mini,
                          )),
                        )
                      : const SizedBox.shrink(),
                  Container(
                    alignment: _role == role
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: SpacingDimens.spacing16,
                        right: SpacingDimens.spacing16,
                        bottom: SpacingDimens.spacing8,
                      ),
                      padding: const EdgeInsets.all(SpacingDimens.spacing4),
                      decoration: BoxDecoration(
                          color: _role == role
                              ? PaletteColor.primary.withOpacity(0.5)
                              : PaletteColor.grey60.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5),
                      ),
                      child: Stack(
                        alignment: _role == role
                            ? Alignment.bottomRight
                            : Alignment.bottomLeft,
                        children: [
                          Positioned(
                            top: 0,
                            child: Text(e.get('name'), style: TypographyStyle.caption1),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 2),
                            padding: _role == role
                                ? const EdgeInsets.only(right: 40, left: 4)
                                : const EdgeInsets.only(left: 40, right: 4),
                            child: Text(e.get('message')),
                          ),
                          Positioned(
                            // alignment: _role == role
                            //     ? Alignment.bottomRight
                            //     : Alignment.bottomLeft,
                            child: Text(DateFormat('kk:mm').format(e.get('datetime').toDate()),
                              style: TypographyStyle.mini,
                            ),
                          ),
                          const SizedBox(height: 35, width: 80,)
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }).toList()..toList(),
          ),
        );
      },
    );
  }
}
