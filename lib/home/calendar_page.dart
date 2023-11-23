import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ssredentore/firebase/query_firebase.dart';

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
    return Scaffold(
      body: Center(
        child: PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          itemCount: calendar.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EventCard(
                    city: calendar[index]['city']!,
                    date: calendar[index]['date']!,
                    field: calendar[index]['field']!,
                    scoreTeam1: calendar[index]['scoreTeam1'],
                    scoreTeam2: calendar[index]['scoreTeam2'],
                    team1: calendar[index]['team1']!,
                    team2: calendar[index]['team2']!,
                    time: calendar[index]['time']!,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final String city;
  final String date;
  final String field;
  final String? scoreTeam1;
  final String? scoreTeam2;
  final String team1;
  final String team2;
  final String time;

  const EventCard({
    super.key,
    required this.city,
    required this.date,
    required this.field,
    this.scoreTeam1,
    this.scoreTeam2,
    required this.team1,
    required this.team2,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Localizations(
      locale: AppLocalizations.supportedLocales[0],
      delegates: AppLocalizations.localizationsDelegates,
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(city),
                  Text('${AppLocalizations.of(context)!.date}: $date'),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('${AppLocalizations.of(context)!.time}: $time'),
                ],
              ),
              const SizedBox(height: 30.0),
              Align(
                alignment: Alignment.center,
                child: Text('${AppLocalizations.of(context)!.field}: $field',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 30.0),

              // Create a row to show the score
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(team1),
                      Text(scoreTeam1!),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(team2),
                      Text(scoreTeam2!),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }
}
