part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class FetchProvincesEvent extends LocationEvent {
  final String name;
  final String birthday;

  FetchProvincesEvent(this.name, this.birthday);
}

class MutateCodeEvent extends LocationEvent {
  final String adress;

  MutateCodeEvent(this.adress);
}
