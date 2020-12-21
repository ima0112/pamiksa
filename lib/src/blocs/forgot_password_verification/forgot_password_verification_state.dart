part of 'forgot_password_verification_bloc.dart';

abstract class ForgotPasswordVerificationState extends Equatable {
  const ForgotPasswordVerificationState();

  @override
  List<Object> get props => [];
}

class ForgotPasswordVerificationInitial
    extends ForgotPasswordVerificationState {}

class IncorrectedVerificationToForgotPasswordCodeState
    extends ForgotPasswordVerificationState {}

class ForgotPasswordVerificationConnectionFailedState
    extends ForgotPasswordVerificationState {}

class ErrorForgotPasswordVerificationState
    extends ForgotPasswordVerificationState {
  final ForgotPasswordVerificationEvent event;

  ErrorForgotPasswordVerificationState(this.event);
}
