import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/data/errors.dart';
import 'package:pamiksa/src/data/models/addons.dart';
import 'package:pamiksa/src/data/models/food.dart';
import 'package:pamiksa/src/data/repositories/remote/addons_repository.dart';
import 'package:pamiksa/src/data/repositories/remote/food_repository.dart';
import 'package:pamiksa/src/data/repositories/remote/remote_repository.dart';
import 'package:pamiksa/src/data/storage/secure_storage.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final FoodRepository foodRepository;
  final FavoriteRepository favoriteRepository;
  final AddonsRepository addonsRepository;
  final UserRepository userRepository;
  final NavigationService navigationService = locator<NavigationService>();

  SecureStorage secureStorage = SecureStorage();
  List<AddonsModel> addonsModel = List();

  String id;
  int isFavorite;

  FoodBloc(this.addonsRepository, this.foodRepository, this.userRepository,
      this.favoriteRepository)
      : super(FoodInitial("0"));

  @override
  Stream<FoodState> mapEventToState(
    FoodEvent event,
  ) async* {
    if (event is FetchFoodEvent) {
      yield* _mapFetchAddonsEvent(event);
    } else if (event is FoodRefreshTokenEvent) {
      yield* _mapFoodRefreshTokenEvent(event);
    } else if (event is ToggleIconViewFavoriteEvent) {
      yield* _mapToggleIconViewFavoriteEvent(event);
    } else if (event is SetFavoriteInitalStateEvent) {
      yield FoodInitial(event.foodFk);
    }
  }

  Stream<FoodState> _mapFetchAddonsEvent(FetchFoodEvent event) async* {
    yield LoadingFoodState();
    id = event.id;
    try {
      FoodModel foodResult = await foodRepository.getById(id);
      final response = await addonsRepository.addons(id);
      if (response.hasException) {
        if (response.exception.graphqlErrors[0].message ==
            Errors.TokenExpired) {
          add(FoodRefreshTokenEvent(event));
        } else {
          yield ErrorFoodState(event);
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
          isFavorite = foodResult.isFavorite;
          yield LoadedFoodState(
              isFavorite: isFavorite,
              addonsModel: addonsModel,
              count: addonsModel.length,
              foodModel: foodResult);
        } else {
          yield LoadedFoodWithOutAddonsState(
              addonsModel: addonsModel, foodModel: foodResult);
        }
      }
    } catch (error) {
      yield ErrorFoodState(event);
    }
  }

  Stream<FoodState> _mapToggleIconViewFavoriteEvent(
      ToggleIconViewFavoriteEvent event) async* {
    try {
      if (isFavorite == 0) {
        isFavorite = 1;
        final response = await favoriteRepository.createFavorite(event.foodFk);
        if (response.hasException) {
          if (response.exception.graphqlErrors[0].message ==
              Errors.TokenExpired) {
            add(FoodRefreshTokenEvent(event));
          } else {
            yield ErrorFoodState(event);
          }
        } else {
          await foodRepository.updateById(event.foodFk, 1);
        }
      } else if (isFavorite == 1) {
        isFavorite = 0;
        final response = await favoriteRepository.deleteFavorite(event.foodFk);
        if (response.hasException) {
          if (response.exception.graphqlErrors[0].message ==
              Errors.TokenExpired) {
            add(FoodRefreshTokenEvent(event));
          } else {
            yield ErrorFoodState(event);
          }
        } else {
          await foodRepository.updateById(event.foodFk, 0);
        }
      }
    } catch (error) {
      yield ErrorFoodState(event);
    }
  }

  Stream<FoodState> _mapFoodRefreshTokenEvent(
      FoodRefreshTokenEvent event) async* {
    try {
      String refreshToken = await secureStorage.read(key: "refreshToken");
      final response = await userRepository.refreshToken(refreshToken);
      if (response.hasException &&
          response.exception.graphqlErrors[0].message ==
              Errors.RefreshTokenExpired) {
        await navigationService.navigateWithoutGoBack(Routes.LoginRoute);
      } else if (response.hasException) {
        yield ErrorFoodState(event);
      } else {
        add(event.childEvent);
      }
    } catch (error) {
      yield ErrorFoodState(event);
    }
  }
}
