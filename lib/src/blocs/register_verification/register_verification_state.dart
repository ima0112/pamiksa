part of 'register_verification_bloc.dart';

abstract class RegisterVerificationState extends Equatable {
  const RegisterVerificationState();

  @override
  List<Object> get props => [];
}

class RegisterVerificationInitial extends RegisterVerificationState {}

class IncorrectedVerificationCodeState extends RegisterVerificationState {}
