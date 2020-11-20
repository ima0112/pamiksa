part of 'register_location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class FetchProvincesEvent extends LocationEvent {}

class LocationMutateCodeEvent extends LocationEvent {
  final String adress;
  final String provinceId;
  final String municipalityId;

  LocationMutateCodeEvent({this.adress, this.provinceId, this.municipalityId});
}

class FetchProvinceMunicipalityDataEvent extends LocationEvent {}

class ProvinceSelectedEvent extends LocationEvent {
  final String provinceFk;

  ProvinceSelectedEvent(this.provinceFk);
}

class LocationRefreshTokenEvent extends LocationEvent {}
