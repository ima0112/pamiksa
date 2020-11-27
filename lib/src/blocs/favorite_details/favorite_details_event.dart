part of 'favorite_details_bloc.dart';

abstract class FavoriteDetailsEvent extends Equatable {
  const FavoriteDetailsEvent();

  @override
  List<Object> get props => [];
}

class FavoriteDetailsRefreshTokenEvent extends FavoriteDetailsEvent {
  final FavoriteDetailsEvent childEvent;

  FavoriteDetailsRefreshTokenEvent(this.childEvent);
}

class FetchFavoriteFoodsDetailsEvent extends FavoriteDetailsEvent {
  final String id;

  FetchFavoriteFoodsDetailsEvent(this.id);
}
