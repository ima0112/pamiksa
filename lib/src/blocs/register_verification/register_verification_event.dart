part of 'register_verification_bloc.dart';

abstract class RegisterVerificationEvent extends Equatable {
  const RegisterVerificationEvent();

  @override
  List<Object> get props => [];
}

class RegisterVerificationMutateCodeEvent extends RegisterVerificationEvent {}

class CheckVerificationCodeEvent extends RegisterVerificationEvent {
  final String code;

  CheckVerificationCodeEvent({this.code});
}

class RegisterVerificationRefreshTokenEvent extends RegisterVerificationEvent {}
