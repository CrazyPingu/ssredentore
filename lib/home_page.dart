import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // return Localizations(
    //   locale: AppLocalizations.supportedLocales[0],
    //   delegates: AppLocalizations.localizationsDelegates,
    //   child: Scaffold(
    //     body: SingleChildScrollView(),
    //   ),
    // );
    return const Placeholder();
  }
}