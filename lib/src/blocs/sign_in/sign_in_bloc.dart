import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/data/models/device.dart';
import 'package:pamiksa/src/data/repositories/remote/device_repository.dart';
import 'package:pamiksa/src/data/repositories/remote/user_repository.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
import 'package:pamiksa/src/data/device_info.dart' as deviceInfo;
import 'package:pamiksa/src/ui/navigation/route_paths.dart' as routes;

part 'sign_in_event.dart';

part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository userRepository;
  final DeviceRepository deviceRepository;
  final NavigationService navigationService = locator<NavigationService>();
  DeviceModel deviceModel = DeviceModel();
  SignInBloc(this.userRepository, this.deviceRepository)
      : super(SignInInitial());

  @override
  Stream<SignInState> mapEventToState(
    SignInEvent event,
  ) async* {
    if (event is CheckConnectionEvent) {
      yield* _mapCheckConnectionEvent(event);
    }
    if (event is MutateSignInEvent) {
      yield* _mapMutateSignInEvent(event);
    }
  }

  Stream<SignInState> _mapMutateSignInEvent(MutateSignInEvent event) async* {
    yield WaitingSignInResponseState();
    try {
      await deviceInfo.initPlatformState(deviceModel);

      final response =
          await this.userRepository.signIn(event.email, event.password);

      String userId = await response.data['signIn']['user']['id'];

      await this.deviceRepository.sendDeviceInfo(deviceModel, userId);

      if (response.hasException) {
        yield CredentialsErrorState();
      } else {
        navigationService.navigateWithoutGoBack(routes.HomeRoute);
      }
    } catch (error) {
      print({"Error": error});
      yield CredentialsErrorState();
    }
  }

  Stream<SignInState> _mapCheckConnectionEvent(
      CheckConnectionEvent event) async* {
    navigationService.navigateTo(routes.RegisterEmailRoute);
    // yield ConnectionFailedState();
    // await Future.delayed(Duration(seconds: 2));
    // yield SignInInitial();
  }
}
