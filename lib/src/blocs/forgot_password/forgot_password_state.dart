part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object> get props => [];
}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ChangePasswordLoading extends ForgotPasswordState {}

class ErrorForgotPasswordState extends ForgotPasswordState {
  final ForgotPasswordEvent event;

  ErrorForgotPasswordState(this.event);
}
