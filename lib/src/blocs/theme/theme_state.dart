part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  final ThemeMode themeMode;

  const ThemeState(this.themeMode);

  @override
  List<Object> get props => [];
}

class ThemeInitial extends ThemeState {
  final ThemeMode themeMode;

  ThemeInitial(this.themeMode) : super(null);
}

class LightThemeState extends ThemeState {
  LightThemeState(ThemeMode themeMode) : super(themeMode);
}

class DarkThemeState extends ThemeState {
  DarkThemeState(ThemeMode themeMode) : super(themeMode);
}
