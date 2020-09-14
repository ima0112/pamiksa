import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ThemeCubit extends Cubit<ThemeData> {
  /// {@macro brightness_cubit}
  ThemeCubit() : super(_lightTheme);

  static final _lightTheme = ThemeData(
    fontFamily: 'RobotoMono-Regular',
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(
      color: Colors.deepPurpleAccent[700],
      brightness: Brightness.light,
      elevation: 0.0,
    ),
    primarySwatch: Colors.deepPurple,
    cursorColor: Colors.deepPurpleAccent[700],
    hoverColor: Colors.deepPurpleAccent[700],
    primaryColor: Colors.deepPurpleAccent[700],
    bottomAppBarColor: Colors.deepPurpleAccent[700],
    focusColor: Colors.deepPurpleAccent[700],
    accentColor: Colors.deepPurpleAccent[700],
    cardColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final _darkTheme = ThemeData(
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
  );
}
