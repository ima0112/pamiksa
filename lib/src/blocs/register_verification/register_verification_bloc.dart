import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/data/errors.dart';
import 'package:pamiksa/src/data/repositories/remote/user_repository.dart';
import 'package:pamiksa/src/data/storage/secure_storage.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
import 'package:pamiksa/src/data/random.dart' as random;
import 'package:pamiksa/src/ui/navigation/navigation.dart';

part 'register_verification_event.dart';
part 'register_verification_state.dart';

class RegisterVerificationBloc
    extends Bloc<RegisterVerificationEvent, RegisterVerificationState> {
  final UserRepository userRepository;
  final NavigationService navigationService = locator<NavigationService>();

  SecureStorage secureStorage = SecureStorage();
  String value;

  RegisterVerificationBloc(this.userRepository)
      : super(RegisterVerificationInitial());

  @override
  Stream<RegisterVerificationState> mapEventToState(
    RegisterVerificationEvent event,
  ) async* {
    if (event is RegisterVerificationMutateCodeEvent) {
      yield* _mapMutateCodeEvent(event);
    } else if (event is CheckVerificationCodeEvent) {
      yield* _mapCheckVerificationCodeEvent(event);
    } else if (event is RegisterVerificationRefreshTokenEvent) {
      yield* _mapRegisterVerificationRefreshTokenEvent(event);
    }
  }

  Stream<RegisterVerificationState> _mapMutateCodeEvent(
      RegisterVerificationMutateCodeEvent event) async* {
    yield RegisterVerificationInitial();

    try {
      String email = await secureStorage.read(key: 'email');
      int code = await random.randomCode();

      await secureStorage.save(key: 'code', value: code.toString());

      final response = await this
          .userRepository
          .sendVerificationCode(email, code.toString());

      if (response.hasException) {
        if (response.exception.graphqlErrors[0].message ==
            Errors.TokenExpired) {
          add(RegisterVerificationRefreshTokenEvent());
        } else {
          yield RegisterVerificationConnectionFailedState();
        }
      }

      print(
          {"response": response.data.toString(), "code": code, "email": email});
    } catch (error) {
      yield RegisterVerificationConnectionFailedState();
    }
  }

  Stream<RegisterVerificationState> _mapCheckVerificationCodeEvent(
      CheckVerificationCodeEvent event) async* {
    String code = await secureStorage.read(key: 'code');

    if (event.code == code) {
      secureStorage.remove(key: 'code');
      navigationService.navigateAndRemoveUntil(Routes.RegisterCompleteRoute);
    } else {
      yield IncorrectedVerificationCodeState();
    }
  }

  Stream<RegisterVerificationState> _mapRegisterVerificationRefreshTokenEvent(
      RegisterVerificationRefreshTokenEvent event) async* {
    try {
      String refreshToken = await secureStorage.read(key: "refreshToken");
      final response = await userRepository.refreshToken(refreshToken);
      if (response.hasException) {
        yield RegisterVerificationConnectionFailedState();
      } else {
        add(RegisterVerificationMutateCodeEvent());
      }
    } catch (error) {
      yield RegisterVerificationConnectionFailedState();
    }
  }
}
