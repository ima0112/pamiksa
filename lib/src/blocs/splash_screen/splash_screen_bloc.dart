import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/data/storage/secure_storage.dart';
import 'package:pamiksa/src/data/storage/shared.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';

part 'splash_screen_event.dart';
part 'splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  final NavigationService navigationService = locator<NavigationService>();

  Shared preferences = Shared();
  SecureStorage secureStorage = SecureStorage();

  SplashScreenBloc() : super(SplashScreenInitial());

  @override
  Stream<SplashScreenState> mapEventToState(
    SplashScreenEvent event,
  ) async* {
    if (event is NavigationFromSplashScreenEvent) {
      yield* _mapNavigationFromSplashScreenEvent(event);
    }
  }

  Stream<SplashScreenState> _mapNavigationFromSplashScreenEvent(
      NavigationFromSplashScreenEvent event) async* {
    final showIntro = await preferences.read('showIntro');
    final token = await secureStorage.read(key: 'authToken') ?? null;

    if (showIntro != false) {
      navigationService.navigateWithoutGoBack(Routes.IntroRoute);
    }
    if (token != null) {
      navigationService.navigateWithoutGoBack(Routes.HomeRoute);
    } else if (token == null) {
      navigationService.navigateWithoutGoBack(Routes.LoginRoute);
    }
  }
}
