import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/blocs.dart';
import 'package:pamiksa/src/data/models/models.dart';
import 'package:pamiksa/src/data/repositories/remote/remote_repository.dart';
import 'package:pamiksa/src/data/storage/shared.dart';
import 'package:pamiksa/src/data/device_info.dart' as deviceInfo;
import 'package:path/path.dart';

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
      }
    }
    return null;
  }

  Future<ThemeMode> loadedTheme() async {
    int themeMode = await preferences.read('themeMode') ?? null;

    if (themeMode == 0) {
      return ThemeMode.system;
    } else if (themeMode == 1) {
      return ThemeMode.light;
    } else if (themeMode == 2) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }
}
