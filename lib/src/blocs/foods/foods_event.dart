part of 'foods_bloc.dart';

abstract class FoodsEvent extends Equatable {
  const FoodsEvent();

  @override
  List<Object> get props => [];
}

class FetchFoodsEvent extends FoodsEvent {
  final String id;

  FetchFoodsEvent(this.id);
}
