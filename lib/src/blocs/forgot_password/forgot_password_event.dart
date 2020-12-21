part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class SaveUserNewPasswordEvent extends ForgotPasswordEvent {
  final String password;

  SaveUserNewPasswordEvent(this.password);
}

class SetInitialForgotPasswordEvent extends ForgotPasswordEvent {}
