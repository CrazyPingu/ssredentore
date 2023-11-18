import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ssredentore/fragment/settings_page.dart';
import 'package:ssredentore/library/custom_icons_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
    ),
    Text(
      'Index 1: Business',
    ),
    const SettingsFragment(),
  ];

  @override
  Widget build(BuildContext context) {
    // return Placeholder();
    return Localizations(
      locale: AppLocalizations.supportedLocales[0],
      delegates: AppLocalizations.localizationsDelegates,
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: NavigationBar(
          destinations: <Widget>[
            NavigationDestination(
              icon: const Icon(CustomIcons.soccerBall),
              label: 'Home',
            ),
            NavigationDestination(
              icon: const Icon(Icons.calendar_month),
              label: AppLocalizations.of(context)!.calendar,
            ),
            NavigationDestination(
              icon: const Icon(Icons.settings),
              label: AppLocalizations.of(context)!.settings,
            ),
          ],
          indicatorColor: Theme.of(context).colorScheme.secondary,
          selectedIndex: _selectedIndex,
          onDestinationSelected: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
