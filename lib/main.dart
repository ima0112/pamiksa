import 'package:flutter/material.dart';
import 'package:pamiksa/intro.dart';
import 'package:pamiksa/consts.dart' show APP_NAME;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: APP_NAME,
      home: Scaffold(
        body: Intro(),
      )
    );
  }
}

