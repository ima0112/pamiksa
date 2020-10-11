part of 'foods_bloc.dart';

abstract class FoodsState extends Equatable {
  const FoodsState();

  @override
  List<Object> get props => [];
}

class FoodsInitial extends FoodsState {}

class LoadingFoodsState extends FoodsState {}

class LoadedFoodsState extends FoodsState {
  final int count;
  final List<FoodModel> foodModel;

  LoadedFoodsState({this.foodModel, this.count});
}
