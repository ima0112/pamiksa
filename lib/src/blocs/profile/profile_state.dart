part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState([List props = const []]);
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileConnectionFailedState extends ProfileState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class LoadedProfileState extends ProfileState {
  final UserModel results;

  LoadedProfileState(this.results);

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
