import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/data/storage/secure_storage.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';

part 'register_password_event.dart';
part 'register_password_state.dart';

class RegisterPasswordBloc
    extends Bloc<RegisterPasswordEvent, RegisterPasswordState> {
  final NavigationService navigationService = locator<NavigationService>();
  SecureStorage secureStorage = SecureStorage();
  RegisterPasswordBloc() : super(RegisterpasswordInitial());

  @override
  Stream<RegisterPasswordState> mapEventToState(
    RegisterPasswordEvent event,
  ) async* {
    if (event is SaveUserPasswordEvent) yield* _mapSaveUserPasswordEvent(event);
  }

  Stream<RegisterPasswordState> _mapSaveUserPasswordEvent(
      SaveUserPasswordEvent event) async* {
    await secureStorage.save('password', event.password);
    print({await secureStorage.read('password')});
    navigationService.navigateTo(Routes.RegisterPersonalInfoRoute);
  }
}
