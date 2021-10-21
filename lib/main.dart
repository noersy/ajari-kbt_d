import 'package:ajari/firebase/DataKelasProvider.dart';
import 'package:ajari/firebase/DataProfileProvider.dart';
import 'package:ajari/firebase/DatabaseProvider.dart';
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
          create: (_) => DatabaseProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DataProfileProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DataKelasProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ajari',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SplashScreenPage(),
      ),
    );
  }
}
