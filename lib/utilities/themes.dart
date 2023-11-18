library;

import 'package:flutter/material.dart';

class ThemeClass {
  ThemeClass._();

  final Color _lightPrimaryColor = const Color.fromARGB(255, 7, 2, 130);
  final Color _lightBackgroundColor = const Color.fromARGB(255, 196, 188, 204);

  final Color _darkPrimaryColor = Colors.deepOrange;
  final Color _darkBackgroundColor = const Color.fromARGB(255, 42, 40, 40);
  // final Color _darkBackgroundColor = Colors.black;

  static ThemeData lightTheme = ThemeData(
    primaryColor: ThemeData.light().scaffoldBackgroundColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(ThemeClass._()._lightPrimaryColor),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
    ),
    colorScheme: const ColorScheme.light().copyWith(
      primary: ThemeClass._()._lightPrimaryColor,
      background: ThemeClass._()._lightBackgroundColor,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: ThemeData.dark().scaffoldBackgroundColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(ThemeClass._()._darkPrimaryColor),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
    ),
    colorScheme: const ColorScheme.dark().copyWith(
      primary: ThemeClass._()._darkPrimaryColor,
      background: ThemeClass._()._darkBackgroundColor,
    ),
  );
}
