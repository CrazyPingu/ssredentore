import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ssredentore/utilities/gui_shortcut.dart';
import 'package:ssredentore/utilities/shared_preferences.dart';
import 'package:ssredentore/utilities/routes.dart';

class SettingsFragment extends StatefulWidget {
  final ThemeMode selectedTheme;
  final void Function(ThemeMode theme) onThemeChanged;

  const SettingsFragment(this.selectedTheme, this.onThemeChanged, {super.key});

  @override
  State<SettingsFragment> createState() => _SettingsFragmentState();
}

class _SettingsFragmentState extends State<SettingsFragment> {
  ThemeMode selectedTheme = ThemeMode.system;

  @override
  void initState() {
    super.initState();
    selectedTheme = widget.selectedTheme;
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
                      Routes.redirectToLogin(context);
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
                  DropdownMenu<ThemeData>(
                    initialSelection: selectedTheme == ThemeMode.light
                        ? ThemeData.dark()
                        : ThemeData.light(),
                    dropdownMenuEntries: [
                      DropdownMenuEntry(
                          value: ThemeData.light(),
                          label: AppLocalizations.of(context)!.light_theme),
                      DropdownMenuEntry(
                          value: ThemeData.dark(),
                          label: AppLocalizations.of(context)!.dark_theme),
                      // DropdownMenuEntry(
                      //     value: SchedulerBinding.instance.platformDispatcher
                      //                 .platformBrightness ==
                      //             Brightness.dark
                      //         ? ThemeData.dark()
                      //         : ThemeData.light(),
                      //     label: AppLocalizations.of(context)!
                      //         .follow_system_theme),
                    ],
                    onSelected: (ThemeData? theme) {
                      setState(() {
                        selectedTheme = theme == ThemeData.light()
                            ? ThemeMode.light
                            : ThemeMode.dark;
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
