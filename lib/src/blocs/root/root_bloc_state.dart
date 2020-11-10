part of 'root_bloc.dart';

abstract class RootState extends Equatable {
  final int index;

  const RootState(this.index, [List props = const []]);
}

class HomeInitial extends RootState {
  HomeInitial(int index) : super(index);

  @override
  List<Object> get props => [];
}

class BusinessOptionsPulsedState extends RootState {
  BusinessOptionsPulsedState(int index) : super(index);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class LoadedBusinessState extends RootState {
  final int index;
  final List<BusinessModel> results;

  LoadedBusinessState(this.index, this.results)
      : assert(results != null && index != null),
        super(0);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class HomeConnectionFailedState extends RootState {
  HomeConnectionFailedState(int index) : super(index);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ShowFirstState extends RootState {
  final List<BusinessModel> results;

  ShowFirstState(int index, this.results) : super(index);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ShowSecondState extends RootState {
  ShowSecondState(int index) : super(index);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ShowThirdState extends RootState {
  final int count;
  final List<FavoriteModel> favoriteModel;

  ShowThirdState({int index, this.count, this.favoriteModel}) : super(index);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ShowFourState extends RootState {
  ShowFourState(int index) : super(index);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class ShowDevicesState extends RootState {
  ShowDevicesState(int index) : super(index);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class TokenExpiredState extends RootState {
  TokenExpiredState(int index) : super(index);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
