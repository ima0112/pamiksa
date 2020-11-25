import 'package:flutter/material.dart';
import 'package:pamiksa/src/data/storage/shared.dart';

enum AppTheme { Claro, Oscuro }

final appThemeData = {
  ThemeMode.light: ThemeData(
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.deepPurpleAccent[700],
    ),
    dialogTheme: DialogTheme(backgroundColor: Colors.white),
    textTheme: TextTheme(
        bodyText1: TextStyle(color: Colors.black),
        bodyText2: TextStyle(color: Colors.black)),
    chipTheme: ChipThemeData(
        backgroundColor: Colors.grey[200],
        disabledColor: Colors.grey[300],
        selectedColor: Colors.grey[700],
        secondarySelectedColor: Colors.grey[700],
        padding: EdgeInsets.all(4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        labelStyle: TextStyle(color: Colors.black),
        secondaryLabelStyle: TextStyle(color: Colors.black),
        brightness: Brightness.dark),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.white,
    ),
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
      textTheme: TextTheme(
          bodyText1:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      iconTheme: IconThemeData(color: Colors.black),
      actionsIconTheme: IconThemeData(color: Colors.black),
      color: Colors.white,
      brightness: Brightness.light,
      elevation: 1.0,
    ),
    primarySwatch: Colors.deepPurple,
    cursorColor: Colors.deepPurpleAccent[700],
    hoverColor: Colors.deepPurpleAccent[700],
    primaryColor: Colors.deepPurpleAccent[700],
    primaryColorLight: Colors.white,
    bottomAppBarColor: Colors.deepPurpleAccent[700],
    focusColor: Colors.deepPurpleAccent[700],
    accentColor: Colors.deepPurpleAccent[700],
    cardColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    errorColor: Colors.redAccent[700],
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.deepPurpleAccent[700],
        unselectedItemColor: Colors.black45),
    brightness: Brightness.light,
  ),
  ThemeMode.dark: ThemeData(
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.deepPurple[300],
    ),
    dialogTheme: DialogTheme(backgroundColor: Color(0xff121212)),
    toggleableActiveColor: Colors.deepPurple[300],
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Color(0xff121212)),
    errorColor: Colors.red[400],
    chipTheme: ChipThemeData(
        backgroundColor: Colors.grey[850],
        disabledColor: Colors.grey[900],
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
      elevation: 1.0,
    ),
    primarySwatch: Colors.deepPurple,
    cursorColor: Colors.deepPurple[300],
    hoverColor: Colors.deepPurple[300],
    primaryColor: Colors.deepPurple[300],
    primaryColorLight: Color(0xff121212),
    bottomAppBarColor: Colors.deepPurple[300],
    focusColor: Colors.deepPurple[300],
    accentColor: Colors.deepPurple[300],
    cardColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Color(0xff121212),
        selectedItemColor: Colors.deepPurple[300],
        unselectedItemColor: Colors.grey),
    brightness: Brightness.dark,
  )
};
