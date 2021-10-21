import 'package:ajari/component/AppBar/AppBarBack.dart';
import 'package:ajari/config/PathIqro.dart';
import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/view/DashboardPage/HomePage/ReadPage/HalamanPage/HalamanPage.dart';
import 'package:ajari/view/DashboardPage/component/HalamanContainer.dart';
import 'package:flutter/material.dart';

class ReadPage extends StatefulWidget {
  final String nomor, uid, codeKelas, role;

  const ReadPage({
    required this.nomor,
    required this.uid,
    required this.codeKelas,
    required this.role,
  });

  @override
  _ReadPageState createState() => _ReadPageState();
}

class _ReadPageState extends State<ReadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColor.primarybg,
      appBar: AppBarBack(
        ctx: context,
        title: 'Jilid ${widget.nomor}',
      ),
      body: Container(
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return HalamanContainer(
              uid: widget.uid,
              role: widget.role,
              codeKelas: widget.codeKelas,
              ctx: context,
              nomorHalaman: "${index + 1}",
              nomorJilid: widget.nomor,
              inTo: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => HalamanPage(
                      uid: widget.uid,
                      role: widget.role,
                      codeKelas: widget.codeKelas,
                      nomorJilid: widget.nomor,
                      nomorHalaman: "${index + 1}",
                      pathBacaan: PathIqro.mainImagePath +
                          "/jilid${widget.nomor}" +
                          "/halaman${index + 1}" +
                          ".png",
                      pathAudio: PathIqro.mainAudioPath +
                          "/jilid${widget.nomor}" +
                          "/halaman${index + 1}" +
                          ".png",
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
