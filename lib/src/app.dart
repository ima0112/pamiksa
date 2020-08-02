import 'package:flutter/material.dart';
import 'package:pamiksa/src/providers/themes/theme_manager.dart';
import 'package:pamiksa/src/providers/themes/consts.dart' show APP_NAME, COLORPRIMARYLIGTH;
import 'package:pamiksa/src/ui/register/register_data.dart';
import 'package:pamiksa/src/ui/intro/intro.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_NAME,
      darkTheme: context.watch<ThemeManager>().themeData,
      theme: context.watch<ThemeManager>().themeData,
      initialRoute: '/intro',
      routes: {
        Intro.URI: (context) => Intro(),
        Register.URI: (context) => Register(),
      },
    );
  }
}
