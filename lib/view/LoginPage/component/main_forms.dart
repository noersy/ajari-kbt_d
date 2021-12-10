import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/spacing_dimens.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:flutter/material.dart';

class MainForms extends StatefulWidget {
  final TextEditingController controllerUsername;
  final TextEditingController passwordFilter;

  const MainForms({
    Key? key,
    required this.controllerUsername,
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
      padding: const EdgeInsets.all(SpacingDimens.spacing28),
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextFormField(
            controller: widget.controllerUsername,
            cursorColor: PaletteColor.primary,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(
                left: SpacingDimens.spacing16,
                top: SpacingDimens.spacing8,
                bottom: SpacingDimens.spacing8,
              ),
              label: Text(
                "Username",
                style: TypographyStyle.paragraph.copyWith(
                  color: PaletteColor.grey60,
                ),
              ),
              hintText: "Enter Username",
              hintStyle: TypographyStyle.paragraph.copyWith(
                color: PaletteColor.grey60,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7.0),
                borderSide: const BorderSide(color: PaletteColor.primary),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: PaletteColor.primary),
              ),
            ),
          ),
          const SizedBox(height: SpacingDimens.spacing12),
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
              label: Text(
                "Password",
                style: TypographyStyle.paragraph.copyWith(
                  color: PaletteColor.grey60,
                ),
              ),
              hintText: "Enter Password",
              hintStyle: TypographyStyle.paragraph.copyWith(
                color: PaletteColor.grey60,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(7.0),
                borderSide: const BorderSide(color: PaletteColor.primary),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: PaletteColor.primary),
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
          Container(
            padding: const EdgeInsets.only(top: SpacingDimens.spacing16),
            child: GestureDetector(
              onTap: () {},
              child: Text(
                "Forgot password?",
                style: TypographyStyle.caption2.merge(
                  const TextStyle(
                    color: PaletteColor.primary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
