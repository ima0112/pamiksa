part of 'root_bloc.dart';

abstract class RootState extends Equatable {
  const RootState();
}

class HomeInitial extends RootState {
  HomeInitial() : super();

  @override
  List<Object> get props => [];
}

class LoadedBusinessState extends RootState {
  final List<BusinessModel> results;

  LoadedBusinessState(this.results);

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class HomeConnectionFailedState extends RootState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class TokenExpiredState extends RootState {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
