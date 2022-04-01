import 'package:flutter/material.dart';
import 'package:hotel_ma/common/app_themes.dart';
import 'package:hotel_ma/feature/screens/home_screen.dart';

import 'feature/screens/onboarding.dart';
import 'feature/screens/product_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Hotel App',
        themeMode: ThemeMode.system,
        theme: MyThemes.lightTheme,
        darkTheme: MyThemes.darkTheme,
        // home: Onboarding());
        // home: HomeScreen());
        home: HomeScreen());

  }
}
