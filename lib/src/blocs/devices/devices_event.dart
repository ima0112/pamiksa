part of 'devices_bloc.dart';

abstract class DevicesEvent extends Equatable {
  const DevicesEvent();
}

class FetchDevicesDataEvent extends DevicesEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class SignOutAllEvent extends DevicesEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class SignOutEvent extends DevicesEvent {
  final String deviceId;

  SignOutEvent({this.deviceId});

  @override
  List<Object> get props => throw UnimplementedError();
}

class SetDeviceInitialEvent extends DevicesEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class DeviceRefreshTokenEvent extends DevicesEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}
