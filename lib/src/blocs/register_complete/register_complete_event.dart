part of 'register_complete_bloc.dart';

abstract class RegisterCompleteEvent extends Equatable {
  const RegisterCompleteEvent();

  @override
  List<Object> get props => [];
}

class MutateUserandDeviceEvent extends RegisterCompleteEvent {
  final UserModel userModel;

  MutateUserandDeviceEvent(this.userModel);
}
