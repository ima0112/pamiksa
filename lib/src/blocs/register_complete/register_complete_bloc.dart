import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/data/models/device.dart';
import 'package:pamiksa/src/data/models/user.dart';
import 'package:pamiksa/src/data/repositories/remote/user_repository.dart';
import 'package:pamiksa/src/data/storage/secure_storage.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
import 'package:pamiksa/src/data/device_info.dart' as deviceInfo;
import 'package:pamiksa/src/ui/navigation/navigation.dart';

part 'register_complete_event.dart';
part 'register_complete_state.dart';

class RegisterCompleteBloc
    extends Bloc<RegisterCompleteEvent, RegisterCompleteState> {
  final UserRepository userRepository;
  final NavigationService navigationService = locator<NavigationService>();

  UserModel userModel = UserModel();
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
    try {
      userModel = event.userModel;

      await deviceInfo.initPlatformState(deviceModel);

      userModel.fullName = await secureStorage.read(key: 'fullname');
      userModel.password = await secureStorage.read(key: 'password');
      userModel.adress = await secureStorage.read(key: 'adress');
      userModel.birthday = await secureStorage.read(key: 'birthday');
      userModel.email = await secureStorage.read(key: 'email');
      userModel.province = await secureStorage.read(key: 'province');
      userModel.municipality = await secureStorage.read(key: 'municipality');

      final response = await this.userRepository.signUp(userModel, deviceModel);

      if (response.hasException) {
        print(response);
      } else {
        print(response);
      }
      await secureStorage.remove(key: 'password');

      navigationService.navigateAndRemove(Routes.HomeRoute);

      print(userModel.toString());
    } catch (error) {
      yield RegisterCompleteConnectionFailedState();
    }
  }
}
