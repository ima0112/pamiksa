part of 'business_details_bloc.dart';

abstract class BusinessDetailsState extends Equatable {
  const BusinessDetailsState();

  @override
  List<Object> get props => [];
}

class BusinessDetailsInitial extends BusinessDetailsState {
  final String id;

  BusinessDetailsInitial(this.id);
}

class LoadingBusinessDetailsState extends BusinessDetailsState {}

class ErrorBusinessDetailsState extends BusinessDetailsState {
  final BusinessDetailsEvent event;

  ErrorBusinessDetailsState(this.event);
}

class LoadedBusinessDetailsState extends BusinessDetailsState {
  final BusinessModel businessModel;
  final List<FoodModel> foodModel;

  LoadedBusinessDetailsState({this.businessModel, this.foodModel});
}

class BusinessTokenExpired extends BusinessDetailsState {}
