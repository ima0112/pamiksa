import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/blocs/business_details/business_details_bloc.dart';
import 'package:pamiksa/src/data/errors.dart';
import 'package:pamiksa/src/data/models/addons.dart';
import 'package:pamiksa/src/data/models/food.dart';
import 'package:pamiksa/src/data/repositories/remote/addons_repository.dart';
import 'package:pamiksa/src/data/repositories/remote/food_repository.dart';
import 'package:pamiksa/src/data/repositories/remote/remote_repository.dart';
import 'package:pamiksa/src/data/storage/secure_storage.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final FoodRepository foodRepository;
  final AddonsRepository addonsRepository;
  final UserRepository userRepository;

  SecureStorage secureStorage = SecureStorage();
  List<AddonsModel> addonsModel = List();
  List<FoodModel> foodModel = List();

  String id;

  FoodBloc(this.addonsRepository, this.foodRepository, this.userRepository)
      : super(FoodInitial());

  @override
  Stream<FoodState> mapEventToState(
    FoodEvent event,
  ) async* {
    if (event is FetchFoodEvent) {
      yield* _mapFetchAddonsEvent(event);
    } else if (event is FoodRefreshTokenEvent) {
      yield* _mapFoodRefreshTokenEvent(event);
    }
  }

  Stream<FoodState> _mapFetchAddonsEvent(FetchFoodEvent event) async* {
    yield LoadingFoodState();
    id = event.id;
    try {
      final foodResult = await foodRepository.foodsById(event.id);

      if (foodResult.hasException) {
        if (foodResult.exception.graphqlErrors[0].message ==
            Errors.TokenExpired) {
          yield FoodTokenExpiredState();
        } else {
          yield FoodConnectionFailedState();
        }
      } else {
        foodRepository.clear();
        final List foodsData = foodResult.data['foods']['foods'];
        foodModel = foodsData
            .map((e) => FoodModel(
                id: e['id'],
                availability: e['availability'],
                description: e['description'],
                isAvailable: e['isAvailable'] ? 1 : 0,
                name: e['name'],
                photo: e['photo'],
                photoUrl: e['photoUrl'],
                price: e['price']))
            .toList();

        foodModel.forEach((element) {
          foodRepository.insert('Food', element.toMap());
        });
      }

 else {
        final List addonsData = response.data['addOns'];

        addonsModel = addonsData
            .map((e) =>
                AddonsModel(id: e['id'], name: e['name'], price: e['price']))
            .toList();

        addonsRepository.clear();
        addonsModel.forEach((element) {
          addonsRepository.insert('Addons', element.toMap());
        });
        yield LoadedFoodState(
            addonsModel: addonsModel,
            count: addonsModel.length,
            foodModel: foodModel);
      }
    } catch (error) {
      print(error);
    }
  }

  Stream<FoodState> _mapFoodRefreshTokenEvent(
      FoodRefreshTokenEvent event) async* {
    try {
      String refreshToken = await secureStorage.read(key: "refreshToken");
      final response = await userRepository.refreshToken(refreshToken);
      if (response.hasException) {
        yield FoodConnectionFailedState();
      } else {
        add(FetchFoodEvent(id));
      }
    } catch (error) {
      yield FoodConnectionFailedState();
    }
  }
}
