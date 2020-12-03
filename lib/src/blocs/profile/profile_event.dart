part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class FetchProfileEvent extends ProfileEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class SendImageEvent extends ProfileEvent {
  final File file;

  SendImageEvent(this.file);

  @override
  List<Object> get props => throw UnimplementedError();
}

class SetCropProfileEvent extends ProfileEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class SetProfileInitialStateEvent extends ProfileEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class ChangeNameEvent extends ProfileEvent {
  final String name;

  ChangeNameEvent({this.name});
  @override
  List<Object> get props => throw UnimplementedError();
}

class ChangeAdressEvent extends ProfileEvent {
  final String adress;

  ChangeAdressEvent({this.adress});
  @override
  List<Object> get props => throw UnimplementedError();
}

class ChangeEmailEvent extends ProfileEvent {
  final String email;

  ChangeEmailEvent({this.email});
  @override
  List<Object> get props => throw UnimplementedError();
}

class ProfileRefreshTokenEvent extends ProfileEvent {
  final ProfileEvent childEvent;

  ProfileRefreshTokenEvent(this.childEvent);
  @override
  List<Object> get props => throw UnimplementedError();
}

class ReactiveChangeAdressEvent extends ProfileEvent {
  final String adress;

  ReactiveChangeAdressEvent(this.adress);

  @override
  List<Object> get props => throw UnimplementedError();
}
