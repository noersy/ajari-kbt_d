import 'package:ajari/component/appbar/appbar_back.dart';
import 'package:ajari/component/appbar/silver_appbar_back.dart';
import 'package:ajari/config/path_iqro.dart';
import 'package:ajari/config/globals.dart' as globals;
import 'package:ajari/firebase/kelas_provider.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/view/DashboardPage/HomePage/ReadPage/HalamanPage/halaman_page.dart';
import 'package:ajari/view/DashboardPage/HomePage/ReadPage/component/halaman_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



//@param nomor : String adalah nomor halaman per jilid iqro
//@param uid : String, id user milik santri

class ReadPage extends StatefulWidget {
  final String nomor, uid;

  const ReadPage({Key? key,
    required this.nomor,
    required this.uid
  }) : super(key: key);

  @override
  _ReadPageState createState() => _ReadPageState();
}

class _ReadPageState extends State<ReadPage> {
  final String _codeKelas = globals.Get.prf().codeKelas.isNotEmpty ? globals.Get.prf().codeKelas : "-";
  final String _role = globals.isProfileNotNull ? globals.Get.prf().role : "-";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColor.primarybg,
      // appBar: AppBarBack(
      //   ctx: context,
      //   title: 'Jilid ${widget.nomor}',
      // ),
      body: SilverAppBarBack(
        tittle: 'Jilid ${widget.nomor}',
        body: StreamBuilder<QuerySnapshot>(
            stream: Provider.of<KelasProvider>(context).getGrade(
              uid: widget.uid,
              codeKelas: _codeKelas,
              nomorJilid: widget.nomor,
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: Text("No data."));
              }

              var dat = snapshot.data?.docs ?? [];
              List<Map<String, String>> _dataDump = [];
              int _length = 10 - dat.length;
              int i = dat.length - 1;

              if (snapshot.data?.docs != null) {
                i = 1;
                _length = 10;
              }

              while (_length >= -1) {
                _dataDump.add({'halaman': '$i'});
                _length--;
                i++;
              }

              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  var data = {};

                  if (dat.length > index) data = dat[index].data() as Map;
                  if (data['halaman'] == null) data = _dataDump[index];

                  return HalamanContainer(
                    ctx: context,
                    uid: widget.uid,
                    role: _role,
                    grade: data['grade'] != null ? "${data['grade']}" : '-',
                    codeKelas: _codeKelas,
                    nomorHalaman: "${index+1}",
                    nomorJilid: widget.nomor,
                    inTo: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HalamanPage(
                            uid: widget.uid,
                            role: _role,
                            grade: data['grade'] != null
                                ? "${data['grade']}"
                                : 'E',
                            codeKelas: _codeKelas,
                            nomorJilid: widget.nomor,
                            nomorHalaman: "${index+1}",
                            pathBacaan: PathIqro.mainImagePath +
                                "/jilid${widget.nomor}" +
                                "/halaman${index+1}" +
                                ".png",
                            pathAudio: PathIqro.mainAudioPath +
                                "/jilid${widget.nomor}" +
                                "/halaman${index+1}" +
                                ".png",
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            }),
      ),
    );
  }

}
