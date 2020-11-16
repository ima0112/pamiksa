part of 'favorite_details_bloc.dart';

abstract class FavoriteDetailsState extends Equatable {
  const FavoriteDetailsState();

  @override
  List<Object> get props => [];
}

class FavoriteDetailsInitial extends FavoriteDetailsState {}

class LoadingFavoritesDetailsFoodsState extends FavoriteDetailsState {}

class FavoriteDetailsConnectionFailed extends FavoriteDetailsState {}

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
