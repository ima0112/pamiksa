import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/blocs/blocs.dart';
import 'package:pamiksa/src/data/models/models.dart';
import 'package:pamiksa/src/data/repositories/repositories.dart';

part 'favorite_event.dart';

part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteRepository favoriteRepository;

  List<FavoriteModel> favoriteModel = List();

  FavoriteBloc(this.favoriteRepository) : super(FavoriteInitial());

  @override
  Stream<FavoriteState> mapEventToState(
    FavoriteEvent event,
  ) async* {
    if (event is FetchFavoritesFoodsEvent)
      yield* _mapFetchFavoritesFoodsEvent(event);
  }

  Stream<FavoriteState> _mapFetchFavoritesFoodsEvent(
      FetchFavoritesFoodsEvent event) async* {
    try {
      yield LoadingFavoritesFoodsState();

      final response = await favoriteRepository.fetchFavorite();
      final List favoriteData = response.data['favorites'];

      favoriteModel = favoriteData
          .map((e) => FavoriteModel(
              id: e['id'],
              availability: e['availability'],
              isAvailable: e['isAvailable'] ? 1 : 0,
              name: e['name'],
              photo: e['photo'],
              photoUrl: e['photoUrl'],
              price: e['price']))
          .toList();

      favoriteRepository.clear();
      favoriteModel.forEach((element) {
        favoriteRepository.insert('Favorite', element.toMap());
      });

      yield LoadedFavoritesFoodsState(
          favoriteModel: favoriteModel, count: favoriteModel.length);
    } catch (error) {
      print(error);
    }
  }
}
