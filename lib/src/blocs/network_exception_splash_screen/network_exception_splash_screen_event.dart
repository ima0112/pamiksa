part of 'network_exception_splash_screen_bloc.dart';

abstract class NetworkExceptionSplashScreenEvent extends Equatable {
  const NetworkExceptionSplashScreenEvent();
}

class CheckSessionEvent extends NetworkExceptionSplashScreenEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}
