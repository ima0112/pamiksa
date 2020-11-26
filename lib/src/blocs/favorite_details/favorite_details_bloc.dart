import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/data/errors.dart';
import 'package:pamiksa/src/data/models/models.dart';
import 'package:pamiksa/src/data/repositories/remote/remote_repository.dart';
import 'package:pamiksa/src/data/storage/secure_storage.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';

part 'favorite_details_event.dart';
part 'favorite_details_state.dart';

class FavoriteDetailsBloc
    extends Bloc<FavoriteDetailsEvent, FavoriteDetailsState> {
  final UserRepository userRepository;
  final FavoriteRepository favoriteRepository;
  final AddonsRepository addonsRepository;
  final NavigationService navigationService = locator<NavigationService>();

  List<AddonsModel> addonsModel = List();
  SecureStorage secureStorage = SecureStorage();

  String id;

  FavoriteDetailsBloc(
      this.userRepository, this.favoriteRepository, this.addonsRepository)
      : super(FavoriteDetailsInitial());

  @override
  Stream<FavoriteDetailsState> mapEventToState(
    FavoriteDetailsEvent event,
  ) async* {
    if (event is FetchFavoriteFoodsDetailsEvent) {
      yield* _mapFetchFavoriteFoodsDetailsEvent(event);
    } else if (event is FavoriteDetailsRefreshTokenEvent) {
      yield* _mapFavoriteDetailsRefreshTokenEvent(event);
    }
  }

  Stream<FavoriteDetailsState> _mapFetchFavoriteFoodsDetailsEvent(
      FetchFavoriteFoodsDetailsEvent event) async* {
    yield LoadingFavoritesDetailsFoodsState();
    id = event.id;
    try {
      FavoriteModel favoriteResult =
          await favoriteRepository.getFavoriteFoodById(id);
      final response = await addonsRepository.addons(id);

      if (response.hasException) {
        if (response.exception.graphqlErrors[0].message ==
            Errors.TokenExpired) {
          add(FavoriteDetailsRefreshTokenEvent(event));
        } else {
          yield FavoriteDetailsConnectionFailed();
        }
      } else {
        final List addonsData = response.data['addOns'] ?? null;

        if (addonsData != null) {
          addonsModel = addonsData
              .map((e) =>
                  AddonsModel(id: e['id'], name: e['name'], price: e['price']))
              .toList();

          addonsRepository.clear();
          addonsModel.forEach((element) {
            addonsRepository.insert('Addons', element.toMap());
          });
          yield LoadedFavoritesFoodsDetailsState(
              count: addonsModel.length,
              favoriteModel: favoriteResult,
              addonsModel: addonsModel);
        } else {
          yield LoadedFavoritesFoodsWithOutAddonsState(
              favoriteModel: favoriteResult, addonsModel: addonsModel);
        }
      }
    } catch (error) {
      yield FavoriteDetailsConnectionFailed();
    }
  }

  Stream<FavoriteDetailsState> _mapFavoriteDetailsRefreshTokenEvent(
      FavoriteDetailsRefreshTokenEvent event) async* {
    try {
      String refreshToken = await secureStorage.read(key: "refreshToken");
      final response = await userRepository.refreshToken(refreshToken);
      if (response.hasException &&
          response.exception.graphqlErrors[0].message ==
              Errors.RefreshTokenExpired) {
        await navigationService.navigateWithoutGoBack(Routes.LoginRoute);
        yield FavoriteDetailsInitial();
      } else if (response.hasException) {
        yield FavoriteDetailsConnectionFailed();
      } else {
        add(event.childEvent);
      }
    } catch (error) {
      yield FavoriteDetailsConnectionFailed();
    }
  }
}
