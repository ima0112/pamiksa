part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

class SendNewPasswordEvent extends ChangePasswordEvent {
  final String password;

  SendNewPasswordEvent(this.password);
}

class ChangePasswordRefreshTokenEvent extends ChangePasswordEvent {
  final ChangePasswordEvent childEvent;

  ChangePasswordRefreshTokenEvent(this.childEvent);
}
