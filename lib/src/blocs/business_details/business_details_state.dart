part of 'business_details_bloc.dart';

abstract class BusinessDetailsState extends Equatable {
  const BusinessDetailsState();

  @override
  List<Object> get props => [];
}

class BusinessDetailsInitial extends BusinessDetailsState {}

class LoadingBusinessDetailsState extends BusinessDetailsState {}

class LoadedBusinessDetailsState extends BusinessDetailsState {
  final BusinessModel businessModel;

  LoadedBusinessDetailsState(this.businessModel);
}
