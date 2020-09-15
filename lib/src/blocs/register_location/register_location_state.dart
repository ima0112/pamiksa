part of 'register_location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState([List props = const []]);

  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class LoadedProvinceMunicipalityState extends LocationState {
  final List<ProvinceModel> results;

  LoadedProvinceMunicipalityState({@required this.results})
      : assert(results != null),
        super([results]);
}

class MunicipalitiesLoadedState extends LocationState {
  final List<MunicipalityModel> results;

  MunicipalitiesLoadedState({@required this.results})
      : assert(results != null),
        super([results]);
}
