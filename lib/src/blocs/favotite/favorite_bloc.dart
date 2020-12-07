import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pamiksa/src/data/errors.dart';
import 'package:pamiksa/src/data/models/models.dart';
import 'package:pamiksa/src/data/repositories/repositories.dart';
import 'package:pamiksa/src/data/storage/secure_storage.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';

part 'favorite_event.dart';

part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteRepository favoriteRepository;
  final UserRepository userRepository;
  final NavigationService navigationService = locator<NavigationService>();

  List<AddonsModel> addonsModel = List();
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
    } else if (event is DeleteFavoriteEvent) {
      yield* _mapDeleteFavoriteEvent(event);
    }
  }

  Stream<FavoriteState> _mapDeleteFavoriteEvent(
      DeleteFavoriteEvent event) async* {
    final response = await favoriteRepository.deleteFavorite(event.foodFk);
    if (response.hasException) {
      if (response.exception.graphqlErrors[0].message == Errors.TokenExpired) {
        add(FavoriteRefreshTokenEvent(event));
      } else {
        yield FavoriteConnectionFailed();
      }
    }
    await favoriteRepository.deleteById(event.foodFk);
    final responseDb = await favoriteRepository.all();

    favoriteModel = responseDb
        .map((e) => FavoriteModel(
            id: e['id'],
            availability: e['availability'],
            isAvailable: e['isAvailable'],
            name: e['name'],
            photo: e['photo'],
            photoUrl: e['photoUrl'],
            price: e['price']))
        .toList();
    if (event.favoriteState is LoadedFavoritesFoodsState) {
      yield DeleteFavoriteLoaded(
          favoriteModel: favoriteModel, count: favoriteModel.length);
    } else if (event.favoriteState is DeleteFavoriteLoaded) {
      yield LoadedFavoritesFoodsState(
          favoriteModel: favoriteModel, count: favoriteModel.length);
    }
  }

  Stream<FavoriteState> _mapFetchFavoritesFoodsEvent(
      FetchFavoritesFoodsEvent event) async* {
    try {
      final response =
          await favoriteRepository.fetchFavorite(FetchPolicy.cacheAndNetwork);

      if (response.hasException) {
        if (response.exception.graphqlErrors[0].message ==
            Errors.TokenExpired) {
          add(FavoriteRefreshTokenEvent(event));
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
      if (response.hasException &&
          response.exception.graphqlErrors[0].message ==
              Errors.RefreshTokenExpired) {
        await navigationService.navigateWithoutGoBack(Routes.LoginRoute);
        yield FavoriteInitial();
      } else if (response.hasException) {
        yield FavoriteConnectionFailed();
      } else {
        add(event.childEvent);
      }
    } catch (error) {
      yield FavoriteConnectionFailed();
    }
  }
}
