library;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:ssredentore/utilities/flutter_toast.dart';

class QueryFirebase {
  QueryFirebase._();

  final String _usersCollection = 'users';
  final String _matchCollection = 'match';

  static Future<bool> checkIfUserExists(String username,
      [String? textToastFalse, String? textToastTrue]) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection(QueryFirebase._()._usersCollection)
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
        .collection(QueryFirebase._()._usersCollection)
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
        .collection(QueryFirebase._()._usersCollection)
        .doc(username)
        .set({'username': username, 'password': password, 'token': 100});
    return true;
  }

  static Future<List<Map<String, String?>>> getCalendar() async {
    final query = await FirebaseFirestore.instance
        .collection(QueryFirebase._()._matchCollection)
        .get();

    final List<Map<String, String?>> calendar = List.empty(growable: true);

    for (final element in query.docs) {
      if (element['team1'].toString().toLowerCase() == 'riposa' ||
          element['team2'].toString().toLowerCase() == 'riposa') {
        continue;
      }
      final Map<String, String?> map = {};
      map['date'] = element['date'].toString();
      map['time'] = element['time'].toString();
      map['city'] = element['city'].toString();
      map['field'] = element['field'].toString();

      if (element['team1'].toString().toLowerCase() == 'ss redentore asd') {
        map['team1'] = element['team1'].toString();
        map['team2'] = element['team2'].toString();
        map['scoreTeam1'] = element['scoreTeam1'].toString();
        map['scoreTeam2'] = element['scoreTeam2'].toString();
      } else {
        map['team1'] = element['team2'].toString();
        map['team2'] = element['team1'].toString();
        map['scoreTeam1'] = element['scoreTeam2'].toString();
        map['scoreTeam2'] = element['scoreTeam1'].toString();
      }

      calendar.add(map);
    }

    // each element of calendar have a field called 'date' that is a string
    // in the format 'dd-mm-yy' I need to sort the list by date

    calendar.sort((a, b) {
      final dateA = DateFormat('dd-MM-yy').parse(a['date']!);
      final dateB = DateFormat('dd-MM-yy').parse(b['date']!);
      return dateA.compareTo(dateB);
    });

    return calendar;
  }
}
