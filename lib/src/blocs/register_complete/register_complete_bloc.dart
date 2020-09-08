import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:device_info/device_info.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:pamiksa/src/data/models/device.dart';
import 'package:pamiksa/src/data/models/user.dart';
import 'package:pamiksa/src/data/repositories/remote/device_repository.dart';
import 'package:pamiksa/src/data/repositories/remote/user_repository.dart';
import 'package:pamiksa/src/data/shared/shared.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
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

    await initPlatformState();

    event.userModel.fullName = await preferences.read('fullname');
    event.userModel.password = await preferences.read('password');
    event.userModel.adress = await preferences.read('adress');
    event.userModel.birthday = await preferences.read('birthday');
    event.userModel.email = await preferences.read('email');

    final response = await this.userRepository.signUp(event.userModel);

    String userId = await response.data['signUp']['user']['id'];

    await this.deviceRepository.sendDeviceInfo(deviceModel, userId);

    navigationService.navigateWithoutGoBack(routes.HomeRoute);
  }

  Future<void> initPlatformState() async {
    Map<String, dynamic> deviceData;
    Shared preferences = await Shared();

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        deviceModel.platform = "Android";
        deviceModel.deviceId = androidInfo.id;
        deviceModel.model = '${androidInfo.brand} ' + '${androidInfo.model}';
        deviceModel.systemVersion = androidInfo.version.release;
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }
}
