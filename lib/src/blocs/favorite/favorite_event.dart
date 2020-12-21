part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class FetchFavoritesFoodsEvent extends FavoriteEvent {}

class FavoriteRefreshTokenEvent extends FavoriteEvent {
  final FavoriteEvent childEvent;

  FavoriteRefreshTokenEvent(this.childEvent);
}

class SessionExpiredEvent extends FavoriteEvent {}

class DeleteFavoriteEvent extends FavoriteEvent {
  final FavoriteState favoriteState;
  final FavoriteModel favoriteModel;

  DeleteFavoriteEvent(this.favoriteModel, this.favoriteState);
}

class SetInitialFavoriteEvent extends FavoriteEvent {}
