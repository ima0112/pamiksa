part of 'register_location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState([List props = const []]);

  @override
  List<Object> get props => [];
}

class LocationInitial extends LocationState {}

class LoadedProvinceMunicipalityState extends LocationState {
  final List<ProvinceModel> results;
  final List<MunicipalityModel> municipalitiesResults;

  LoadedProvinceMunicipalityState(this.results, this.municipalitiesResults);
}

class MunicipalitiesLoadedState extends LocationState {
  final List<MunicipalityModel> results;
  final List<ProvinceModel> provincesResults;

  MunicipalitiesLoadedState(this.results, this.provincesResults);
}

class LoadingProvinceMunicipalityState extends LocationState {}

class LocationConnectionFailedState extends LocationState {}
