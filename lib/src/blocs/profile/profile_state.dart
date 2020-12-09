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
  List<Object> get props => throw UnimplementedError();
}

class ErrorProfileState extends ProfileState {
  final ProfileEvent event;

  ErrorProfileState(this.event);
  @override
  List<Object> get props => throw UnimplementedError();
}

class CropProfileImageState extends ProfileState {
  @override
  List<Object> get props => throw UnimplementedError();
}

class LoadingProfileState extends ProfileState {
  @override
  List<Object> get props => throw UnimplementedError();
}

class ProfileTokenExpiredState extends ProfileState {
  @override
  List<Object> get props => throw UnimplementedError();
}
