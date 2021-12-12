import 'package:ajari/providers/kelas_providers.dart';
import 'package:ajari/providers/profile_providers.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/providers/auth_providers.dart';
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
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
      ],
      child:  MaterialApp(
        color: PaletteColor.primary,
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        title: 'Ajari',
        home: const SplashScreenPage(),
        theme: ThemeData.light().copyWith(
          primaryColor: PaletteColor.primary,
        ),
      ),
    );
  }
}
