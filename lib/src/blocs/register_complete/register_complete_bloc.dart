import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:device_info/device_info.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/data/errors.dart';
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
    } else if (event is RegisterCompleteRefreshTokenEvent) {
      yield* _mapForgotPasswordRefreshTokenEvent(event);
    }
  }

  Stream<RegisterCompleteState> _mapMutateUserandDeviceEvent(
      MutateUserandDeviceEvent event) async* {
    yield SendingUserandDeviceDataState();
    try {
      userModel = event.userModel;

      await deviceInfo.initPlatformState(deviceModel);

      event.userModel.fullName = await secureStorage.read(key: 'fullname');
      event.userModel.password = await secureStorage.read(key: 'password');
      event.userModel.adress = await secureStorage.read(key: 'adress');
      event.userModel.birthday = await secureStorage.read(key: 'birthday');
      event.userModel.email = await secureStorage.read(key: 'email');
      event.userModel.province = await secureStorage.read(key: 'province');
      event.userModel.municipality =
          await secureStorage.read(key: 'municipality');

      final response =
          await this.userRepository.signUp(event.userModel, deviceModel);

      if (response.hasException) {
        if (response.exception.graphqlErrors[0].message ==
            Errors.BannedDevice) {
          navigationService.navigateWithoutGoBack(Routes.DeviceBannedRoute);
        } else if (response.exception.graphqlErrors[0].message ==
            Errors.TokenExpired) {
          add(RegisterCompleteRefreshTokenEvent());
        } else {
          yield RegisterCompleteConnectionFailedState();
        }
      } else {
        await secureStorage.remove(key: 'password');

        navigationService.navigateAndRemove(Routes.HomeRoute);

        print(event.userModel.toString());
      }
    } catch (error) {
      yield RegisterCompleteConnectionFailedState();
    }
  }

  Stream<RegisterCompleteState> _mapForgotPasswordRefreshTokenEvent(
      RegisterCompleteRefreshTokenEvent event) async* {
    try {
      String refreshToken = await secureStorage.read(key: "refreshToken");
      final response = await userRepository.refreshToken(refreshToken);
      if (response.hasException) {
        yield RegisterCompleteConnectionFailedState();
      } else {
        add(MutateUserandDeviceEvent(userModel));
      }
    } catch (error) {
      yield RegisterCompleteConnectionFailedState();
    }
  }
}
