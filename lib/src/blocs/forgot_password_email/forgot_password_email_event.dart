part of 'forgot_password_email_bloc.dart';

abstract class ForgotPasswordEmailEvent extends Equatable {
  const ForgotPasswordEmailEvent();

  @override
  List<Object> get props => [];
}

class CheckPasswordByUserEmailEvent extends ForgotPasswordEmailEvent {
  final String email;

  CheckPasswordByUserEmailEvent(this.email);
}
