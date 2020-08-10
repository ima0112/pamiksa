import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pamiksa/src/providers/themes/theme_manager.dart';
import 'package:pamiksa/src/providers/themes/consts.dart'
    show APP_NAME;
import 'package:pamiksa/src/ui/register/register.dart';
import 'package:pamiksa/src/ui/register/register_data/register_data.dart';
import 'package:pamiksa/src/ui/intro/intro.dart';
import 'package:pamiksa/src/ui/register/register_location/register_location.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: APP_NAME,
      darkTheme: context.watch<ThemeManager>().themeData,
      theme: context.watch<ThemeManager>().themeData,
      initialRoute: '/intro',
      routes: {
        Intro.URI: (context) => Intro(),
        RegisterDataPage.URI: (context) => RegisterDataPage(),
        RegisterLocationPage.URI: (context) => RegisterLocationPage(),
        RegisterPage.URI: (context) => RegisterPage(),
      },
    );
  }
}
