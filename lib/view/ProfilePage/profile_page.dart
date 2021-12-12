import 'package:ajari/component/appbar/appbar_back.dart';
import 'package:ajari/component/dialog/dialog_delete.dart';
import 'package:ajari/model/kelas.dart';
import 'package:ajari/model/profile.dart';
import 'package:ajari/providers/kelas_providers.dart';
import 'package:ajari/providers/profile_providers.dart';
import 'package:ajari/route/route_transisition.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:ajari/providers/auth_providers.dart';
import 'package:ajari/view/LoginPage/login_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  final Profile profile;

  const ProfilePage({Key? key, required this.profile}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void _delete() async {
    await Provider.of<ProfileProvider>(context, listen: false).deleteProfile(userid: widget.profile.uid);
    await Provider.of<AuthProvider>(context, listen: false).signOut(context: context);
    Provider.of<KelasProvider>(context, listen: false).clearData();
    Provider.of<KelasProvider>(context, listen: false).deleteLocalKelas();
    Provider.of<ProfileProvider>(context, listen: false).deleteLocalProfile();

    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    await Navigator.of(context).pushAndRemoveUntil(routeTransition(const LoginPage()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PaletteColor.primarybg,
      appBar: AppBarBack(
        ctx: context,
        title: "Profile",
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton.icon(
              style: TextButton.styleFrom(
                primary: PaletteColor.grey,
              ),
              onPressed: () => showDialog(
                context: context,
                builder: (_) => DialogDelete(
                  content: "content",
                  onPressedFunction: _delete,
                ),
              ),
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
        ],
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
                        child: widget.profile.urlImage != "-"
                            ? CachedNetworkImage(
                                fit: BoxFit.fill,
                                imageUrl: widget.profile.urlImage,
                              )
                            : const SizedBox.shrink(),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(bottom: SpacingDimens.spacing8),
                    child: Text(
                      widget.profile.name,
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
                      widget.profile.role,
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
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    containerData(title: "Name", body: widget.profile.name),
                    containerData(title: "Email", body: widget.profile.email),
                  ],
                ),
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
