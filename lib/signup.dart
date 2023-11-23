import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ssredentore/utilities/flutter_toast.dart';
import 'package:ssredentore/utilities/gui_shortcut.dart';
import 'package:ssredentore/firebase/query_firebase.dart';
import 'package:ssredentore/utilities/routes.dart';

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

  Future<void> _signUp() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;
    final String confirmPassword = _confirmPasswordController.text;

    if (confirmPassword != password) {
      FlutterToast.showToast(
          AppLocalizations.of(context)!.passwords_dont_match);
      return;
    }
    if (await QueryFirebase.addUser(
        username,
        password,
        AppLocalizations.of(context)!.user_already_exists,
        AppLocalizations.of(context)!.user_created)) {
      //  redirect to login
      // ignore: use_build_context_synchronously
      Routes.redirectToLogin(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Localizations(
      locale: AppLocalizations.supportedLocales[0],
      delegates: AppLocalizations.localizationsDelegates,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 90.0),
                const Image(image: AssetImage('assets/logo.png'), height: 250),
                const SizedBox(height: GuiShortcut.defaultHeightSizedBox * 2.0),

                // Create username field
                GuiShortcut.buildTextField(
                    AppLocalizations.of(context)!.username,
                    _usernameController,
                    Theme.of(context).colorScheme),

                // Create password field
                GuiShortcut.buildTextField(
                    AppLocalizations.of(context)!.password,
                    _passwordController,
                    Theme.of(context).colorScheme),

                // Create confirm password field
                GuiShortcut.buildTextField(
                    AppLocalizations.of(context)!.confirm_password,
                    _confirmPasswordController,
                    Theme.of(context).colorScheme,
                    false),

                // Add a row with a button to switch to the login page
                GuiShortcut.buildRowSwitchLoginSignup(
                    AppLocalizations.of(context)!.already_have_account,
                    AppLocalizations.of(context)!.login,
                    Routes.redirectToLogin,
                    context),

                // Add a button to sign up
                ElevatedButton(
                  onPressed: _signUp,
                  child: Text(AppLocalizations.of(context)!.signup),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
