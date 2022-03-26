import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class MyThemes {
  static ThemeData lightTheme = ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.black,
      cardColor: const Color(0xFFF5F5F5),
      scaffoldBackgroundColor: Color(0xFFFAFAFA),

      primaryColorLight: const Color(0xFFF5F5F5), // textField - search // price containers



      textTheme: const TextTheme(
        headline1: TextStyle(fontSize: 21, color: Colors.black, fontWeight: FontWeight.w600, fontFamily: "inter", letterSpacing: 1),

        headline3: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w600, fontFamily: "inter"), // main text Inter-18-SemiBold


        bodyText1: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w400, fontFamily: "inter"), // main text Inter-12-400
        bodyText2: TextStyle(fontSize: 9, color: Colors.black, fontWeight: FontWeight.w400, fontFamily: "inter"), // a small text
      ));

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.white,
      cardColor: const Color(0xFF373737),
      scaffoldBackgroundColor: Color(0xFF1B1B1B),

      primaryColorLight: const Color(0xFF373737), // textField - search


      textTheme: const TextTheme(
        headline1: TextStyle(fontSize: 21, color: Colors.white, fontWeight: FontWeight.w600, fontFamily: "inter", letterSpacing: 1),

        headline3: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600, fontFamily: "inter"), // main text Inter-18-SemiBold

        bodyText1: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w400, fontFamily: "inter"), // main text Inter-12-400
        bodyText2: TextStyle(fontSize: 9, color: Colors.black, fontWeight: FontWeight.w400, fontFamily: "inter"), // a small text
      ));
}
