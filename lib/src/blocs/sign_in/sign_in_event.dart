part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();
}

class MutateSignInEvent extends SignInEvent {
  final String email;
  final String password;

  MutateSignInEvent({this.email, this.password});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
