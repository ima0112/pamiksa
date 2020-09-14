part of 'register_location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class FetchProvincesEvent extends LocationEvent {}

class MutateCodeEvent extends LocationEvent {
  final String adress;

  MutateCodeEvent(this.adress);
}
