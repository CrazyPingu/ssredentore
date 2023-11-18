library;

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  SharedPreference._();

  Future<bool> setString(String key, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  Future<void> deleteString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  Future<String> getString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? '';
  }

  static Future<bool> setLogin(String username) async {
    return SharedPreference._().setString('username', username);
  }

  static Future<String> getLogin() async {
    return SharedPreference._().getString('username');
  }

  static Future<void> deleteLogin() async {
    return SharedPreference._().deleteString('username');
  }
}
