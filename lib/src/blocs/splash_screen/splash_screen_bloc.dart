import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/data/shared/shared.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
import 'package:pamiksa/src/ui/navigation/route_paths.dart' as routes;

part 'splash_screen_event.dart';
part 'splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  Shared preferences = Shared();
  final NavigationService navigationService = locator<NavigationService>();
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
    final token = await preferences.read('token') ?? null;
    if (showIntro != false) {
      navigationService.navigateWithoutGoBack(routes.IntroRoute);
    } else if (token != null) {
      navigationService.navigateWithoutGoBack(routes.HomeRoute);
    } else if (token == null) {
      navigationService.navigateWithoutGoBack(routes.LoginRoute);
    }
  }
}
