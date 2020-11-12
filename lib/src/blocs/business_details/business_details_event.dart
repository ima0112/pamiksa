part of 'business_details_bloc.dart';

abstract class BusinessDetailsEvent extends Equatable {
  const BusinessDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchBusinessDetailsEvent extends BusinessDetailsEvent {
  final String id;

  FetchBusinessDetailsEvent(this.id);
}

class SetInitialBusinessDetailsEvent extends BusinessDetailsEvent {
  final String id;

  SetInitialBusinessDetailsEvent(this.id);
}

class BusinessRefreshTokenEvent extends BusinessDetailsEvent {}
