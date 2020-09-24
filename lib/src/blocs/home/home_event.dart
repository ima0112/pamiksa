part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class BusinessOptionsPulsed extends HomeEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class FetchBusinessEvent extends HomeEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ChangeToInitialStateEvent extends HomeEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class BottomNavigationItemTappedEvent extends HomeEvent {
  final int index;

  BottomNavigationItemTappedEvent(this.index);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class LogoutEvent extends HomeEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ShowedDevicesEvent extends HomeEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
