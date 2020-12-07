part of 'favorite_details_bloc.dart';

abstract class FavoriteDetailsState extends Equatable {
  const FavoriteDetailsState();

  @override
  List<Object> get props => [];
}

class FavoriteDetailsInitial extends FavoriteDetailsState {}

class LoadingFavoritesDetailsFoodsState extends FavoriteDetailsState {}

class ErrorFavoriteDetailsState extends FavoriteDetailsState {
  final FavoriteDetailsEvent event;

  ErrorFavoriteDetailsState(this.event);
}

class LoadedFavoritesFoodsDetailsState extends FavoriteDetailsState {
  final int count;
  final FavoriteModel favoriteModel;
  final List<AddonsModel> addonsModel;

  LoadedFavoritesFoodsDetailsState(
      {this.count, this.addonsModel, this.favoriteModel});
}

class LoadedFavoritesFoodsWithOutAddonsState extends FavoriteDetailsState {
  final FavoriteModel favoriteModel;
  final List<AddonsModel> addonsModel;

  LoadedFavoritesFoodsWithOutAddonsState(
      {this.addonsModel, this.favoriteModel});
}
