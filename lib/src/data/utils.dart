import 'package:flutter/material.dart';
import 'package:pamiksa/src/data/models/models.dart';
import 'package:pamiksa/src/data/repositories/remote/remote_repository.dart';
import 'package:pamiksa/src/data/storage/shared.dart';
import 'package:pamiksa/src/data/device_info.dart' as deviceInfo;
import 'package:pamiksa/src/data/errors.dart';

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

    await deviceInfo.initPlatformState(deviceModel);
    final response = await userRepository.checkSession(deviceModel.deviceId);

    if (response.hasException) {
      String message = response.exception.graphqlErrors[0].message;
      if (message == "Device banned") {
        return "Device banned";
      } else if (message == "Session not exists") {
        return "Session not exists";
      } else if (message == "User banned") {
        return "User banned";
      } else if (message == Errors.TokenExpired) {
        return Errors.TokenExpired;
      } else if (message == Errors.RefreshTokenExpired) {
        return Errors.RefreshTokenExpired;
      }
    }
    return null;
  }

  Future<ThemeMode> loadedTheme() async {
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
