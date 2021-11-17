import 'package:ajari/component/indicator/indicator_load.dart';
import 'package:ajari/providers/profile_provider.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/view/DashboardPage/dashboard_page.dart';
import 'package:ajari/view/LoginPage/component/button_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  final User user;

  const RegisterPage({Key? key, required this.user}) : super(key: key);

  @override
  _RegisterPage createState() => _RegisterPage();
}


class _RegisterPage extends State<RegisterPage> {
  bool isLoading = false;
  String _selected = "";
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    Widget loadingIndicator = isLoading
        ? Container(color: Colors.black26, width: double.infinity, height: double.infinity, child: indicatorLoad())
        : Container();

    return Scaffold(
      backgroundColor: PaletteColor.primarybg,
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(SpacingDimens.spacing24),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/ajarilogo.png',
                      width: 150,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: [
                            _elevatedButton("Santri", () {
                              setState(() {
                                _selected = "Santri";
                              });
                              _pageController.animateToPage(0, duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
                            }),
                            _elevatedButton("Pengajar", () {
                              _pageController.animateToPage(1, duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
                              setState(() {
                                _selected = "Pengajar";
                              });
                            }),
                          ],
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: SpacingDimens.spacing8,
                              horizontal: SpacingDimens.spacing8
                            ),
                            child: PageView(
                              controller: _pageController,
                              children:  [
                                _text("Disini descripsi santri"),
                                _text("Disini descripsi pengajar"),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  ButtonLogin(
                    onPressedFunction: onPressedFunction,
                    title: "Continue",
                  ),
                ],
              ),
            ),
          ),
          Align(
            child: loadingIndicator,
            alignment: FractionalOffset.center,
          ),
        ],
      ),
    );
  }

  Center _text(text){
    return Center(
      child: Text(text),
    );
  }
  Expanded _elevatedButton(String title, Function() onPressed) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: _selected != title
                  ? PaletteColor.primarybg
                  : PaletteColor.primary,
              padding: const EdgeInsets.symmetric(
                  vertical: SpacingDimens.spacing16),
              side: const BorderSide(color: PaletteColor.primary),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0))
          ),
          onPressed: onPressed,
          child: Text(title, style: TextStyle(
              color: _selected != title ? PaletteColor.grey80 : PaletteColor
                  .primarybg)),
        ),
      ),
    );
  }
  void onPressedFunction() async {
    try {
      if(_selected == "") return;
      await Provider.of<ProfileProvider>(context, listen: false).createProfile(userid: widget.user.uid, role: _selected);
      await Provider.of<ProfileProvider>(context, listen: false).getProfile(userUid: FirebaseAuth.instance.currentUser?.uid ?? "");

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const DashboardPage(),
        ),
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
