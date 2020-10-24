part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class FetchProfileEvent extends ProfileEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SendImageEvent extends ProfileEvent {
  final File file;

  SendImageEvent(this.file);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SetCropProfileEvent extends ProfileEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class SetProfileInitialStateEvent extends ProfileEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();

}
