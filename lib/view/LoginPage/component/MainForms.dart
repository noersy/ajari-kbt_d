import 'package:ajari/theme/PaletteColor.dart';
import 'package:ajari/theme/SpacingDimens.dart';
import 'package:ajari/theme/TypographyStyle.dart';
import 'package:flutter/material.dart';

class MainForms extends StatefulWidget {
  final TextEditingController nimFilter;
  final TextEditingController passwordFilter;

  const MainForms({
    Key? key,
    required this.nimFilter,
    required this.passwordFilter,
  }) : super(key: key);

  @override
  _MainFormsState createState() => _MainFormsState();
}

class _MainFormsState extends State<MainForms> {
  bool _isHidePassword = true;

  void _togglePasswordVisibility() {
    setState(() {
      _isHidePassword = !_isHidePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: SpacingDimens.spacing44),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.bottomLeft,
            child: Text(
              "Email",
              style: TypographyStyle.mini.merge(
                const TextStyle(
                  color: PaletteColor.grey60,
                ),
              ),
            ),
          ),
          TextFormField(
            controller: widget.nimFilter,
            cursorColor: PaletteColor.primary,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(
                left: SpacingDimens.spacing16,
                top: SpacingDimens.spacing8,
                bottom: SpacingDimens.spacing8,
              ),
              hintText: "Enter Email",
              hintStyle: TypographyStyle.paragraph.merge(
                const TextStyle(
                  color: PaletteColor.grey60,
                ),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: PaletteColor.primary,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: SpacingDimens.spacing36),
            alignment: Alignment.bottomLeft,
            child: Text(
              "Password",
              style: TypographyStyle.mini.merge(
                const TextStyle(
                  color: PaletteColor.grey60,
                ),
              ),
            ),
          ),
          TextFormField(
            obscureText: _isHidePassword,
            controller: widget.passwordFilter,
            cursorColor: PaletteColor.primary,
            keyboardType: TextInputType.visiblePassword,
            style: TypographyStyle.button1,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(
                left: SpacingDimens.spacing16,
                top: SpacingDimens.spacing12,
                bottom: SpacingDimens.spacing8,
              ),
              hintText: "Enter Password",
              hintStyle: TypographyStyle.paragraph.merge(
                const TextStyle(
                  color: PaletteColor.grey60,
                ),
              ),
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: PaletteColor.primary,
                ),
              ),
              suffixIcon: GestureDetector(
                onTap: _togglePasswordVisibility,
                child: Icon(
                  _isHidePassword ? Icons.visibility_off : Icons.visibility,
                  color: _isHidePassword
                      ? PaletteColor.grey60
                      : PaletteColor.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
