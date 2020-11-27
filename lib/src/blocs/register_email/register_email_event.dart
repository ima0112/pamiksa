part of 'register_email_bloc.dart';

abstract class RegisterEmailEvent extends Equatable {
  const RegisterEmailEvent();

  @override
  List<Object> get props => [];
}

class CheckUserEmailEvent extends RegisterEmailEvent {
  final String email;

  CheckUserEmailEvent(this.email);
}

class SetRegisterEmailInitialEvent extends RegisterEmailEvent {}
