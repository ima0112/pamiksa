part of 'register_password_bloc.dart';

abstract class RegisterPasswordEvent extends Equatable {
  const RegisterPasswordEvent();

  @override
  List<Object> get props => [];
}

class SaveUserPasswordEvent extends RegisterPasswordEvent {
  final String password;

  SaveUserPasswordEvent(this.password);
}
