library;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  SharedPreference._();

  static const String labelDarkTheme = 'dark_theme';
  static const String labelLightTheme = 'light_theme';

  final String _labelUsername = 'username';
  final String _labelTheme = 'theme';

  Future<void> delete(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  Future<bool> setString(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  Future<String> getString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }

  Future<bool> setInt(String key, int value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt(key, value);
  }

  Future<int> getInt(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key) ?? -1;
  }

  static Future<bool> setLogin(String username) async {
    return SharedPreference._()
        .setString(SharedPreference._()._labelUsername, username);
  }

  static Future<String> getLogin() async {
    return SharedPreference._().getString(SharedPreference._()._labelUsername);
  }

  static Future<void> deleteLogin() async {
    return SharedPreference._().delete(SharedPreference._()._labelUsername);
  }

  static Future<ThemeData> getTheme() async {
    String pref =
        await SharedPreference._().getString(SharedPreference._()._labelTheme);
    switch (pref) {
      case SharedPreference.labelLightTheme:
        return ThemeData.light();
      case SharedPreference.labelDarkTheme:
        return ThemeData.dark();
      default:
        return ThemeData();
    }
  }

  static Future<bool> setLightTheme() async {
    return SharedPreference._().setString(
        SharedPreference._()._labelTheme, SharedPreference.labelLightTheme);
  }

  static Future<bool> setDarkTheme() async {
    return SharedPreference._().setString(
        SharedPreference._()._labelTheme, SharedPreference.labelDarkTheme);
  }

  static Future<bool> setSystemTheme() async {
    return SharedPreference._().setString(SharedPreference._()._labelTheme, '');
  }
}
