part of 'food_bloc.dart';

abstract class FoodState extends Equatable {
  const FoodState();

  @override
  List<Object> get props => [];
}

class FoodInitial extends FoodState {}

class LoadingFoodState extends FoodState {}

class LoadedFoodState extends FoodState {
  final int count;
  final List<FoodModel> foodModel;
  final List<AddonsModel> addonsModel;

  LoadedFoodState({this.addonsModel, this.count, this.foodModel});
}

class FoodTokenExpiredState extends FoodState {}

class FoodConnectionFailedState extends FoodState {}
