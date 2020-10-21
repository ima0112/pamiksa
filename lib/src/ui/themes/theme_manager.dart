import 'package:flutter/material.dart';
import 'package:pamiksa/src/data/storage/shared.dart';

enum AppTheme { Claro, Oscuro }

final appThemeData = {
  ThemeMode.light: ThemeData(
    textTheme: TextTheme(
        bodyText1: TextStyle(color: Colors.black),
        bodyText2: TextStyle(color: Colors.black)),
    chipTheme: ChipThemeData(
        backgroundColor: Colors.grey[200],
        disabledColor: Colors.grey[400],
        selectedColor: Colors.grey[700],
        secondarySelectedColor: Colors.grey[700],
        padding: EdgeInsets.all(4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        labelStyle: TextStyle(color: Colors.black),
        secondaryLabelStyle: TextStyle(color: Colors.black),
        brightness: Brightness.dark),
    backgroundColor: Colors.grey[200],
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.black,
      behavior: SnackBarBehavior.fixed,
    ),
    fontFamily: 'RobotoMono-Regular',
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(bodyText1: TextStyle(color: Colors.black)),
      iconTheme: IconThemeData(color: Colors.black),
      actionsIconTheme: IconThemeData(color: Colors.black),
      color: Colors.white,
      brightness: Brightness.light,
      elevation: 0.0,
    ),
    primarySwatch: Colors.deepPurple,
    cursorColor: Colors.deepPurpleAccent[700],
    hoverColor: Colors.deepPurple[700],
    primaryColor: Colors.deepPurpleAccent[700],
    primaryColorLight: Colors.black12,
    bottomAppBarColor: Colors.deepPurpleAccent[700],
    focusColor: Colors.deepPurpleAccent[700],
    accentColor: Colors.deepPurpleAccent[700],
    cardColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.deepPurpleAccent[700],
        unselectedItemColor: Colors.black45),
    brightness: Brightness.light,
  ),
  ThemeMode.dark: ThemeData(
    toggleableActiveColor: Colors.deepPurple,
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Color(0xff121212)),
    chipTheme: ChipThemeData(
        backgroundColor: Colors.grey[900],
        disabledColor: Colors.grey[400],
        selectedColor: Colors.grey[700],
        secondarySelectedColor: Colors.grey[700],
        padding: EdgeInsets.all(4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        labelStyle: TextStyle(color: Colors.white),
        secondaryLabelStyle: TextStyle(color: Colors.white),
        brightness: Brightness.dark),
    backgroundColor: Colors.grey[900],
    iconTheme: IconThemeData(
      color: Colors.grey,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.black,
      behavior: SnackBarBehavior.fixed,
    ),
    fontFamily: 'RobotoMono-Regular',
    appBarTheme: AppBarTheme(
      textTheme: TextTheme(bodyText1: TextStyle(color: Colors.white)),
      color: Color(0xff121212),
      brightness: Brightness.dark,
      actionsIconTheme: IconThemeData(color: Colors.white),
      elevation: 2.0,
    ),
    primarySwatch: Colors.deepPurple,
    cursorColor: Color(0xff7C4DFF),
    hoverColor: Color(0xff7C4DFF),
    primaryColor: Colors.deepPurple,
    primaryColorLight: Colors.black,
    bottomAppBarColor: Color(0xff7C4DFF),
    focusColor: Color(0xff7C4DFF),
    accentColor: Color(0xff7C4DFF),
    cardColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Color(0xff121212),
        selectedItemColor: Color(0xff7C4DFF),
        unselectedItemColor: Colors.grey),
    brightness: Brightness.dark,
  )
};
