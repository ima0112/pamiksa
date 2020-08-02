import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pamiksa/src//providers/themes/pamiksa_themes.dart';

class ThemeManager with ChangeNotifier {
  ThemeData _themeData = appThemeData[AppTheme.White];
  String _actual = 'White';

  ThemeData get themeData => _themeData;

  String get actual => _actual;

  void setTheme(AppTheme theme) {
    if (theme == AppTheme.White) {
      _actual = 'White';
    } else {
      _actual = 'Dark';
    }
    _themeData = appThemeData[theme];
    notifyListeners();
  }
}
