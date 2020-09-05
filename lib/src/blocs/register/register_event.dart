part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class CheckUserEmailEvent extends RegisterEvent {
  final String email;

  CheckUserEmailEvent(this.email);
}
