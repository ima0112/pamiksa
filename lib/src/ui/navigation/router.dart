import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:pamiksa/src/ui/navigation/navigation.dart';
import 'package:pamiksa/src/ui/pages/busines_page.dart';
import 'package:pamiksa/src/ui/pages/device_banned_page.dart';
import 'package:pamiksa/src/ui/pages/pages.dart';
import 'package:pamiksa/src/ui/pages/pick_image.dart';
import 'package:pamiksa/src/ui/pages/profile.dart';

class GenerateRoute {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case Routes.SplashRoute:
      //   return MaterialPageRoute(builder: (context) => SplashScreenPage());
      case Routes.IntroRoute:
        return MaterialPageRoute(builder: (context) => IntroPage());
      case Routes.LoginRoute:
        return MaterialPageRoute(builder: (context) => LoginPage());
      case Routes.RegisterEmailRoute:
        return createRouter(RegisterEmailPage());
      case Routes.RegisterPasswordRoute:
        return createRouter(RegisterPasswordPage());
      case Routes.RegisterPersonalInfoRoute:
        return createRouter(RegisterPersonalInfoPage());
      case Routes.RegisterLocationRoute:
        return createRouter(RegisterLocationPage());
      case Routes.DevicesRoute:
        return createRouter(DevicesPage());
      case Routes.RegisterCompleteRoute:
        return createRouter(RegisterCompletePage());
      case Routes.VerificationRoute:
        return createRouter(VerificationPage());
      case Routes.ThemeRoute:
        return createRouter(ThemePage());
      case Routes.ForgotPasswordEmail:
        return createRouter(ForgotPasswordEmailPage());
      case Routes.ForgotPasswordVerification:
        return createRouter(ForgotPasswordVerificationPage());
      case Routes.ForgotPassword:
        return createRouter(ForgotPasswordPage());
      case Routes.HelpRoute:
        return createRouter(HelpPage());
      case Routes.PolicyRoute:
        return createRouter(PolicyPage());
      case Routes.ConditionsRoute:
        return createRouter(ConditionsPage());
      case Routes.FAQRoute:
        return createRouter(FAQPage());
      case Routes.Profile:
        return createRouter(ProfilePage());
      case Routes.BussinesDetailsRoute:
        return createRouter(BusinessPage());
      case Routes.PickImageRoute:
        return createRouter(PickImagePage());
      case Routes.HomeRoute:
        return MaterialPageRoute(builder: (context) => HomePage());
      case Routes.DeviceBanned:
        return MaterialPageRoute(builder: (context) => DeviceBannedpage());
      case Routes.UserBanned:
        return MaterialPageRoute(builder: (context) => UserBannedpage());
    }
  }

  static Route createRouter(dynamic page) {
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
}
