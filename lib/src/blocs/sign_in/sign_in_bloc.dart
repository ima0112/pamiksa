import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/register_email/register_email_bloc.dart';
import 'package:pamiksa/src/data/models/device.dart';
import 'package:pamiksa/src/data/repositories/remote/device_repository.dart';
import 'package:pamiksa/src/data/repositories/remote/register_data_repository.dart';
import 'package:pamiksa/src/data/repositories/remote/user_repository.dart';
import 'package:pamiksa/src/data/shared/shared.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
import 'package:pamiksa/src/data/device_info.dart' as deviceInfo;
import 'package:pamiksa/src/ui/navigation/route_paths.dart' as routes;

part 'sign_in_event.dart';

part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final UserRepository userRepository;
  final DeviceRepository deviceRepository;
  final RegisterDataRepository registerDataRepository;
  final NavigationService navigationService = locator<NavigationService>();
  DeviceModel deviceModel = DeviceModel();
  Shared preferences = Shared();
  SignInBloc(
      this.userRepository, this.deviceRepository, this.registerDataRepository)
      : super(SignInInitial());

  @override
  Stream<SignInState> mapEventToState(
    SignInEvent event,
  ) async* {
    if (event is GetRegisterDataEvent) {
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
      GetRegisterDataEvent event) async* {
    try {
      yield WaitingSignInResponseState();

      final response = await this.registerDataRepository.registerData();

      if (response.hasException) {
        yield ConnectionFailedState();
      } else {
        String date = response.data['dateNow'];
        int year = int.parse(date.substring(0, 4)) - 18;
        int month = int.parse(date.substring(5, 7));
        int day = int.parse(date.substring(8));

        preferences.saveInt('year', year);
        preferences.saveInt('month', month);
        preferences.saveInt('day', day);

        List provinces = response.data['provinces'] as List;
        List municipalities = response.data['municipalities'] as List;

        await navigationService.navigateTo(routes.RegisterEmailRoute);
        yield SignInInitial();
      }
    } catch (error) {
      yield ConnectionFailedState();
    }
  }
}
