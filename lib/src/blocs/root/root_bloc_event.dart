part of 'root_bloc.dart';

abstract class RootEvent extends Equatable {
  const RootEvent();
}

class BusinessOptionsPulsed extends RootEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class FetchBusinessEvent extends RootEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ChangeToInitialStateEvent extends RootEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class BottomNavigationItemTappedEvent extends RootEvent {
  final int index;

  BottomNavigationItemTappedEvent(this.index);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class LogoutEvent extends RootEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ShowedDevicesEvent extends RootEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
