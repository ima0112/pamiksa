part of 'register_personal_info_bloc.dart';

abstract class RegisterPersonalInfoEvent extends Equatable {
  const RegisterPersonalInfoEvent();

  @override
  List<Object> get props => [];
}

class SaveUserPersonalInfoEvent extends RegisterPersonalInfoEvent {
  final String fullname;
  final String birthday;

  SaveUserPersonalInfoEvent(this.fullname, this.birthday);
}
