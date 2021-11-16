import 'package:ajari/providers/kelas_provider.dart';
import 'package:ajari/providers/profile_provider.dart';
import 'package:ajari/theme/palette_color.dart';
import 'package:ajari/view/SplashScreenPage/splash_screenpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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
      child: const MaterialApp(
        color: PaletteColor.primary,
        debugShowCheckedModeBanner: false,
        title: 'Ajari',
        home: SplashScreenPage(),
      ),
    );
  }
}
