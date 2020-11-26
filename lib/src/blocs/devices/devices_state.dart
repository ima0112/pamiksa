part of 'devices_bloc.dart';

abstract class DevicesState extends Equatable {
  const DevicesState();
}

class DevicesInitial extends DevicesState {
  @override
  List<Object> get props => [];
}

class LoadedDevicesState extends DevicesState {
  final List<DeviceModel> results;
  final DeviceModel deviceModel;

  LoadedDevicesState(this.results, this.deviceModel);

  @override
  List<Object> get props => throw UnimplementedError();
}

class LoadingDeviceData extends DevicesState {
  @override
  List<Object> get props => throw UnimplementedError();
}

class DeviceConnectionFailedState extends DevicesState {
  @override
  List<Object> get props => throw UnimplementedError();
}

class DevicesTokenExpiredState extends DevicesState {
  @override
  List<Object> get props => throw UnimplementedError();
}
