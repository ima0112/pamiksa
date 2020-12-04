part of 'network_exception_splash_screen_bloc.dart';

abstract class NetworkExceptionSplashScreenState extends Equatable {
  const NetworkExceptionSplashScreenState();
}

class NetworkExceptionSplashScreenInitialState
    extends NetworkExceptionSplashScreenState {
  @override
  List<Object> get props => [];
}

class LoadingCheckSessionState extends NetworkExceptionSplashScreenState {
  @override
  List<Object> get props => throw UnimplementedError();
}
