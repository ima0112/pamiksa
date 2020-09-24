import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:device_info/device_info.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/data/models/device.dart';
import 'package:pamiksa/src/data/models/user.dart';
import 'package:pamiksa/src/data/repositories/remote/user_repository.dart';
import 'package:pamiksa/src/data/storage/secure_storage.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
import 'package:pamiksa/src/data/device_info.dart' as deviceInfo;
import 'package:pamiksa/src/ui/navigation/route_paths.dart' as routes;

part 'register_complete_event.dart';
part 'register_complete_state.dart';

class RegisterCompleteBloc
    extends Bloc<RegisterCompleteEvent, RegisterCompleteState> {
  final UserRepository userRepository;
  final NavigationService navigationService = locator<NavigationService>();

  DeviceModel deviceModel = DeviceModel();
  SecureStorage secureStorage = SecureStorage();

  RegisterCompleteBloc(this.userRepository) : super(RegistercompleteInitial());

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

    event.userModel.fullName = await secureStorage.read('fullname');
    event.userModel.password = await secureStorage.read('password');
    event.userModel.adress = await secureStorage.read('adress');
    event.userModel.birthday = await secureStorage.read('birthday');
    event.userModel.email = await secureStorage.read('email');

    final response =
        await this.userRepository.signUp(event.userModel, deviceModel);

    await secureStorage.remove('password');

    navigationService.navigateAndRemove(routes.HomeRoute);
  }
}
