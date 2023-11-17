import 'package:flutter/material.dart';
import 'package:ssredentore/main.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void _signUp() {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    // Add your signup logic here
    // For example, you can send a signup request to your server
  }

  @override
  Widget build(BuildContext context) {
    return Localizations(
        locale: AppLocalizations.supportedLocales[0],
        delegates: AppLocalizations.localizationsDelegates,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 90.0),
                const Image(image: AssetImage('assets/logo.png'), height: 250),
                const SizedBox(height: 16 * 2.0),
                buildTextField(AppLocalizations.of(context)!.username,
                    _usernameController),
                const SizedBox(height: 16.0),
                buildTextField(AppLocalizations.of(context)!.password,
                    _passwordController),
                const SizedBox(height: 16.0),
                buildTextField(AppLocalizations.of(context)!.confirm_password,
                    _confirmPasswordController),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Already have an account?'),
                    const SizedBox(width: 8.0),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyHomePage(),
                          ),
                        );
                      },
                      child: const Text('Login'),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: _signUp,
                  child: const Text('Sign Up'),
                ),
              ],
            ),
          ),
        ));
  }

  Widget buildTextField(
    String labelText,
    TextEditingController controller,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: Theme.of(context).colorScheme.primary),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
