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
