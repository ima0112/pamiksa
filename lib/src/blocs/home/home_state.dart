part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState([List props = const []]);
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}

class BusinessOptionsPulsedState extends HomeState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class LoadedBusinessState extends HomeState {
  final List<BusinessModel> results;

  LoadedBusinessState({@required this.results})
      : assert(results != null),
        super([results]);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ConnectionFailedState extends HomeState{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}