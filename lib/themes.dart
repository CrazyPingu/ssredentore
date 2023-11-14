import 'package:flutter/material.dart';

class ThemeClass {
  Color lightPrimaryColor = Colors.deepPurple;
  Color lightPrimaryColorAccent = Colors.deepPurpleAccent;
  Color darkPrimaryColor = Colors.deepOrange;
  Color darkPrimaryColorAccent = Colors.deepOrangeAccent;

  static ThemeData lightTheme = ThemeData(
    primaryColor: ThemeData.light().scaffoldBackgroundColor,
    colorScheme: const ColorScheme.light().copyWith(
      primary: _themeClass.lightPrimaryColor,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: ThemeData.dark().scaffoldBackgroundColor,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: _themeClass.darkPrimaryColor,
    ),
  );
}

ThemeClass _themeClass = ThemeClass();
