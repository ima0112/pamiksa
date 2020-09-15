part of 'sign_in_bloc.dart';

abstract class SignInState extends Equatable {
  const SignInState();
}

class SignInInitial extends SignInState {
  @override
  List<Object> get props => [];
}

class WaitingSignInResponseState extends SignInState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ConnectionFailedState extends SignInState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class CredentialsErrorState extends SignInState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class LoadingSignState extends SignInState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
