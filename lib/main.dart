import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ssredentore/library/gui_shortcute.dart';
import 'package:ssredentore/library/query_firebase.dart';
import 'package:ssredentore/library/custom_icons_icons.dart';
import 'package:ssredentore/signup.dart';
import 'package:ssredentore/themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SSREDENTORE',
      theme: ThemeClass.lightTheme,
      darkTheme: ThemeClass.darkTheme,
      themeMode: ThemeMode.system,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    QueryFirebase.loginUser(
      username,
      password,
      AppLocalizations.of(context)!.login_failed,
      // AppLocalizations.of(context)!.login_success,
    );
  }

  void _urlLauncher(Uri url) async {
    if (!await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 90.0),
              const Image(image: AssetImage('assets/logo.png'), height: 250),
              const SizedBox(height: 16 * 2.0),

              // Create username field
              GuiShortcut.buildTextField(AppLocalizations.of(context)!.username,
                  _usernameController, Theme.of(context).colorScheme),

              // Create password field
              GuiShortcut.buildTextField(AppLocalizations.of(context)!.password,
                  _passwordController, Theme.of(context).colorScheme, false),

              // Create a row to switch between login and signup
              GuiShortcut.buildRowSwitchLoginSignup(
                  AppLocalizations.of(context)!.dont_have_account,
                  AppLocalizations.of(context)!.signup,
                  context,
                  const SignUpPage()),

              // Create a button to login
              ElevatedButton(
                onPressed: _login,
                child: Text(AppLocalizations.of(context)!.login),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      _urlLauncher(Uri(
                          scheme: 'https',
                          host: 'github.com',
                          path: '/CrazyPingu'));
                    },
                    child: const Icon(CustomIcons.github),
                  ),
                  TextButton(
                    onPressed: () {
                      _urlLauncher(Uri(
                          scheme: 'https',
                          host: 'www.instagram.com',
                          path: '/detu_s'));
                    },
                    child: const Icon(CustomIcons.instagram),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
