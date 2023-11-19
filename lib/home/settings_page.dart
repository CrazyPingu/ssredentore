import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ssredentore/utilities/gui_shortcut.dart';
import 'package:ssredentore/utilities/shared_preferences.dart';
import 'package:ssredentore/utilities/routes.dart';

class SettingsFragment extends StatefulWidget {
  final ThemeMode selectedTheme;
  final void Function(ThemeMode theme) onThemeChanged;
  final BuildContext contextPassed;

  const SettingsFragment(
      this.selectedTheme, this.onThemeChanged, this.contextPassed,
      {super.key});

  @override
  State<SettingsFragment> createState() => _SettingsFragmentState();
}

class _SettingsFragmentState extends State<SettingsFragment> {
  ThemeMode selectedTheme = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    selectedTheme = widget.selectedTheme;
    SharedPreference.getTheme().then((value) {
      selectedTheme = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Localizations(
      locale: AppLocalizations.supportedLocales[0],
      delegates: AppLocalizations.localizationsDelegates,
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      SharedPreference.deleteLogin();
                      Routes.redirectToLogin(widget.contextPassed);
                    },
                    child: Text(AppLocalizations.of(context)!.logout),
                  ),

                  const SizedBox(height: GuiShortcut.defaultHeightSizedBox * 2),
                  Text(
                    AppLocalizations.of(context)!.select_theme,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: GuiShortcut.defaultHeightSizedBox),

                  // Create a dropdown to select the theme
                  DropdownMenu<ThemeMode>(
                    initialSelection: selectedTheme,
                    dropdownMenuEntries: [
                      DropdownMenuEntry(
                          value: ThemeMode.light,
                          label: AppLocalizations.of(context)!.light_theme),
                      DropdownMenuEntry(
                          value: ThemeMode.dark,
                          label: AppLocalizations.of(context)!.dark_theme),
                      DropdownMenuEntry(
                          value: ThemeMode.system,
                          label: AppLocalizations.of(context)!
                              .follow_system_theme),
                    ],
                    onSelected: (ThemeMode? theme) {
                      setState(() {
                        selectedTheme = theme!;
                        widget.onThemeChanged(selectedTheme);
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
