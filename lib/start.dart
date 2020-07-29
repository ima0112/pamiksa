import 'package:flutter/material.dart';
import 'package:pamiksa/consts.dart' show APP_NAME, COLORPRIMARYLIGTH;
import 'package:pamiksa/register.dart';
import 'package:pamiksa/facebook_login.dart';
import 'package:pamiksa/intro.dart';

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
        Facebook_Login.URI: (context) => Facebook_Login(),
        Register.URI: (context) => Register(),
      },
    );
  }
}
