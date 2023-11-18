library;

import 'package:flutter/material.dart';
import 'package:ssredentore/home_page.dart';
import 'package:ssredentore/main.dart';
import 'package:ssredentore/signup.dart';

class Routes {
  Routes._();

  //! Warning: When using initialRoute, don’t define a home property.
  static const String homeLabel = '/mainPage';
  static const String loginLabel = '/login';
  static const String signupLabel = '/signup';

  static Map<String, WidgetBuilder> getRoutes() {
    return <String, WidgetBuilder>{
      loginLabel: (context) => const LoginPage(),
      homeLabel: (context) => const HomePage(),
      signupLabel: (context) => const SignUpPage(),
    };
  }

  static void _redirect(BuildContext context, String route) {
    Future(() {
      Navigator.pushNamed(context, route);
    });
  }

  static void redirectToLogin(BuildContext context) {
    _redirect(context, loginLabel);
  }

  static void redirectToHome(BuildContext context) {
    _redirect(context, homeLabel);
  }

  static void redirectToSignup(BuildContext context) {
    _redirect(context, signupLabel);
  }
}
