part of 'change_password_bloc.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
  List<Object> get props => [];
}

class ChangePasswordInitial extends ChangePasswordState {}

class ChangingPasswordState extends ChangePasswordState {}

class PasswordChanged extends ChangePasswordState {}

class ChangePasswordTokenExpiredState extends ChangePasswordState {}

class ChangePasswordConnectionFailedState extends ChangePasswordState {}

class ErrorChangePasswordState extends ChangePasswordState {
  final ChangePasswordEvent event;

  ErrorChangePasswordState(this.event);
}
