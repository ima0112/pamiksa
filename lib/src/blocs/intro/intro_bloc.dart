import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/data/storage/shared.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
import 'package:pamiksa/src/ui/navigation/route_paths.dart' as routes;

part 'intro_event.dart';
part 'intro_state.dart';

class IntroBloc extends Bloc<IntroEvent, IntroState> {
  Shared preferences = Shared();
  final NavigationService navigationService = locator<NavigationService>();
  IntroBloc() : super(IntroInitial());

  @override
  Stream<IntroState> mapEventToState(
    IntroEvent event,
  ) async* {
    if (event is NotShowIntroEvent) {
      yield* _mapNotShowIntroEvent(event);
    }
  }

  Stream<IntroState> _mapNotShowIntroEvent(NotShowIntroEvent event) async* {
    await preferences.saveBool('showIntro', false);
    navigationService.navigateWithoutGoBack(routes.LoginRoute);
  }
}
