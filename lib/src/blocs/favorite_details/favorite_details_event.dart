part of 'favorite_details_bloc.dart';

abstract class FavoriteDetailsEvent extends Equatable {
  const FavoriteDetailsEvent();

  @override
  List<Object> get props => [];
}

class FavoriteDetailsRefreshTokenEvent extends FavoriteDetailsEvent {}

class FetchFavoriteFoodsDetailsEvent extends FavoriteDetailsEvent {
  final String id;

  FetchFavoriteFoodsDetailsEvent(this.id);
}
