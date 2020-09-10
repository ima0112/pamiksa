part of 'register_location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState([List props = const []]);

  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class LoadedLocationsState extends LocationState {
  final List<ProvinceModel> results;

  LoadedLocationsState({@required this.results})
      : assert(results != null),
        super([results]);

  @override
  String toString() => 'ReposLoaded: { Github Repositories: $results }';
}

class LoadingState extends LocationState {}
