import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/data/errors.dart';
import 'package:pamiksa/src/data/storage/secure_storage.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
import 'package:pamiksa/src/data/repositories/remote/user_repository.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';

part 'register_email_event.dart';
part 'register_email_state.dart';

class RegisterEmailBloc extends Bloc<RegisterEmailEvent, RegisterEmailState> {
  final UserRepository userRepository;
  final NavigationService navigationService = locator<NavigationService>();

  SecureStorage secureStorage = SecureStorage();
  RegisterEmailBloc(this.userRepository) : super(RegisterEmailInitial());
  String email;

  @override
  Stream<RegisterEmailState> mapEventToState(
    RegisterEmailEvent event,
  ) async* {
    if (event is CheckUserEmailEvent) {
      yield* _mapCheckUserEmailEvent(event);
    }
    if (event is RegisterEmailRefreshTokenEvent) {
      yield* _mapRegisterEmailRefreshTokenEvent(event);
    }
  }

  Stream<RegisterEmailState> _mapCheckUserEmailEvent(
      CheckUserEmailEvent event) async* {
    yield LoadingState();
    email = event.email;
    try {
      final response = await this.userRepository.userExists(event.email);

      if (response.hasException) {
        if (response.exception.graphqlErrors[0].message ==
            Errors.TokenExpired) {
          add(RegisterEmailRefreshTokenEvent());
        } else {
          yield RegisterEmailConnectionFailedState();
        }
      } else if (response.data['userExists'] == true) {
        yield ExistsUserEmailState();
      } else if (response.data['userExists'] == false) {
        await secureStorage.save(key: 'email', value: event.email);
        print({await secureStorage.read(key: 'email')});
        await navigationService.navigateTo(Routes.RegisterPasswordRoute);
        yield RegisterEmailInitial();
      }
    } catch (error) {
      yield RegisterEmailConnectionFailedState();
    }
  }

  Stream<RegisterEmailState> _mapRegisterEmailRefreshTokenEvent(
      RegisterEmailRefreshTokenEvent event) async* {
    try {
      String refreshToken = await secureStorage.read(key: "refreshToken");

      final response = await userRepository.refreshToken(refreshToken);

      if (response.hasException) {
        yield RegisterEmailConnectionFailedState();
      } else {
        add(CheckUserEmailEvent(email));
      }
    } catch (error) {
      yield RegisterEmailConnectionFailedState();
    }
  }
}
