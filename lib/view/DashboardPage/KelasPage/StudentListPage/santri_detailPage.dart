
import 'package:ajari/component/appbar/appbar_back.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:ajari/view/DashboardPage/HomePage/ReadBottomSheetDialog/read_bottomheet_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SantriDetail extends StatelessWidget {
  final String name, role, photoURL, email;

  SantriDetail({
    Key? key,
    required this.name,
    required this.role,
    required this.photoURL,
    required this.email,
  }) : super(key: key);

  final List<Jilid> _page = [
    Jilid("١", "Satu"),
    Jilid("٢", "Dua"),
    Jilid("٣", "Tiga"),
    Jilid("٤", "Empat"),
    Jilid("٥", "Lima"),
    Jilid("٦", "Enam"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: PaletteColor.primarybg,
      // appBar: AppBarBack(
      //   title: name,
      //   ctx: context,
      // ),
      body: SafeArea(
        child: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          body: Column(
            children:  [
              _content(),
            ],
          ),
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: PaletteColor.primarybg,
                iconTheme: const IconThemeData(color: PaletteColor.primary),
                title:  const Text(
                  "Class",
                  style: TypographyStyle.subtitle1,
                ),
                bottom: PreferredSize(
                  preferredSize: const Size(0, 216),
                  child: _profile(),
                ),
                pinned: true,
                floating: true,
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                forceElevated: innerBoxIsScrolled,
              ),
            ];
          },
        ),
      ),
    );
  }

  Widget _profile(){
    return Padding(
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
                child: Hero(
                  tag: 'Circle_Photo_Santri',
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: CachedNetworkImage(
                        fit: BoxFit.fill, imageUrl: photoURL
                    ),
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
                  const TextStyle(
                    color: PaletteColor.primarybg,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _content(){
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: PaletteColor.grey40,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            )
          ],
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                child: const Text(
                  "Jilids",
                  style: TypographyStyle.subtitle1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 6,
                  itemBuilder: (BuildContext context, int index) {
                    return jilidContainer(
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

Widget jilidContainer({text, jilid}) {
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
          offset: const Offset(0, 1),
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
              style: TypographyStyle.title.copyWith(
                color : PaletteColor.primary),
              ),
            ),
      ),
      title: Text(
        text,
        style: TypographyStyle.paragraph,
      ),
    ),
  );
}

