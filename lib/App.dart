import 'package:flutter/material.dart';
import 'package:sisemprol/view/Routes.dart';
import 'package:sisemprol/view/page/HomePage.dart';
import 'package:sisemprol/view/page/LoginPage.dart';
import 'package:sisemprol/view/page/SplashScreenPage.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sisemprol Polinema',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        accentColor: Colors.red,
        backgroundColor: Colors.amber,
      ),
      home: SplashScreenPage(),
      showPerformanceOverlay: false,
      routes: {
        ROUTE_PATH[Routes.LOGIN]: (buildContext) => LoginPage(),
        ROUTE_PATH[Routes.HOME]: (buildContext) => HomePage(),
      },
    );
  }
}
