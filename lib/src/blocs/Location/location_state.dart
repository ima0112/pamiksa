part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState([List props = const []]);

  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class LocationsFetched extends LocationState {
  final List<Province> results;

  LocationsFetched({@required this.results})
      : assert(results != null),
        super([results]);

  @override
  String toString() => 'ReposLoaded: { Github Repositories: $results }';
}
