part of 'register_complete_bloc.dart';

abstract class RegisterCompleteState extends Equatable {
  const RegisterCompleteState();

  @override
  List<Object> get props => [];
}

class RegistercompleteInitial extends RegisterCompleteState {}

class SendingUserandDeviceDataState extends RegisterCompleteState {}
