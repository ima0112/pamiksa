part of 'addons_bloc.dart';

abstract class AddonsEvent extends Equatable {
  const AddonsEvent();

  @override
  List<Object> get props => [];
}

class FetchAddonsEvent extends AddonsEvent {
  final String id;

  FetchAddonsEvent(this.id);
}
