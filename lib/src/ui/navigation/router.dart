import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:pamiksa/src/ui/navigation/route_paths.dart' as routes;
import 'package:pamiksa/src/ui/views/home/home.dart';
import 'package:pamiksa/src/ui/views/intro/intro.dart';
import 'package:pamiksa/src/ui/views/login/sign_in.dart';
import 'package:pamiksa/src/ui/views/register/register_complete.dart';
import 'package:pamiksa/src/ui/views/register/register_email.dart';
import 'package:pamiksa/src/ui/views/register/register_location.dart';
import 'package:pamiksa/src/ui/views/register/register_password.dart';
import 'package:pamiksa/src/ui/views/register/register_personal_info.dart';
import 'package:pamiksa/src/ui/views/register/register_verification.dart';
import 'package:pamiksa/src/ui/views/splashScreen/splash_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case routes.SplashRoute:
      return MaterialPageRoute(builder: (context) => SplashScreenPage());
    case routes.IntroRoute:
      return MaterialPageRoute(builder: (context) => IntroPage());
    case routes.LoginRoute:
      return MaterialPageRoute(builder: (context) => LoginPage());
    case routes.RegisterEmailRoute:
      return createRouter(RegisterEmailPage());
    case routes.RegisterPasswordRoute:
      return createRouter(RegisterPasswordPage());
    case routes.RegisterPersonalInfoRoute:
      return createRouter(RegisterPersonalInfoPage());
    case routes.RegisterLocationRoute:
      return createRouter(RegisterLocationPage());
    case routes.RegisterCompleteRoute:
      return createRouter(RegisterCompletePage());
    case routes.VerificationRoute:
      return createRouter(VerificationPage());
    case routes.HomeRoute:
      return MaterialPageRoute(builder: (context) => Home());
  }
}

Route createRouter(dynamic page) {
  return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(50.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      });
}
