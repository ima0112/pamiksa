part of 'root_bloc.dart';

abstract class RootEvent extends Equatable {
  const RootEvent();
}

class BusinessOptionsPulsed extends RootEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class FetchBusinessEvent extends RootEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class ChangeToInitialStateEvent extends RootEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class LogoutEvent extends RootEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class RefreshTokenEvent extends RootEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}
