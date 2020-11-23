part of 'devices_bloc.dart';

abstract class DevicesEvent extends Equatable {
  const DevicesEvent();
}

class FetchDevicesDataEvent extends DevicesEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SignOutAllEvent extends DevicesEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SignOutEvent extends DevicesEvent {
  final String deviceId;

  SignOutEvent({this.deviceId});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SetDeviceInitialEvent extends DevicesEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class DeviceRefreshTokenEvent extends DevicesEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
