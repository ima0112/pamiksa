import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:pamiksa/src/ui/navigation/route_paths.dart' as routes;
import 'package:pamiksa/src/ui/views/forgot_password/forgot_password.dart';
import 'package:pamiksa/src/ui/views/forgot_password/forgot_password_email.dart';
import 'package:pamiksa/src/ui/views/forgot_password/forgot_password_verification.dart';
import 'package:pamiksa/src/ui/views/home/conditions.dart';
import 'package:pamiksa/src/ui/views/home/devices.dart';
import 'package:pamiksa/src/ui/views/home/faq.dart';
import 'package:pamiksa/src/ui/views/home/help.dart';
import 'package:pamiksa/src/ui/views/home/home.dart';
import 'package:pamiksa/src/ui/views/home/policy.dart';
import 'package:pamiksa/src/ui/views/home/theme.dart';
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
    case routes.DevicesRoute:
      return createRouter(Devices());
    case routes.RegisterCompleteRoute:
      return createRouter(RegisterCompletePage());
    case routes.VerificationRoute:
      return createRouter(VerificationPage());
    case routes.ThemeRoute:
      return createRouter(ThemePage());
    case routes.ForgotPasswordEmail:
      return createRouter(ForgotPasswordEmailPage());
    case routes.ForgotPasswordVerification:
      return createRouter(ForgotPasswordVerificationPage());
    case routes.ForgotPassword:
      return createRouter(ForgotpasswordPage());
    case routes.HelpRoute:
      return createRouter(HelpPage());
    case routes.PolicyRoute:
      return createRouter(PolicyPage());
    case routes.ConditionsRoute:
      return createRouter(ConditionsPage());
    case routes.FAQRoute:
      return createRouter(FAQPage());
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
