import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/data/errors.dart';
import 'package:pamiksa/src/data/models/device.dart';
import 'package:pamiksa/src/data/repositories/remote/user_repository.dart';
import 'package:pamiksa/src/data/storage/secure_storage.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
import 'package:pamiksa/src/data/device_info.dart' as deviceInfo;
import 'package:pamiksa/src/ui/navigation/navigation.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final NavigationService navigationService = locator<NavigationService>();
  final UserRepository userRepository;

  DeviceModel deviceModel = DeviceModel();
  SecureStorage secureStorage = SecureStorage();

  String password;

  ForgotPasswordBloc(this.userRepository) : super(ForgotPasswordInitial());

  @override
  Stream<ForgotPasswordState> mapEventToState(
    ForgotPasswordEvent event,
  ) async* {
    if (event is SaveUserNewPasswordEvent) {
      yield* _mapSaveUserNewPasswordEvent(event);
    } else if (event is SetInitialForgotPasswordEvent) {
      yield ForgotPasswordInitial();
    }
  }

  Stream<ForgotPasswordState> _mapSaveUserNewPasswordEvent(
      SaveUserNewPasswordEvent event) async* {
    yield ChangePasswordLoading();
    try {
      password = event.password;
      String email = await secureStorage.read(key: 'email');

      await secureStorage.save(key: 'password', value: event.password);
      print({await secureStorage.read(key: 'password')});
      await deviceInfo.initPlatformState(deviceModel);

      final response = await userRepository.resetPassword(
          email, event.password, deviceModel);

      await secureStorage.remove(key: 'password');

      navigationService.navigateAndRemove(Routes.HomeRoute);
    } catch (error) {
      yield ErrorForgotPasswordState(event);
    }
  }
}
