import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pamiksa/src/blocs/theme/theme_bloc.dart';
import 'package:pamiksa/src/data/models/models.dart';
import 'package:pamiksa/src/data/repositories/remote/remote_repository.dart';
import 'package:pamiksa/src/data/storage/secure_storage.dart';
import 'package:pamiksa/src/data/storage/shared.dart';
import 'package:pamiksa/src/data/device_info.dart' as deviceInfo;
import 'package:pamiksa/src/data/errors.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';

import 'graphql/graphql_config.dart';

class Utils {
  Shared preferences = Shared();

  Future<bool> showIntro() async {
    final showIntro = await preferences.read('showIntro');

    if (showIntro != false) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> checkSession(UserRepository userRepository) async {
    DeviceModel deviceModel = DeviceModel();
    SecureStorage secureStorage = SecureStorage();
    String initialRoute = Routes.HomeRoute;
    await deviceInfo.initPlatformState(deviceModel);
    try {
      final response = await userRepository.checkSession(deviceModel.deviceId);
      if (response.hasException) {
        if (response.exception.graphqlErrors.length > 0) {
          if (response.exception.graphqlErrors[0].message ==
              Errors.BannedDevice) {
            initialRoute = Routes.DeviceBannedRoute;
          } else if (response.exception.graphqlErrors[0].message ==
              Errors.BannedUser) {
            initialRoute = Routes.UserBannedRoute;
          } else if (response.exception.graphqlErrors[0].message ==
              Errors.SessionNotExists) {
            initialRoute = Routes.LoginRoute;
          } else if (response.exception.graphqlErrors[0].message ==
              Errors.RefreshTokenExpired) {
            initialRoute = Routes.LoginRoute;
          } else if (response.exception.graphqlErrors[0].message ==
              Errors.DeprecatedApp) {
            initialRoute = Routes.ForceApplicationUpdate;
          } else if (response.exception.graphqlErrors[0].message ==
              Errors.TokenExpired) {
            final rt = await secureStorage.read(key: 'refreshToken');
            final response = await userRepository.refreshToken(rt);
            if (response.exception != null &&
                response.exception.graphqlErrors[0].message ==
                    Errors.RefreshTokenExpired) {
              secureStorage.remove(key: "authToken");
              secureStorage.remove(key: "refreshToken");
              initialRoute = Routes.LoginRoute;
            } else {
              await checkSession(
                  UserRepository(client: GraphQLConfiguration().clients()));
            }
          }
        } else if (response.exception.clientException != null &&
            response.exception.clientException is NetworkException) {
          initialRoute = Routes.NetworkExceptionSplashScreenRoute;
        }
      } else {
        initialRoute = Routes.HomeRoute;
      }
    } catch (error) {}
    return initialRoute;
  }

  Future<ThemeMode> loadedTheme(BuildContext context) async {
    BlocProvider.of<ThemeBloc>(context).add(LoadingThemeEvent());
    int themeMode = await preferences.read('themeMode') ?? null;
    if (themeMode == 0) {
      await preferences.saveInt('themeMode', 0);
      return ThemeMode.system;
    } else if (themeMode == 1) {
      await preferences.saveInt('themeMode', 1);
      return ThemeMode.light;
    } else if (themeMode == 2) {
      await preferences.saveInt('themeMode', 2);
      return ThemeMode.dark;
    } else {
      await preferences.saveInt('themeMode', 0);
      return ThemeMode.system;
    }
  }
}
