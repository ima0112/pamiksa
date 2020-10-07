part of 'business_details_bloc.dart';

abstract class BusinessDetailsEvent extends Equatable {
  const BusinessDetailsEvent();

  @override
  List<Object> get props => [];
}

class FetchBusinessDetails extends BusinessDetailsEvent {
  final String id;

  FetchBusinessDetails(this.id);
}
