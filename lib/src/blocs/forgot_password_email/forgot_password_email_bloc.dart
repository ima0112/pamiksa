import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/data/errors.dart';
import 'package:pamiksa/src/data/random.dart' as random;
import 'package:pamiksa/src/data/repositories/remote/user_repository.dart';
import 'package:pamiksa/src/data/storage/secure_storage.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';

part 'forgot_password_email_event.dart';
part 'forgot_password_email_state.dart';

class ForgotPasswordEmailBloc
    extends Bloc<ForgotPasswordEmailEvent, ForgotPasswordEmailState> {
  final UserRepository userRepository;
  final NavigationService navigationService = locator<NavigationService>();

  SecureStorage secureStorage = SecureStorage();
  String email;

  ForgotPasswordEmailBloc(this.userRepository)
      : super(ForgotPasswordEmailInitial());

  @override
  Stream<ForgotPasswordEmailState> mapEventToState(
    ForgotPasswordEmailEvent event,
  ) async* {
    if (event is CheckPasswordByUserEmailEvent) {
      yield* _mapCheckPasswordByUserEmailEvent(event);
    } else if (event is ForgotPasswordEmailRefreshTokenEvent) {
      yield* _mapForgotPasswordEmailRefreshTokenEvent(event);
    }
  }

  Stream<ForgotPasswordEmailState> _mapCheckPasswordByUserEmailEvent(
      CheckPasswordByUserEmailEvent event) async* {
    yield LoadingForgotPasswordState();
    try {
      email = event.email;

      final response = await this.userRepository.userExists(event.email);

      if (response.hasException) {
        if (response.exception.graphqlErrors[0].message ==
            Errors.TokenExpired) {
          add(ForgotPasswordEmailRefreshTokenEvent());
        } else {
          yield ForgotPasswordEmailConnectionFailedState();
        }
      } else if (response.data['userExists'] == true) {
        int code = await random.randomCode();
        print(code);

        await secureStorage.save(key: 'email', value: event.email);
        print({await secureStorage.read(key: 'email')});
        await secureStorage.save(key: 'code', value: code.toString());
        await navigationService
            .navigateWithoutGoBack(Routes.ForgotPasswordVerification);
        yield ForgotPasswordEmailInitial();
      } else if (response.data['userExists'] == false) {
        yield NotExistsUserEmailState();
      }
    } catch (error) {
      yield ForgotPasswordEmailConnectionFailedState();
    }
  }

  Stream<ForgotPasswordEmailState> _mapForgotPasswordEmailRefreshTokenEvent(
      ForgotPasswordEmailRefreshTokenEvent event) async* {
    try {
      String refreshToken = await secureStorage.read(key: "refreshToken");
      final response = await userRepository.refreshToken(refreshToken);
      if (response.hasException) {
        yield ForgotPasswordEmailConnectionFailedState();
      } else {
        add(CheckPasswordByUserEmailEvent(email));
      }
    } catch (error) {
      yield ForgotPasswordEmailConnectionFailedState();
    }
  }
}
