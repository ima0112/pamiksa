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

class BusinessFetchedState extends HomeState {
  final List<Business> businessResults;

  BusinessFetchedState({@required this.businessResults})
      : assert(businessResults != null),
        super([businessResults]);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
