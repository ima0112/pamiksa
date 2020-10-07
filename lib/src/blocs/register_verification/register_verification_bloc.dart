import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
  RegisterVerificationBloc(this.userRepository)
      : super(RegisterVerificationInitial());

  @override
  Stream<RegisterVerificationState> mapEventToState(
    RegisterVerificationEvent event,
  ) async* {
    if (event is RegisterVerificationMutateCodeEvent) {
      yield* _mapMutateCodeEvent(event);
    }
    if (event is CheckVerificationCodeEvent) {
      yield* _mapCheckVerificationCodeEvent(event);
    }
  }

  Stream<RegisterVerificationState> _mapMutateCodeEvent(
      RegisterVerificationMutateCodeEvent event) async* {
    yield RegisterVerificationInitial();

    String email = await secureStorage.read('email');
    int code = await random.randomCode();

    await secureStorage.save('code', code.toString());

    final response =
        await this.userRepository.sendVerificationCode(email, code.toString());

    print({"response": response.data.toString(), "code": code, "email": email});
  }

  Stream<RegisterVerificationState> _mapCheckVerificationCodeEvent(
      CheckVerificationCodeEvent event) async* {
    String code = await secureStorage.read('code');

    if (event.code == code) {
      secureStorage.remove('code');
      navigationService.navigateAndRemoveUntil(Routes.RegisterCompleteRoute);
    } else {
      yield IncorrectedVerificationCodeState();
    }
  }
}
