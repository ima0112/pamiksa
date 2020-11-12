import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/data/repositories/remote/user_repository.dart';
import 'package:pamiksa/src/data/storage/secure_storage.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
import 'package:pamiksa/src/data/random.dart' as random;
import 'package:pamiksa/src/ui/navigation/navigation.dart';

part 'forgot_password_verification_event.dart';
part 'forgot_password_verification_state.dart';

class ForgotPasswordVerificationBloc extends Bloc<
    ForgotPasswordVerificationEvent, ForgotPasswordVerificationState> {
  final UserRepository userRepository;
  final NavigationService navigationService = locator<NavigationService>();

  SecureStorage secureStorage = SecureStorage();

  ForgotPasswordVerificationBloc(this.userRepository)
      : super(ForgotPasswordVerificationInitial());

  @override
  Stream<ForgotPasswordVerificationState> mapEventToState(
    ForgotPasswordVerificationEvent event,
  ) async* {
    if (event is MutateCodeFromForgotPasswordEvent) {
      yield* _mapMutateCodeFromForgotPasswordEvent(event);
    }
    if (event is CheckVerificationFromForgotPasswordCodeEvent) {
      yield* _mapCheckVerificationFromForgotPasswordCodeEvent(event);
    }
  }

  Stream<ForgotPasswordVerificationState> _mapMutateCodeFromForgotPasswordEvent(
      MutateCodeFromForgotPasswordEvent event) async* {
    String email = await secureStorage.read(key: 'email');
    int code = await random.randomCode();

    await secureStorage.save(key: 'code', value: code.toString());

    final response =
        await this.userRepository.sendVerificationCode(email, code.toString());
    if (response.hasException) {
      print(response.exception.toString());
    }
    print({"response": response.data, "code": code, "email": email});
  }

  Stream<ForgotPasswordVerificationState>
      _mapCheckVerificationFromForgotPasswordCodeEvent(
          CheckVerificationFromForgotPasswordCodeEvent event) async* {
    String code = await secureStorage.read(key: 'code');

    if (event.code == code) {
      secureStorage.remove(key: 'code');
      navigationService.navigateWithoutGoBack(Routes.ForgotPassword);
    } else {
      yield IncorrectedVerificationToForgotPasswordCodeState();
    }
  }
}
