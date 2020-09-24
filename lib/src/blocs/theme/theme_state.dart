part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  final ThemeData themeData;

  const ThemeState(this.themeData);

  @override
  List<Object> get props => [];
}

class ThemeInitial extends ThemeState {
  final ThemeData themeData;

  ThemeInitial(this.themeData) : super(null);
}

class LightThemeState extends ThemeState {
  LightThemeState(ThemeData themeData) : super(themeData);
}

class DarkThemeState extends ThemeState {
  DarkThemeState(ThemeData themeData) : super(themeData);
}
