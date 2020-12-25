part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class FetchCartEvent extends CartEvent {}

class CartRefreshTokenEvent extends CartEvent {
  final CartEvent childEvent;

  CartRefreshTokenEvent(this.childEvent);
}

class SetInitialCartEvent extends CartEvent {}

class EmptyCartEvent extends CartEvent {}
