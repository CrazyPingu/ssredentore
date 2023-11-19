import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ssredentore/home/settings_page.dart';
import 'package:ssredentore/library/custom_icons_icons.dart';
import 'package:ssredentore/utilities/shared_preferences.dart';
import 'package:ssredentore/utilities/themes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late PageController _pageController;
  ThemeMode selectedTheme = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex);

    setState(() {
      SharedPreference.getTheme().then((value) {
        value == ThemeData.dark()
            ? selectedTheme = ThemeMode.dark
            : selectedTheme = ThemeMode.light;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onThemeChanged(ThemeMode theme) {
    setState(() {
      selectedTheme = theme;
    });
  }

  late final List<Widget> _widgetOptions = <Widget>[
    const Text(
      'Index 0: Home',
    ),
    const Text(
      'Index 1: Calendar',
    ),
    SettingsFragment(selectedTheme, _onThemeChanged),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeClass.lightTheme,
      darkTheme: ThemeClass.darkTheme,
      themeMode: selectedTheme,
      home: Localizations(
        locale: AppLocalizations.supportedLocales[0],
        delegates: AppLocalizations.localizationsDelegates,
        child: Scaffold(
          body: PageView(
            controller: _pageController,
            onPageChanged: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            children: _widgetOptions,
          ),
          bottomNavigationBar: NavigationBar(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            destinations: <Widget>[
              NavigationDestination(
                icon: const Icon(CustomIcons.soccerBall),
                label: AppLocalizations.of(context)!.home,
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
          ),
        ),
      ),
    );
  }
}
