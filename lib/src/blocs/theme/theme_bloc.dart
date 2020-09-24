import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pamiksa/src/data/storage/shared.dart';
import 'package:pamiksa/src/ui/themes/theme_manager.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  Shared preferences = Shared();

  ThemeBloc()
      : super(ThemeInitial(WidgetsBinding.instance.window.platformBrightness ==
                Brightness.light
            ? appThemeData[AppTheme.Claro]
            : appThemeData[AppTheme.Oscuro]));

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is LoadedThemeEvent) {
      yield* _mapLoadedThemeEvent(event);
    }
    if (event is ChangedThemeEvent) {
      yield* _mapChangedThemeEvent(event);
    }
  }

  Stream<ThemeState> _mapLoadedThemeEvent(LoadedThemeEvent event) async* {
    int lightMode = await preferences.read('lightMode');
    if (lightMode == 0) {
      if (WidgetsBinding.instance.window.platformBrightness ==
          Brightness.light) {
        yield LightThemeState(appThemeData[AppTheme.Claro]);
        await preferences.saveInt('lightMode', 0);
      }
      if (WidgetsBinding.instance.window.platformBrightness ==
          Brightness.dark) {
        yield DarkThemeState(appThemeData[AppTheme.Oscuro]);
        await preferences.saveInt('lightMode', 0);
      }
    } else if (lightMode == 1) {
      yield LightThemeState(appThemeData[AppTheme.Claro]);
      await preferences.saveInt('lightMode', 1);
    } else if (lightMode == 2) {
      yield DarkThemeState(appThemeData[AppTheme.Oscuro]);
      await preferences.saveInt('lightMode', 2);
    }
  }

  Stream<ThemeState> _mapChangedThemeEvent(ChangedThemeEvent event) async* {
    if (event.val == 0) {
      if (WidgetsBinding.instance.window.platformBrightness ==
          Brightness.light) {
        yield LightThemeState(appThemeData[AppTheme.Claro]);
        await preferences.saveInt('lightMode', 0);
      }
      if (WidgetsBinding.instance.window.platformBrightness ==
          Brightness.dark) {
        yield DarkThemeState(appThemeData[AppTheme.Oscuro]);
        await preferences.saveInt('lightMode', 0);
      }
    } else if (event.val == 1) {
      yield LightThemeState(appThemeData[AppTheme.Claro]);
      await preferences.saveInt('lightMode', 1);
    } else if (event.val == 2) {
      yield DarkThemeState(appThemeData[AppTheme.Oscuro]);
      await preferences.saveInt('lightMode', 2);
    }
  }
}
