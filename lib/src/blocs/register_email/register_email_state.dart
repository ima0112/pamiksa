part of 'register_email_bloc.dart';

abstract class RegisterEmailState extends Equatable {
  const RegisterEmailState();

  @override
  List<Object> get props => [];
}

class RegisterEmailInitial extends RegisterEmailState {}

class ExistsUserEmailState extends RegisterEmailState {}

class NotExistsUserEmailState extends RegisterEmailState {}

class LoadingState extends RegisterEmailState {}
