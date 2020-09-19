import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/data/storage/shared.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
import 'package:pamiksa/src/ui/navigation/route_paths.dart' as routes;

part 'register_password_event.dart';
part 'register_password_state.dart';

class RegisterPasswordBloc
    extends Bloc<RegisterPasswordEvent, RegisterPasswordState> {
  final NavigationService navigationService = locator<NavigationService>();
  Shared preferences = Shared();
  RegisterPasswordBloc() : super(RegisterpasswordInitial());

  @override
  Stream<RegisterPasswordState> mapEventToState(
    RegisterPasswordEvent event,
  ) async* {
    if (event is SaveUserPasswordEvent) yield* _mapSaveUserPasswordEvent(event);
  }

  Stream<RegisterPasswordState> _mapSaveUserPasswordEvent(
      SaveUserPasswordEvent event) async* {
    await preferences.saveString('password', event.password);
    print({await preferences.read('password')});
    navigationService.navigateTo(routes.RegisterPersonalInfoRoute);
  }
}
