import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:device_info/device_info.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/data/models/device.dart';
import 'package:pamiksa/src/data/models/user.dart';
import 'package:pamiksa/src/data/repositories/remote/device_repository.dart';
import 'package:pamiksa/src/data/repositories/remote/user_repository.dart';
import 'package:pamiksa/src/data/shared/shared.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
import 'package:pamiksa/src/data/device_info.dart' as deviceInfo;
import 'package:pamiksa/src/ui/navigation/route_paths.dart' as routes;

part 'register_complete_event.dart';
part 'register_complete_state.dart';

class RegisterCompleteBloc
    extends Bloc<RegisterCompleteEvent, RegisterCompleteState> {
  final UserRepository userRepository;
  final DeviceRepository deviceRepository;
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  final NavigationService navigationService = locator<NavigationService>();

  DeviceModel deviceModel = DeviceModel();
  Shared preferences = Shared();

  RegisterCompleteBloc(this.userRepository, this.deviceRepository)
      : super(RegistercompleteInitial());

  @override
  Stream<RegisterCompleteState> mapEventToState(
    RegisterCompleteEvent event,
  ) async* {
    if (event is MutateUserandDeviceEvent) {
      yield* _mapMutateUserandDeviceEvent(event);
    }
  }

  Stream<RegisterCompleteState> _mapMutateUserandDeviceEvent(
      MutateUserandDeviceEvent event) async* {
    yield SendingUserandDeviceDataState();

    await deviceInfo.initPlatformState(deviceModel);

    event.userModel.fullName = await preferences.read('fullname');
    event.userModel.password = await preferences.read('password');
    event.userModel.adress = await preferences.read('adress');
    event.userModel.birthday = await preferences.read('birthday');
    event.userModel.email = await preferences.read('email');

    final response = await this.userRepository.signUp(event.userModel);

    String userId = await response.data['signUp']['user']['id'];

    await this.deviceRepository.sendDeviceInfo(deviceModel, userId);

    await preferences.remove('password');

    navigationService.navigateAndRemoveUntil(
        routes.HomeRoute, routes.SplashRoute);
  }
}
