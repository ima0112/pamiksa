import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pamiksa/src/data/device_info.dart' as deviceInfo;
import 'package:pamiksa/src/data/errors.dart';
import 'package:pamiksa/src/data/models/models.dart';
import 'package:pamiksa/src/data/repositories/remote/user_repository.dart';
import 'package:pamiksa/src/data/storage/secure_storage.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';

part 'network_exception_splash_screen_event.dart';

part 'network_exception_splash_screen_state.dart';

class NetworkExceptionSplashScreenBloc extends Bloc<
    NetworkExceptionSplashScreenEvent, NetworkExceptionSplashScreenState> {
  final UserRepository userRepository;
  final NavigationService navigationService = locator<NavigationService>();
  NetworkExceptionSplashScreenBloc(this.userRepository)
      : super(NetworkExceptionSplashScreenInitialState());

  @override
  Stream<NetworkExceptionSplashScreenState> mapEventToState(
    NetworkExceptionSplashScreenEvent event,
  ) async* {
    if (event is CheckSessionEvent) {
      yield* _mapCheckSessionEvent(event);
    }
  }

  Stream<NetworkExceptionSplashScreenState> _mapCheckSessionEvent(
      NetworkExceptionSplashScreenEvent event) async* {
    DeviceModel deviceModel = DeviceModel();
    SecureStorage secureStorage = SecureStorage();
    await deviceInfo.initPlatformState(deviceModel);
    try {
      yield LoadingCheckSessionState();
      final response = await userRepository.checkSession(deviceModel.deviceId);
      if (response.hasException) {
        if (response.exception.graphqlErrors.length > 0) {
          if (response.exception.graphqlErrors[0].message ==
              Errors.BannedDevice) {
            navigationService.navigateWithoutGoBack(Routes.DeviceBannedRoute);
          } else if (response.exception.graphqlErrors[0].message ==
              Errors.BannedUser) {
            navigationService.navigateWithoutGoBack(Routes.UserBannedRoute);
          } else if (response.exception.graphqlErrors[0].message ==
              Errors.SessionNotExists) {
            navigationService.navigateWithoutGoBack(Routes.LoginRoute);
          } else if (response.exception.graphqlErrors[0].message ==
              Errors.RefreshTokenExpired) {
            navigationService.navigateWithoutGoBack(Routes.LoginRoute);
          } else if (response.exception.graphqlErrors[0].message ==
              Errors.DeprecatedApp) {
            navigationService
                .navigateWithoutGoBack(Routes.ForceApplicationUpdate);
          } else if (response.exception.graphqlErrors[0].message ==
              Errors.TokenExpired) {
            final rt = await secureStorage.read(key: 'refreshToken');
            final response = await userRepository.refreshToken(rt);
            if (response.exception != null &&
                response.exception.graphqlErrors[0].message ==
                    Errors.RefreshTokenExpired) {
              secureStorage.remove(key: "authToken");
              secureStorage.remove(key: "refreshToken");
              navigationService.navigateWithoutGoBack(Routes.LoginRoute);
            } else {
              // Recurisivity
              add(CheckSessionEvent());
            }
          }
        } else if (response.exception.clientException != null &&
            response.exception.clientException is NetworkException) {
          yield NetworkExceptionSplashScreenInitialState();
        }
      } else {
        navigationService.navigateWithoutGoBack(Routes.HomeRoute);
      }
    } catch (error) {}
  }
}
