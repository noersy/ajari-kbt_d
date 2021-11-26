import 'package:ajari/component/appbar/silver_appbar_back.dart';
import 'package:ajari/config/path_iqro.dart';
import 'package:ajari/providers/kelas_providers.dart';
import 'package:ajari/providers/profile_providers.dart';
import 'package:ajari/model/profile.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/view/DashboardPage/HomePage/ReadPage/HalamanPage/read_page.dart';
import 'package:ajari/view/DashboardPage/HomePage/ReadPage/component/halaman_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListHalamanPage extends StatefulWidget {
  final String nomor, uid;

  const ListHalamanPage({Key? key, required this.nomor, required this.uid})
      : super(key: key);

  @override
  _ListHalamanPageState createState() => _ListHalamanPageState();
}

class _ListHalamanPageState extends State<ListHalamanPage> {

  Profile _profile = Profile.blankProfile();
  final List<int> _listJumlahH = [32, 30, 30, 30, 30, 31];


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
     _profile =  Provider.of<ProfileProvider>(context, listen: false).profile;



    return Scaffold(
      backgroundColor: PaletteColor.primarybg,
      body: SilverAppBarBack(
        pinned: true,
        floating: true,
        barTitle: 'Jilid ${widget.nomor}',
        body: FutureBuilder<QuerySnapshot?>(
          future: Provider.of<KelasProvider>(context).getGrade(
            uid: widget.uid,
            codeKelas: _profile.codeKelas,
            nomorJilid: widget.nomor,
          ),
          builder: (context, snapshot) {
            int nomor = int.parse(widget.nomor) - 1;
            var dat = snapshot.data?.docs ?? [];
            List<Map<String, String>> _dataDump = [];
            int _length = _listJumlahH[nomor] - dat.length;
            int i = dat.length - 1;

            if (snapshot.data?.docs != null) {
              i = 1;
              _length = _listJumlahH[nomor];
            }

            while (_length >= -1) {
              _dataDump.add({'halaman': '$i'});
              _length--;
              i++;
            }

            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: _listJumlahH[nomor],
              itemBuilder: (BuildContext context, int index) {
                var data = {};

                if (dat.length > index) data = dat[index].data() as Map;
                if (data['halaman'] == null) data = _dataDump[index];

                return HalamanContainer(
                  ctx: context,
                  uid: widget.uid,
                  role: _profile.role,
                  grade: data['grade'] != null ? "${data['grade']}" : '-',
                  codeKelas: _profile.codeKelas,
                  nomorHalaman: "${index + 1}",
                  nomorJilid: widget.nomor,
                  inTo: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ReadPage(
                          uid: widget.uid,
                          role: _profile.role,
                          grade: data['grade'] != null ? "${data['grade']}" : 'E',
                          codeKelas: _profile.codeKelas,
                          nomorJilid: widget.nomor,
                          nomorHalaman: "${index + 1}",
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}