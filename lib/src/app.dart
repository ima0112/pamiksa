import 'package:flutter/material.dart';
import 'package:pamiksa/src/models/consts.dart' show APP_NAME, COLORPRIMARYLIGTH;
import 'package:pamiksa/src/ui/register/register.dart';
import 'package:pamiksa/src/ui/intro/intro.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_NAME,
      theme: ThemeData(
        primaryColor: COLORPRIMARYLIGTH,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/intro',
      routes: {
        Intro.URI: (context) => Intro(),
        Register.URI: (context) => Register(),
      },
    );
  }
}
