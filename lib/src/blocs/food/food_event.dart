part of 'food_bloc.dart';

abstract class FoodEvent extends Equatable {
  const FoodEvent();

  @override
  List<Object> get props => [];
}

class FetchFoodEvent extends FoodEvent {
  final String id;

  FetchFoodEvent(this.id);
}

class FoodRefreshTokenEvent extends FoodEvent {
  final FoodEvent childEvent;

  FoodRefreshTokenEvent(this.childEvent);
}

class ToggleFavoriteEvent extends FoodEvent {
  final int isFavorite;
  final String foodFk;

  ToggleFavoriteEvent(this.isFavorite, this.foodFk);
}

class ToggleIconViewFavoriteEvent extends FoodEvent {
  final String foodFk;

  ToggleIconViewFavoriteEvent(this.foodFk);
}

class SetInitialFoodEvent extends FoodEvent {
  final String foodFk;

  SetInitialFoodEvent(this.foodFk);
}
