import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/data/models/addons.dart';
import 'package:pamiksa/src/data/models/food.dart';
import 'package:pamiksa/src/data/repositories/remote/addons_repository.dart';
import 'package:pamiksa/src/data/repositories/remote/food_repository.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  final FoodRepository foodRepository;
  final AddonsRepository addonsRepository;

  List<AddonsModel> addonsModel = List();

  FoodBloc(this.addonsRepository, this.foodRepository) : super(FoodInitial());

  @override
  Stream<FoodState> mapEventToState(
    FoodEvent event,
  ) async* {
    if (event is FetchFoodEvent) {
      yield* _mapFetchAddonsEvent(event);
    }
  }

  Stream<FoodState> _mapFetchAddonsEvent(FetchFoodEvent event) async* {
    yield LoadingFoodState();
    try {
      FoodModel foodResult = await foodRepository.getById(event.id);
      final response = await addonsRepository.addons(event.id);

      if (response.hasException) {
        print(response.exception);
      } else {
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
            foodModel: foodResult);
      }
    } catch (error) {
      print(error);
    }
  }
}
