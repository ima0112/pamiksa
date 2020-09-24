part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class LoadedThemeEvent extends ThemeEvent {}

class ChangedThemeEvent extends ThemeEvent {
  final int val;

  ChangedThemeEvent(this.val);
}
