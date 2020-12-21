part of 'register_email_bloc.dart';

abstract class RegisterEmailState extends Equatable {
  const RegisterEmailState();

  @override
  List<Object> get props => [];
}

class RegisterEmailInitial extends RegisterEmailState {}

class ExistsUserEmailState extends RegisterEmailState {}

class RegisterEmailLoadingState extends RegisterEmailState {}

class ErrorRegisterEmailState extends RegisterEmailState {
  final RegisterEmailEvent event;

  ErrorRegisterEmailState(this.event);
}
