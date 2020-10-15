part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  final int index;

  const HomeState(this.index, [List props = const []]);
}

class HomeInitial extends HomeState {
  HomeInitial(int index) : super(index);

  @override
  List<Object> get props => [];
}

class BusinessOptionsPulsedState extends HomeState {
  BusinessOptionsPulsedState(int index) : super(index);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class LoadedBusinessState extends HomeState {
  final int index;
  final List<BusinessModel> results;

  LoadedBusinessState(this.index, this.results)
      : assert(results != null && index != null),
        super(0);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class HomeConnectionFailedState extends HomeState {
  HomeConnectionFailedState(int index) : super(index);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ShowFirstState extends HomeState {
  final List<BusinessModel> results;

  ShowFirstState(int index, this.results) : super(index);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ShowSecondState extends HomeState {
  final int count;
  final List<FavoriteModel> favoriteModel;

  ShowSecondState({int index, this.count, this.favoriteModel}) : super(index);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ShowThirdState extends HomeState {
  ShowThirdState(int index) : super(index);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ShowFourState extends HomeState {
  ShowFourState(int index) : super(index);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ShowDevicesState extends HomeState {
  ShowDevicesState(int index) : super(index);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
