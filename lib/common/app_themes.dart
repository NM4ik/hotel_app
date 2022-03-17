import 'package:flutter/material.dart';

class MyThemes {
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.red,
      cardColor: const Color(0xFFF5F5F5),
      scaffoldBackgroundColor: Colors.white,
      textTheme: const TextTheme(
        headline3: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600), // main text Inter-18-SemiBold
        bodyText1: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w400), // main text Inter-12-400
      ));

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.black,
      cardColor: const Color(0xFF373737),
      scaffoldBackgroundColor: Color(0xFF1B1B1B),
      textTheme: const TextTheme(
        headline3: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600), // main text Inter-18-SemiBold
        bodyText1: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w400), // main text Inter-12-400
      ));
}
