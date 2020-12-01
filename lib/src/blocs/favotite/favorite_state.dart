part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class LoadingFavoritesFoodsState extends FavoriteState {}

class LoadedFavoritesFoodsState extends FavoriteState {
  final int count;
  final List<FavoriteModel> favoriteModel;

  LoadedFavoritesFoodsState({this.count, this.favoriteModel});
}

class FavoriteConnectionFailed extends FavoriteState {}
