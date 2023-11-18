import 'package:ssredentore/utilities/flutter_toast.dart';
import 'package:ssredentore/utilities/shared_preferences.dart';
import 'package:ssredentore/utilities/routes.dart';
import 'package:ssredentore/utilities/gui_shortcut.dart';
import 'package:ssredentore/utilities/query_firebase.dart';
import 'package:ssredentore/library/custom_icons_icons.dart';
import 'package:ssredentore/utilities/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'library/firebase_options.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      initialRoute: Routes.loginLabel,
      routes: Routes.getRoutes(),
      theme: ThemeClass.lightTheme,
      darkTheme: ThemeClass.darkTheme,
      themeMode: ThemeMode.system,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;

  Future<void> _login() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      FlutterToast.showToast(AppLocalizations.of(context)!.empty_fields);
      return;
    }

    if (await QueryFirebase.loginUser(
      username,
      password,
      AppLocalizations.of(context)!.login_failed,
      // AppLocalizations.of(context)!.login_success,
    )) {
      // Save the username if the user wants to remain logged in
      _rememberMe
          ? SharedPreference.setLogin(username)
          : SharedPreference.deleteLogin();

      // ignore: use_build_context_synchronously
      Routes.redirectToHome(context);
    }
  }

  void _urlLauncher(Uri url) async {
    if (!await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _checkRedirect() async {
    String login = await SharedPreference.getLogin();
    if (login != '') {
      // ignore: use_build_context_synchronously
      Routes.redirectToHome(context);
    }
  }

  @override
  void initState() {
    super.initState();
    _checkRedirect();
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
                  Routes.redirectToSignup,
                  context),

              // add row remain logged with checkbox
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(AppLocalizations.of(context)!.remember_me),
                  Checkbox(
                    value: _rememberMe,
                    onChanged: (bool? value) {
                      setState(() {
                        _rememberMe = value!;
                      });
                    },
                  ),
                ],
              ),

              // Create a button to login
              ElevatedButton(
                onPressed: _login,
                child: Text(AppLocalizations.of(context)!.login),
              ),
              const SizedBox(height: GuiShortcut.defaultHeightSizedBox),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      _urlLauncher(Uri(
                          scheme: 'https',
                          host: 'www.ssredentore.org',
                          path: '/squadre/calcio-a-5-m/'));
                    },
                    child: const Icon(CustomIcons.soccerBall),
                  ),
                  TextButton(
                    onPressed: () {
                      _urlLauncher(Uri(
                          scheme: 'https',
                          host: 'www.instagram.com',
                          path: '/asdredentorem/'));
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
