import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/data/repositories/remote/user_repository.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final NavigationService navigationService = locator<NavigationService>();
  final UserRepository userRepository;

  ChangePasswordBloc(this.userRepository) : super(ChangePasswordInitial());

  @override
  Stream<ChangePasswordState> mapEventToState(
    ChangePasswordEvent event,
  ) async* {
    if (event is SendNewPasswordEvent) {
      yield* _mapSendNewPasswordEvent(event);
    }
  }

  Stream<ChangePasswordState> _mapSendNewPasswordEvent(
      SendNewPasswordEvent event) async* {
    try {
      yield ChangingPasswordState();

      await userRepository.changePassword(event.password);

      yield PasswordChanged();
      navigationService.navigateWithoutGoBack(Routes.Profile);
    } catch (error) {
      print(error.toString());
    }
  }
}
