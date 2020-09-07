import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:pamiksa/src/data/models/user.dart';
import 'package:pamiksa/src/data/repositories/remote/user_repository.dart';
import 'package:pamiksa/src/data/shared/shared.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
import 'package:pamiksa/src/ui/navigation/route_paths.dart' as routes;

part 'register_verification_event.dart';
part 'register_verification_state.dart';

class RegisterVerificationBloc
    extends Bloc<RegisterVerificationEvent, RegisterVerificationState> {
  final UserRepository userRepository;
  final NavigationService navigationService = locator<NavigationService>();
  Shared preferences = Shared();
  RegisterVerificationBloc(this.userRepository)
      : super(RegisterVerificationInitial());

  @override
  Stream<RegisterVerificationState> mapEventToState(
    RegisterVerificationEvent event,
  ) async* {
    if (event is MutateCodeEvent) {
      yield* _mapMutateCodeEvent(event);
    }
    if (event is CheckVerificationCodeEvent) {
      yield* _mapCheckVerificationCodeEvent(event);
    }
  }

  Stream<RegisterVerificationState> _mapMutateCodeEvent(
      MutateCodeEvent event) async* {
    yield RegisterVerificationInitial();

    String email = await preferences.read('email');

    int min = 100000;
    int max = 999999;
    var randomizer = new Random();
    int code = min + randomizer.nextInt(max - min);

    await preferences.saveString('code', code.toString());

    final response =
        await this.userRepository.sendVerificationCode(email, code.toString());

    print({"response": response.data.toString(), "code": code, "email": email});
  }

  Stream<RegisterVerificationState> _mapCheckVerificationCodeEvent(
      CheckVerificationCodeEvent event) async* {
    String code = await preferences.read('code');

    if (event.code == code) {
      navigationService.navigateTo(routes.RegisterCompleteRoute);
    } else {
      yield IncorrectedVerificationCodeState();
    }
  }
}
