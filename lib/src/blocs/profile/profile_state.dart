part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class LoadedProfileState extends ProfileState {
  final UserModel results;

  LoadedProfileState(this.results);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ProfileConnectionFailedState extends ProfileState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class CropProfileImageState extends ProfileState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class LoadingProfileState extends ProfileState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ChangeNameEvent extends ProfileEvent {
  final String name;

  ChangeNameEvent(this.name);
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ChangeAdressEvent extends ProfileEvent {
  final String adress;

  ChangeAdressEvent(this.adress);
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ChangeEmailEvent extends ProfileEvent {
  final String email;

  ChangeEmailEvent(this.email);
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
