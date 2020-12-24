part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState([List props = const []]);

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class LoadingCartState extends CartState {}

class LoadedCartState extends CartState {
  final List<CartFoodModel> cartFoodModel;

  LoadedCartState({this.cartFoodModel});
}

class CartTokenExpiredState extends CartState {}

class ErrorCartState extends CartState {
  final CartEvent event;

  ErrorCartState(this.event);
}
