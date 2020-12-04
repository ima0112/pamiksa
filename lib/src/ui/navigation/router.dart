import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:pamiksa/src/ui/navigation/navigation.dart';
import 'package:pamiksa/src/ui/pages/application_update_page.dart';
import 'package:pamiksa/src/ui/pages/busines_page.dart';
import 'package:pamiksa/src/ui/pages/device_banned_page.dart';
import 'package:pamiksa/src/ui/pages/network_exception_splash_screen_page.dart';
import 'package:pamiksa/src/ui/pages/pages.dart';
import 'package:pamiksa/src/ui/pages/pick_image_page.dart';
import 'package:pamiksa/src/ui/pages/profile_page.dart';
import 'package:pamiksa/src/ui/pages/security_page.dart';

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
      case Routes.ForceApplicationUpdate:
        return createRouter(ApplicationUpdate());
      case Routes.RegisterLocationRoute:
        return createRouter(RegisterLocationPage());
      case Routes.DevicesRoute:
        return createRouter(DevicesPage());
      case Routes.NetworkExceptionSplashScreenRoute:
        return createRouter(NetworkExceptionSplashScreen());
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
      case Routes.BussinesDetailsRoute:
        return createRouter(BusinessPage());
      case Routes.PickImageRoute:
        return createRouter(PickImagePage());
      case Routes.ChangePasswordRoute:
        return createRouter(ChangePasswordPage());
      case Routes.Profile:
        return MaterialPageRoute(builder: (context) => ProfilePage());
      case Routes.HomeRoute:
        return MaterialPageRoute(builder: (context) => HomePage());
      case Routes.SettingRoute:
        return MaterialPageRoute(builder: (context) => SettingsPage());
      case Routes.RootRoute:
        return MaterialPageRoute(builder: (context) => RootPage());
      case Routes.DeviceBannedRoute:
        return MaterialPageRoute(builder: (context) => DeviceBannedpage());
      case Routes.SecurityRoute:
        return MaterialPageRoute(builder: (context) => SecurityPage());
      case Routes.UserBannedRoute:
        return MaterialPageRoute(builder: (context) => UserBannedpage());
      case Routes.FoodRoute:
        return MaterialPageRoute(builder: (context) => FoodPage());
      case Routes.FavoriteDetailsRoute:
        return MaterialPageRoute(builder: (context) => FavoriteDetailsPage());
      case Routes.SearchDetailsRoute:
        return MaterialPageRoute(builder: (context) => SearchDetailsPage());
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
