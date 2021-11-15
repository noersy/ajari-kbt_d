import 'package:ajari/firebase/KelasProvider.dart';
import 'package:ajari/firebase/ProfileProvider.dart';
import 'package:ajari/view/SplashScreenPage/SplashScreenPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ajari',
        home: SplashScreenPage(),
      ),
    );
  }
}
