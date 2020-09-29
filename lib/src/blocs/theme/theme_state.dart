part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  final ThemeMode themeData;

  const ThemeState(this.themeData);

  @override
  List<Object> get props => [];
}

class ThemeInitial extends ThemeState {
  final ThemeMode themeData;

  ThemeInitial(this.themeData) : super(null);
}

class LightThemeState extends ThemeState {
  LightThemeState(ThemeMode themeData) : super(themeData);
}

class DarkThemeState extends ThemeState {
  DarkThemeState(ThemeMode themeData) : super(themeData);
}
