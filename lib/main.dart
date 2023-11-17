import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ssredentore/signup.dart';
import 'package:ssredentore/themes.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ssredentore/presentation/custom_icons_icons.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
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

    var response = await http.post(
      Uri.parse('https://detu.ddns.net/redentore/login.php'),
      headers: {"Content-Type": "application/json"},
      body: convert.jsonEncode({
        'username': username,
        'password': password,
      }),
    );

    convert.jsonDecode(response.body)['status'] == 'success'
        ? showToast(const Text('Login Success'))
        : showToast(const Text('Login Failed'));
  }

  void showToast(Text text) {
    Fluttertoast.showToast(
      msg: text.data.toString(),
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  Widget buildTextField(
      String labelText, TextEditingController controller, bool obscureText) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: Theme.of(context).colorScheme.primary),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          border: InputBorder.none,
        ),
      ),
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
              buildTextField(AppLocalizations.of(context)!.username,
                  _usernameController, false),
              const SizedBox(height: 16.0),
              buildTextField(AppLocalizations.of(context)!.password,
                  _passwordController, true),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(AppLocalizations.of(context)!.dont_have_account),
                  const SizedBox(width: 8.0),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpPage(),
                        ),
                      );
                    },
                    child: Text(AppLocalizations.of(context)!.signup),
                  ),
                ],
              ),
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
