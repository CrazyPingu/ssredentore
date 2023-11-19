library;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ssredentore/utilities/flutter_toast.dart';

class QueryFirebase {
  QueryFirebase._();

  static Future<bool> checkIfUserExists(String username,
      [String? textToastFalse, String? textToastTrue]) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .get();

    if (querySnapshot.docs.isNotEmpty && textToastFalse != null) {
      FlutterToast.showToast(textToastFalse);
    } else if (querySnapshot.docs.isEmpty && textToastTrue != null) {
      FlutterToast.showToast(textToastTrue);
    }

    return querySnapshot.docs.isEmpty;
  }

  static Future<bool> loginUser(String username, String password,
      [String? textToastFalse, String? textToastTrue]) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .where('password', isEqualTo: password)
        .get();

    if (querySnapshot.docs.isEmpty && textToastFalse != null) {
      FlutterToast.showToast(textToastFalse);
    } else if (querySnapshot.docs.isNotEmpty && textToastTrue != null) {
      FlutterToast.showToast(textToastTrue);
    }

    return querySnapshot.docs.isNotEmpty;
  }

  static Future<bool> addUser(String username, String password,
      [String? textToastFalse, String? textToastTrue]) async {
    // Check if the user exists
    if (!await checkIfUserExists(username, textToastFalse, textToastTrue)) {
      return false;
    }

    // Add the user
    FirebaseFirestore.instance
        .collection('users')
        .doc(username)
        .set({'username': username, 'password': password, 'token': 100});
    return true;
  }

  static Future<List<Map<String, String?>>> getCalendar() async {
    final query = await FirebaseFirestore.instance.collection('match').get();

    final List<Map<String, String?>> calendar = List.empty(growable: true);

    for (final element in query.docs) {
      final Map<String, String?> map = {};
      map['date'] = element['date'].toString();
      map['time'] = element['time'].toString();
      map['city'] = element['city'].toString();
      map['field'] = element['field'].toString();
      map['team1'] = element['team1'].toString();
      map['team2'] = element['team2'].toString();
      map['scoreTeam1'] = element['scoreTeam1'].toString();
      map['scoreTeam2'] = element['scoreTeam2'].toString();
      calendar.add(map);
    }

    return calendar;
  }
}
