import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pamiksa/src/blocs/blocs.dart';
import 'package:pamiksa/src/data/models/models.dart';
import 'package:pamiksa/src/data/repositories/remote/remote_repository.dart';
import 'package:pamiksa/src/data/storage/shared.dart';
import 'package:pamiksa/src/data/device_info.dart' as deviceInfo;

class Utils {
  final UserRepository userRepository;

  Shared preferences = Shared();
  DeviceModel deviceModel = DeviceModel();

  Utils(this.userRepository);

  Future<bool> showIntro() async {
    final showIntro = await preferences.read('showIntro');

    if (showIntro != false) {
      return true;
    } else {
      return false;
    }
  }

  Future<String> checkSession() async {
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
}
