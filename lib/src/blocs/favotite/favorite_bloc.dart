import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/blocs/blocs.dart';
import 'package:pamiksa/src/data/errors.dart';
import 'package:pamiksa/src/data/models/models.dart';
import 'package:pamiksa/src/data/repositories/repositories.dart';
import 'package:pamiksa/src/data/storage/secure_storage.dart';

part 'favorite_event.dart';

part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteRepository favoriteRepository;
  final UserRepository userRepository;

  SecureStorage secureStorage = SecureStorage();

  List<FavoriteModel> favoriteModel = List();

  FavoriteBloc(this.favoriteRepository, this.userRepository)
      : super(FavoriteInitial());

  @override
  Stream<FavoriteState> mapEventToState(
    FavoriteEvent event,
  ) async* {
    if (event is FetchFavoritesFoodsEvent) {
      yield* _mapFetchFavoritesFoodsEvent(event);
    } else if (event is FavoriteRefreshTokenEvent) {
      yield* _mapFavoriteRefreshTokenEvent(event);
    } else if (event is ChangeStateToInitialEvent) {
      yield FavoriteInitial();
    }
  }

  Stream<FavoriteState> _mapFetchFavoritesFoodsEvent(
      FetchFavoritesFoodsEvent event) async* {
    try {
      final response = await favoriteRepository.fetchFavorite();

      if (response.hasException) {
        if (response.exception.graphqlErrors[0].message ==
            Errors.TokenExpired) {
          yield FavoriteTokenExpired();
        } else {
          yield FavoriteConnectionFailed();
        }
      } else {
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
      }
    } catch (error) {
      print(error);
    }
  }

  Stream<FavoriteState> _mapFavoriteRefreshTokenEvent(
      FavoriteRefreshTokenEvent event) async* {
    try {
      String refreshToken = await secureStorage.read(key: "refreshToken");
      final response = await userRepository.refreshToken(refreshToken);
      if (response.hasException) {
        yield FavoriteConnectionFailed();
      } else {
        yield FavoriteInitial();
      }
    } catch (error) {
      yield FavoriteConnectionFailed();
    }
  }
}
