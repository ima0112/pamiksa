import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/data/errors.dart';
import 'package:pamiksa/src/data/models/device.dart';
import 'package:pamiksa/src/data/repositories/remote/sessions_repository.dart';
import 'package:pamiksa/src/data/device_info.dart' as deviceInfo;
import 'package:pamiksa/src/data/repositories/remote/user_repository.dart';
import 'package:pamiksa/src/data/storage/secure_storage.dart';

part 'devices_event.dart';

part 'devices_state.dart';

class DevicesBloc extends Bloc<DevicesEvent, DevicesState> {
  final SessionsRepository sessionsRepository;
  final UserRepository userRepository;

  SecureStorage secureStorage = SecureStorage();
  List<DeviceModel> devicesModelList;
  DeviceModel deviceModel = DeviceModel();

  String deviceId;

  DevicesBloc(this.sessionsRepository, this.userRepository)
      : super(DevicesInitial());

  @override
  Stream<DevicesState> mapEventToState(
    DevicesEvent event,
  ) async* {
    if (event is FetchDevicesDataEvent) {
      yield* _mapFetchDevicesDataEvent(event);
    } else if (event is SignOutAllEvent) {
      yield* _mapSignOutAllEvent(event);
    } else if (event is SignOutEvent) {
      yield* _mapSignOutEvent(event);
    } else if (event is DeviceRefreshTokenEvent) {
      yield* _mapDeviceRefreshTokenEvent(event);
    } else if (event is SetDeviceInitialEvent) {
      yield DevicesInitial();
    }
  }

  Stream<DevicesState> _mapFetchDevicesDataEvent(
      FetchDevicesDataEvent event) async* {
    yield LoadingDeviceData();
    try {
      await deviceInfo.initPlatformState(deviceModel);
      final response =
          await sessionsRepository.fetchSessions(deviceModel.deviceId);
      if (response.hasException) {
        if (response.exception.graphqlErrors[0].message ==
            Errors.TokenExpired) {
          add(DeviceRefreshTokenEvent(event));
        } else {
          yield ErrorDevicesState(event);
        }
      } else {
        final List businessData = response.data['devicesByUser'];
        devicesModelList = businessData
            .map((e) => DeviceModel(
                id: e['id'],
                platform: e['platform'],
                systemVersion: e['systemVersion'],
                deviceId: e['deviceId'],
                model: e['model']))
            .toList();
        sessionsRepository.clear();
        devicesModelList.forEach((element) {
          sessionsRepository.insert(element.toMap());
        });
        yield LoadedDevicesState(devicesModelList, deviceModel);
      }
    } catch (error) {
      yield ErrorDevicesState(event);
    }
  }

  Stream<DevicesState> _mapSignOutAllEvent(SignOutAllEvent event) async* {
    try {
      await deviceInfo.initPlatformState(deviceModel);
      final response =
          await sessionsRepository.signOutAll(deviceModel.deviceId);
      if (response.hasException) {
        if (response.exception.graphqlErrors[0].message ==
            Errors.TokenExpired) {
          add(DeviceRefreshTokenEvent(event));
        } else {
          yield ErrorDevicesState(event);
        }
      } else {
        sessionsRepository.clear();
        devicesModelList.clear();
        add(FetchDevicesDataEvent());
      }
    } catch (error) {
      yield ErrorDevicesState(event);
    }
  }

  Stream<DevicesState> _mapSignOutEvent(SignOutEvent event) async* {
    deviceId = event.deviceId;
    try {
      await deviceInfo.initPlatformState(deviceModel);
      final response = await userRepository.signOut(deviceId);
      if (response.hasException) {
        if (response.exception.graphqlErrors[0].message ==
            Errors.TokenExpired) {
          add(DeviceRefreshTokenEvent(event));
        } else {
          yield ErrorDevicesState(event);
        }
      } else {
        await sessionsRepository.deleteById(deviceId);
        devicesModelList.removeWhere((element) => element.deviceId == deviceId);
        add(FetchDevicesDataEvent());
      }
    } catch (error) {
      yield ErrorDevicesState(event);
    }
  }

  Stream<DevicesState> _mapDeviceRefreshTokenEvent(
      DeviceRefreshTokenEvent event) async* {
    try {
      String refreshToken = await secureStorage.read(key: "refreshToken");
      final response = await userRepository.refreshToken(refreshToken);
      if (response.hasException) {
        yield ErrorDevicesState(event);
      } else {
        add(event.childEvent);
      }
    } catch (error) {
      yield ErrorDevicesState(event);
    }
  }
}
