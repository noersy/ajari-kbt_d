import 'package:ajari/component/appbar/appbar_back.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final User user;
  final String role;

  const ProfilePage({Key? key, required this.user, required this.role})
      : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColor.primarybg,
      appBar: AppBarBack(
        ctx: context,
        title: "Profile",
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
                        child: widget.user.photoURL?.isNotEmpty != null
                            ? Image.network(
                                widget.user.photoURL!,
                                fit: BoxFit.fill,
                              )
                            : const SizedBox.shrink(),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: SpacingDimens.spacing8),
                    child: Text(
                      "${widget.user.displayName}",
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
                      widget.role,
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
                    offset: const Offset(0, 1),
                  )
                ],
              ),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  containerData(
                      title: "Name", body: '${widget.user.displayName}'),
                  containerData(title: "Email", body: '${widget.user.email}'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
}