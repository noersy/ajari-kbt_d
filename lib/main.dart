import 'package:ajari/providers/kelas_providers.dart';
import 'package:ajari/providers/profile_providers.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/theme/typography_style.dart';
import 'package:ajari/view/SplashScreenPage/splash_screenpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProfileProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => KelasProvider(),
        ),
      ],
      child: MaterialApp(
        color: PaletteColor.primary,
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        theme: ThemeData.light().copyWith(
          backgroundColor: PaletteColor.primarybg,
          focusColor: PaletteColor.primary,
          primaryColor: PaletteColor.primary,
          cardColor: PaletteColor.primarybg,
          splashColor: PaletteColor.primary.withOpacity(0.2),
          buttonTheme: ButtonThemeData(
            buttonColor: PaletteColor.primary,
            splashColor: PaletteColor.primary.withOpacity(0.2),
          ),
          textTheme: const TextTheme(
              subtitle1: TypographyStyle.subtitle1,
              subtitle2: TypographyStyle.subtitle2,
              caption: TypographyStyle.caption1,
              button: TypographyStyle.button2,
              bodyText1: TypographyStyle.paragraph,
              headline1: TypographyStyle.heading1,
          ),
        ),
        title: 'Ajari',
        home: const SplashScreenPage(),
      ),
    );
  }
}
