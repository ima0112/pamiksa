part of 'register_verification_bloc.dart';

abstract class RegisterVerificationEvent extends Equatable {
  const RegisterVerificationEvent();

  @override
  List<Object> get props => [];
}

class MutateUserEvent extends RegisterVerificationEvent {
  final UserModel userModel;

  MutateUserEvent({@required this.userModel});
}
