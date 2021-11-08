import 'package:ajari/component/AppBar/AppBarBack.dart';
import 'package:ajari/config/globals.dart' as globals;
import 'package:ajari/firebase/DataKelasProvider.dart';
import 'package:ajari/route/RouteTransisition.dart';
import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/theme/TypographyStyle.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudenListPage extends StatelessWidget {
  StudenListPage({Key? key}) : super(key: key);

  final String _codeKelas = globals.Get.prf().codeKelas;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColor.primarybg,
      appBar: AppBarBack(
        title: 'Student List',
        ctx: context,
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: Provider.of<DataKelasProvider>(context)
              .getSantri(codeKelas: _codeKelas),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(child: Text("There is no expense"));
            return ListView(
              children: snapshot.data!.docChanges
                  .map(
                    (e) => SantriContainer(
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
            );
          },
        ),
      ),
    );
  }

  Widget SantriContainer({name, inTo, imageUrl, alamat, email}) {
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
            offset: Offset(0, 1),
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
              padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(0)),
            ),
            child: Icon(
              Icons.arrow_forward,
              color: PaletteColor.grey,
            ),
          ),
        ),
      ),
    );
  }
}

class SantriDetail extends StatelessWidget {
  final String name, role, photoURL, email;

  SantriDetail({
    Key? key,
    required this.name,
    required this.role,
    required this.photoURL,
    required this.email,
  }) : super(key: key);

  final List<jilid> _page = [
    jilid("١", "Satu"),
    jilid("٢", "Dua"),
    jilid("٣", "Tiga"),
    jilid("٤", "Empat"),
    jilid("٥", "Lima"),
    jilid("٦", "Enam"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColor.primarybg,
      appBar: AppBarBack(
        title: name,
        ctx: context,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 200,
              width: double.infinity,
              padding: const EdgeInsets.all(SpacingDimens.spacing8),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(SpacingDimens.spacing8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          photoURL,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: SpacingDimens.spacing8),
                    child: Text(
                      name,
                      style: TypographyStyle.button1,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(SpacingDimens.spacing4),
                    decoration: BoxDecoration(
                      color: PaletteColor.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      role,
                      style: TypographyStyle.subtitle2.merge(
                        TextStyle(
                          color: PaletteColor.primarybg,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: SpacingDimens.spacing8),
              decoration: BoxDecoration(
                color: PaletteColor.grey40,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.6),
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  )
                ],
              ),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    containerData(title: "Name", body: name),
                    containerData(title: "Email", body: email),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(
                        left: SpacingDimens.spacing24,
                        top: SpacingDimens.spacing24,
                        bottom: SpacingDimens.spacing4,
                      ),
                      child: Text(
                        "Jilids",
                        style: TypographyStyle.subtitle1,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: 6,
                        itemBuilder: (BuildContext context, int index) {
                          return JilidContainer(
                            jilid: _page[index].arab,
                            text: _page[index].text,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget containerData({required String title, required String body}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(
          left: SpacingDimens.spacing24,
          top: SpacingDimens.spacing16,
        ),
        child: Text(
          title,
          style: TypographyStyle.paragraph,
        ),
      ),
      Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: PaletteColor.primarybg,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(SpacingDimens.spacing8),
        margin: const EdgeInsets.only(
          left: SpacingDimens.spacing24,
          right: SpacingDimens.spacing24,
          top: SpacingDimens.spacing8,
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: SpacingDimens.spacing8,
            right: SpacingDimens.spacing8,
          ),
          child: Text(
            body,
            style: TypographyStyle.button1,
          ),
        ),
      ),
    ],
  );
}

Widget JilidContainer({text, jilid}) {
  return Container(
    margin: const EdgeInsets.all(SpacingDimens.spacing4),
    decoration: BoxDecoration(
      color: PaletteColor.primarybg,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.4),
          spreadRadius: 1,
          blurRadius: 2,
          offset: Offset(0, 1),
        ),
      ],
    ),
    child: ListTile(
      leading: Container(
        height: 40,
        width: 40,
        margin: const EdgeInsets.all(SpacingDimens.spacing8),
        decoration: BoxDecoration(
          color: PaletteColor.primary.withOpacity(0.2),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
            child: Text(
          jilid,
          style: TypographyStyle.title.merge(
            TextStyle(color: PaletteColor.primary),
          ),
        )),
      ),
      title: Text(
        text,
        style: TypographyStyle.paragraph,
      ),
    ),
  );
}

class jilid {
  final String text;
  final String arab;

  jilid(this.arab, this.text);
}
