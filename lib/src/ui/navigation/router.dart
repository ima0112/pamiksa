import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:pamiksa/src/ui/navigation/route_paths.dart' as routes;
import 'package:pamiksa/src/ui/pages/forgot_password_page.dart';
import 'package:pamiksa/src/ui/pages/forgot_password_email_page.dart';
import 'package:pamiksa/src/ui/pages/forgot_password_verification_page.dart';
import 'package:pamiksa/src/ui/pages/conditions_page.dart';
import 'package:pamiksa/src/ui/pages/devices_page.dart';
import 'package:pamiksa/src/ui/pages/faq_page.dart';
import 'package:pamiksa/src/ui/pages/help_page.dart';
import 'package:pamiksa/src/ui/pages/home_page.dart';
import 'package:pamiksa/src/ui/pages/policy_page.dart';
import 'package:pamiksa/src/ui/pages/theme_page.dart';
import 'package:pamiksa/src/ui/pages/intro_page.dart';
import 'package:pamiksa/src/ui/pages/sign_in_page.dart';
import 'package:pamiksa/src/ui/pages/register_complete_page.dart';
import 'package:pamiksa/src/ui/pages/register_email_page.dart';
import 'package:pamiksa/src/ui/pages/register_location_page.dart';
import 'package:pamiksa/src/ui/pages/register_password_page.dart';
import 'package:pamiksa/src/ui/pages/register_personal_info_page.dart';
import 'package:pamiksa/src/ui/pages/register_verification_page.dart';
import 'package:pamiksa/src/ui/pages/splashScreen/splash_screen.dart';

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
      return createRouter(DevicesPage());
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
      return createRouter(ForgotPasswordPage());
    case routes.HelpRoute:
      return createRouter(HelpPage());
    case routes.PolicyRoute:
      return createRouter(PolicyPage());
    case routes.ConditionsRoute:
      return createRouter(ConditionsPage());
    case routes.FAQRoute:
      return createRouter(FAQPage());
    case routes.HomeRoute:
      return MaterialPageRoute(builder: (context) => HomePage());
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
