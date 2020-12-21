part of 'forgot_password_verification_bloc.dart';

abstract class ForgotPasswordVerificationEvent extends Equatable {
  const ForgotPasswordVerificationEvent();

  @override
  List<Object> get props => [];
}

class MutateCodeFromForgotPasswordEvent
    extends ForgotPasswordVerificationEvent {}

class CheckVerificationFromForgotPasswordCodeEvent
    extends ForgotPasswordVerificationEvent {
  final String code;

  CheckVerificationFromForgotPasswordCodeEvent(this.code);
}

class SetInitialForgotPasswordVerificationEvent
    extends ForgotPasswordVerificationEvent {}
