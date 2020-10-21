part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class FetchProfileEvent extends ProfileEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
