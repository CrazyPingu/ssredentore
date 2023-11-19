library;

import 'package:flutter/material.dart';

class ThemeClass {
  ThemeClass._();

  final Color _lightPrimaryColor = const Color.fromARGB(255, 48, 44, 140);
  final Color _lightSecondaryColor = const Color.fromARGB(255, 71, 74, 140);
  final Color _lightTertiaryColor = const Color.fromARGB(255, 196, 188, 204);
  final Color _lightBackgroundColor = const Color.fromARGB(255, 196, 188, 204);

  final Color _darkPrimaryColor = Colors.deepOrange;
  final Color _darkSecondaryColor = Colors.deepOrangeAccent;
  final Color _darkTertiaryColor = const Color.fromARGB(255, 42, 40, 40);
  final Color _darkBackgroundColor = const Color.fromARGB(255, 30, 29, 29);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: ThemeClass._()._lightPrimaryColor,

    // set the theme for color scheme
    colorScheme: const ColorScheme.light().copyWith(
      primary: ThemeClass._()._lightPrimaryColor,
      onPrimary: Colors.white,
      secondary: ThemeClass._()._lightSecondaryColor,
      tertiary: ThemeClass._()._lightTertiaryColor,
      background: ThemeClass._()._lightBackgroundColor,
    ),

    // set the button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(ThemeClass._()._lightPrimaryColor),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
    ),

    // set the navigation bar theme
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: ThemeClass._()._lightTertiaryColor,
      indicatorColor: ThemeClass._()._lightPrimaryColor,
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
    ),

    // set the card theme
    cardTheme: CardTheme(
      color: ThemeClass._()._lightTertiaryColor,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    primaryColor: ThemeClass._()._darkPrimaryColor,

    // set the theme for color scheme
    colorScheme: const ColorScheme.dark().copyWith(
      primary: ThemeClass._()._darkPrimaryColor,
      onPrimary: Colors.white,
      secondary: ThemeClass._()._darkSecondaryColor,
      tertiary: ThemeClass._()._darkTertiaryColor,
      background: ThemeClass._()._darkBackgroundColor,
    ),

    // set the button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color>(ThemeClass._()._darkPrimaryColor),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
    ),

    // set the navigation bar theme
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: ThemeClass._()._darkTertiaryColor,
      indicatorColor: ThemeClass._()._darkPrimaryColor,
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
    ),

    // set the card theme
    cardTheme: CardTheme(
      color: ThemeClass._()._darkTertiaryColor,
    ),
  );
}
