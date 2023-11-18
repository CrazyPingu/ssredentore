library;

import 'package:flutter/material.dart';

class ThemeClass {
  ThemeClass._();

  Color lightPrimaryColor = Colors.deepPurple;
  Color lightAccentColor = Colors.deepPurpleAccent;
  Color darkPrimaryColor = Colors.deepOrange;
  Color darkAccentColor = Colors.deepOrangeAccent;

  static ThemeData lightTheme = ThemeData(
    primaryColor: ThemeData.light().scaffoldBackgroundColor,
    colorScheme: const ColorScheme.light().copyWith(
      primary: ThemeClass._().lightPrimaryColor,
      secondary: ThemeClass._().lightAccentColor,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: ThemeData.dark().scaffoldBackgroundColor,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: ThemeClass._().darkPrimaryColor,
      secondary: ThemeClass._().darkAccentColor,
    ),
  );
}
