import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/data/errors.dart';
import 'package:pamiksa/src/data/repositories/remote/user_repository.dart';
import 'package:pamiksa/src/data/storage/secure_storage.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final NavigationService navigationService = locator<NavigationService>();
  final UserRepository userRepository;

  SecureStorage secureStorage = SecureStorage();
  String password;

  ChangePasswordBloc(this.userRepository) : super(ChangePasswordInitial());

  @override
  Stream<ChangePasswordState> mapEventToState(
    ChangePasswordEvent event,
  ) async* {
    if (event is SendNewPasswordEvent) {
      yield* _mapSendNewPasswordEvent(event);
    } else if (event is ChangePasswordRefreshTokenEvent) {
      yield* _mapChangePasswordRefreshTokenEvent(event);
    }
  }

  Stream<ChangePasswordState> _mapSendNewPasswordEvent(
      SendNewPasswordEvent event) async* {
    yield ChangingPasswordState();
    password = event.password;
    try {
      final response = await userRepository.changePassword(event.password);

      if (response.hasException) {
        if (response.exception.graphqlErrors[0].message ==
            Errors.TokenExpired) {
          add(ChangePasswordRefreshTokenEvent());
        } else {
          yield ChangePasswordConnectionFailedState();
        }
      }
      navigationService.goBack();
      yield ChangePasswordInitial();
    } catch (error) {
      yield ChangePasswordConnectionFailedState();
    }
  }

  Stream<ChangePasswordState> _mapChangePasswordRefreshTokenEvent(
      ChangePasswordRefreshTokenEvent event) async* {
    try {
      String refreshToken = await secureStorage.read(key: "refreshToken");
      final response = await userRepository.refreshToken(refreshToken);
      if (response.hasException) {
        yield ChangePasswordConnectionFailedState();
      } else {
        add(SendNewPasswordEvent(password));
      }
    } catch (error) {
      yield ChangePasswordConnectionFailedState();
    }
  }
}
