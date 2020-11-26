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

class ChangeStateToInitialEvent extends FavoriteEvent {}

class SessionExpiredEvent extends FavoriteEvent {}
