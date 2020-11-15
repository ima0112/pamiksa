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
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class LoadingDeviceData extends DevicesState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class DeviceConnectionFailedState extends DevicesState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SignOutAllState extends DevicesState {
  final List<DeviceModel> results;
  final DeviceModel deviceModel;

  SignOutAllState(this.results, this.deviceModel);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SignOutState extends DevicesState {
  final List<DeviceModel> results;
  final DeviceModel deviceModel;

  SignOutState(this.results, this.deviceModel);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class DevicesTokenExpiredState extends DevicesState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
