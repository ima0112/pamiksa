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
    }
  }

  Stream<ForgotPasswordEmailState> _mapCheckPasswordByUserEmailEvent(
      CheckPasswordByUserEmailEvent event) async* {
    yield LoadingForgotPasswordState();
    email = event.email;
    try {
      final response = await this.userRepository.userExists(email);

      if (response.data['userExists'] == true) {
        int code = await random.randomCode();
        print(code);

        await secureStorage.save(key: 'email', value: email);
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
}
