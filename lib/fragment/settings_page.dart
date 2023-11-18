import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ssredentore/library/shared_preferences.dart';
import 'package:ssredentore/useful/routes.dart';

class SettingsFragment extends StatefulWidget {
  const SettingsFragment({super.key});

  @override
  State<SettingsFragment> createState() => _SettingsFragmentState();
}

class _SettingsFragmentState extends State<SettingsFragment> {
  @override
  Widget build(BuildContext context) {
    return Localizations(
      locale: AppLocalizations.supportedLocales[0],
      delegates: AppLocalizations.localizationsDelegates,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            // add button logout
            child: Column(
              children: <Widget>[
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () {
                    SharedPreference.deleteLogin();
                    Routes.redirectToLogin(context);
                  },
                  child: Text(AppLocalizations.of(context)!.logout),
                ),
              ],
              
            ),
          ),
        ),
      ),
    );
  }
}
