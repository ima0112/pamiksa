import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/data/models/food.dart';
import 'package:pamiksa/src/data/repositories/remote/food_repository.dart';

part 'foods_event.dart';
part 'foods_state.dart';

class FoodsBloc extends Bloc<FoodsEvent, FoodsState> {
  final FoodRepository foodRepository;

  List<FoodModel> foodModel = List();

  FoodsBloc(this.foodRepository) : super(FoodsInitial());

  @override
  Stream<FoodsState> mapEventToState(
    FoodsEvent event,
  ) async* {
    if (event is FetchFoodsEvent) {
      yield* _mapFetchFoodsEvent(event);
    }
  }

  Stream<FoodsState> _mapFetchFoodsEvent(FetchFoodsEvent event) async* {
    yield LoadingFoodsState();
    try {
      final response = await foodRepository.foods(event.id);
      final List foodsData = response.data['foods']['foods'];

      foodModel = foodsData.map((e) => FoodModel().fromMap(e));
      // FoodModel(
      //     id: e['id'],
      //     availability: e['availability'],
      //     isAvailable: e['isAvailable'],
      //     name: e['name'],
      //     photo: e['photo'],
      //     price: e['price']))
      // .toList();

      foodRepository.clear();
      foodModel.forEach((element) {
        foodRepository.insert('Food', element.toMap());
      });

      if (response.hasException) {
        print(response.exception);
      } else {
        yield LoadedFoodsState(foodModel: foodModel, count: foodModel.length);
      }
    } catch (error) {
      print(error);
    }
  }
}
