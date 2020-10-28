import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pamiksa/src/data/storage/shared.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  Shared preferences = Shared();

  ThemeBloc() : super(ThemeInitial(ThemeMode.system));

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is LoadingThemeEvent) {
      yield* _mapLoadingThemeEvent(event);
    }
    if (event is ChangedThemeEvent) {
      yield* _mapChangedThemeEvent(event);
    }
  }

  Stream<ThemeState> _mapLoadingThemeEvent(LoadingThemeEvent event) async* {
    int themeMode = await preferences.read('themeMode') ?? null;
    if (themeMode == 0) {
      yield ThemeInitial(ThemeMode.system);
      await preferences.saveInt('themeMode', 0);
    } else if (themeMode == 1) {
      yield LightThemeState(ThemeMode.light);
      await preferences.saveInt('themeMode', 1);
    } else if (themeMode == 2) {
      yield DarkThemeState(ThemeMode.dark);
      await preferences.saveInt('themeMode', 2);
    } else {
      await preferences.saveInt('themeMode', 0);
    }
  }

  Stream<ThemeState> _mapChangedThemeEvent(ChangedThemeEvent event) async* {
    if (event.val == 0) {
      yield ThemeInitial(ThemeMode.system);
      await preferences.saveInt('themeMode', 0);
    } else if (event.val == 1) {
      yield LightThemeState(ThemeMode.light);
      await preferences.saveInt('themeMode', 1);
    } else if (event.val == 2) {
      yield DarkThemeState(ThemeMode.dark);
      await preferences.saveInt('themeMode', 2);
    }
  }
}
