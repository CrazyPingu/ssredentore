import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ssredentore/utilities/query_firebase.dart';

class CalendarFragment extends StatefulWidget {
  const CalendarFragment({super.key});

  @override
  State<CalendarFragment> createState() => _CalendarFragmentState();
}

class _CalendarFragmentState extends State<CalendarFragment> {
  List<Map<String, String?>> calendar = [];
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();

    // Assuming QueryFirebase.getCalendar() returns a Future<List<Map<String, String?>>>
    QueryFirebase.getCalendar().then((value) {
      setState(() {
        calendar = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Localizations(
      locale: AppLocalizations.supportedLocales[0],
      delegates: AppLocalizations.localizationsDelegates,
      child: Scaffold(
        body: Center(
          child: PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: calendar.length,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EventCard(
                    city: calendar[index]['city'],
                    date: calendar[index]['date'],
                    field: calendar[index]['field'],
                    scoreTeam1: calendar[index]['scoreTeam1'],
                    scoreTeam2: calendar[index]['scoreTeam2'],
                    team1: calendar[index]['team1'],
                    team2: calendar[index]['team2'],
                    time: calendar[index]['time'],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final String? city;
  final String? date;
  final String? field;
  final String? scoreTeam1;
  final String? scoreTeam2;
  final String? team1;
  final String? team2;
  final String? time;

  const EventCard({
    super.key,
    this.city,
    this.date,
    this.field,
    this.scoreTeam1,
    this.scoreTeam2,
    this.team1,
    this.team2,
    this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('City: $city'),
            Text('Date: $date'),
            Text('Field: $field'),
            Text('Score Team 1: $scoreTeam1'),
            Text('Score Team 2: $scoreTeam2'),
            Text('Team 1: $team1'),
            Text('Team 2: $team2'),
            Text('Time: $time'),
          ],
        ),
      ),
    );
  }
}
