import 'package:flutter/material.dart';

enum AppTheme { White, Dark }

final appThemeData = {
  AppTheme.White: ThemeData(
    fontFamily: 'RobotoMono-Regular',
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      color: Color(0xff6200EA),
      brightness: Brightness.light,
      elevation: 5.0,
    ),
    cursorColor: Color(0xff6200EA),
    hoverColor: Color(0xff6200EA),
    primaryColor: Color(0xff6200EA),
    bottomAppBarColor: Color(0xff6200EA),
    focusColor: Color(0xff6200EA),
    accentColor: Color(0xff6200EA),
    cardColor: Color(0xffffffff),
    scaffoldBackgroundColor: Color(0xffffffff),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  ),
  AppTheme.Dark: ThemeData(
    fontFamily: 'RobotoMono-Regular',
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      color: Color(0xff202020),
      brightness: Brightness.dark,
      elevation: 5.0,
    ),
    hoverColor: Color(0xff7C4DFF),
    primaryColor: Color(0xff7C4DFF),
    bottomAppBarColor: Color(0xff202020),
    focusColor: Color(0xff7C4DFF),
    accentColor: Color(0xff7C4DFF),
    cardColor: Color(0xff202020),
    scaffoldBackgroundColor: Color(0xff121212),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  ),
};
