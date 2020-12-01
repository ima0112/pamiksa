part of 'food_bloc.dart';

abstract class FoodState extends Equatable {
  const FoodState([List props = const []]);

  @override
  List<Object> get props => [];
}

class FoodInitial extends FoodState {
  final String foodFk;

  FoodInitial(this.foodFk);
}

class LoadingFoodState extends FoodState {}

class LoadedFoodState extends FoodState {
  final int isFavorite;
  final int count;
  final FoodModel foodModel;
  final List<AddonsModel> addonsModel;

  LoadedFoodState(
      {this.isFavorite, this.addonsModel, this.count, this.foodModel});
}

class LoadedFoodWithOutAddonsState extends FoodState {
  final FoodModel foodModel;
  final List<AddonsModel> addonsModel;

  LoadedFoodWithOutAddonsState({this.addonsModel, this.foodModel});
}

class FoodTokenExpiredState extends FoodState {}

class FoodConnectionFailedState extends FoodState {}

class FoodFavoriteEnabledState extends FoodState {}

class FoodFavoriteDisabledState extends FoodState {}

class ToggleFavoriteState extends FoodState {
  final int isFavorite;

  ToggleFavoriteState(this.isFavorite);
}
