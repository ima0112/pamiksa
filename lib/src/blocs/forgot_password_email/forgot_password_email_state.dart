part of 'forgot_password_email_bloc.dart';

abstract class ForgotPasswordEmailState extends Equatable {
  const ForgotPasswordEmailState();

  @override
  List<Object> get props => [];
}

class ForgotPasswordEmailInitial extends ForgotPasswordEmailState {}

class NotExistsUserEmailState extends ForgotPasswordEmailState {}

class LoadingForgotPasswordState extends ForgotPasswordEmailState {}
