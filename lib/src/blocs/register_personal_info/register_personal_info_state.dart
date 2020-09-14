part of 'register_personal_info_bloc.dart';

abstract class RegisterPersonalInfoState extends Equatable {
  const RegisterPersonalInfoState();

  @override
  List<Object> get props => [];
}

class RegisterPersonalInfoInitial extends RegisterPersonalInfoState {}

class DateTakenState extends RegisterPersonalInfoState {
  final int year;
  final int month;
  final int day;

  DateTakenState(this.year, this.month, this.day);
}

class DateSelectedState extends RegisterPersonalInfoState {}

class LoadingState extends RegisterPersonalInfoState {}
