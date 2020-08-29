import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/ui/themes/theme_manager.dart';
import 'package:pamiksa/src/ui/themes/consts.dart' show APP_NAME;
import 'package:pamiksa/src/ui/views/register/register_complete.dart';
import 'package:pamiksa/src/ui/views/register/register_data_person/register.dart';
import 'package:pamiksa/src/ui/views/register/register_data/register_data.dart';
import 'package:pamiksa/src/ui/views/intro/intro.dart';
import 'package:pamiksa/src/ui/views/register/register_location/register_location.dart';
import 'package:pamiksa/src/ui/views/register/verification.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return BlocBuilder<ThemeCubit, ThemeData>(builder: (_, theme) {
      return MaterialApp(
        title: APP_NAME,
        theme: theme,
        initialRoute: '/intro',
        routes: {
          "/intro": (context) => Intro(),
          "/register_data": (context) => RegisterDataPage(),
          "/register_data_person": (context) => RegisterDataPersonPage(),
          "/register_location": (context) => RegisterLocationPage(),
          "/verificar": (context) => VerificationPage(),
          "/register_complete": (context) => RegisterCompletePage()
        },
      );
    });
  }
}
