import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/data/errors.dart';
import 'package:pamiksa/src/data/models/models.dart';
import 'package:pamiksa/src/data/repositories/remote/food_repository.dart';
import 'package:pamiksa/src/data/repositories/repositories.dart';
import 'package:pamiksa/src/data/storage/secure_storage.dart';

import '../blocs.dart';

part 'business_details_event.dart';

part 'business_details_state.dart';

class BusinessDetailsBloc
    extends Bloc<BusinessDetailsEvent, BusinessDetailsState> {
  final BusinessRepository businessRepository;
  final FoodRepository foodRepository;
  final UserRepository userRepository;

  SecureStorage secureStorage = SecureStorage();
  List foodModel = List();

  BusinessDetailsBloc(
      this.businessRepository, this.foodRepository, this.userRepository)
      : super(BusinessDetailsInitial("0"));

  @override
  Stream<BusinessDetailsState> mapEventToState(
    BusinessDetailsEvent event,
  ) async* {
    if (event is FetchBusinessDetailsEvent) {
      yield* _mapFetchBusinessDetails(event);
    } else if (event is SetInitialBusinessDetailsEvent) {
      yield BusinessDetailsInitial(event.id);
    } else if (event is BusinessRefreshTokenEvent) {
      yield* _mapBusinessRefreshTokenEvent(event);
    }
  }

  Stream<BusinessDetailsState> _mapFetchBusinessDetails(
      FetchBusinessDetailsEvent event) async* {
    try {
      BusinessModel businessResult = await businessRepository.getById(event.id);
      final response = await foodRepository.foods(event.id);

      if (response.hasException) {
        if (response.exception.graphqlErrors[0].message == "TOKEN_EXPIRED") {
          yield BusinessTokenExpired();
        } else {
          yield ErrorBusinessDetailsState();
          ;
        }
      } else {
        foodRepository.clear();
        final List foodsData = response.data['foods']['foods'];
        foodModel = foodsData
            .map((e) => FoodModel(
                id: e['id'],
                availability: e['availability'],
                isAvailable: e['isAvailable'] ? 1 : 0,
                name: e['name'],
                photo: e['photo'],
                photoUrl: e['photoUrl'],
                price: e['price']))
            .toList();

        foodModel.forEach((element) {
          foodRepository.insert('Food', element.toMap());
        });
        yield LoadedBusinessDetailsState(businessResult, foodModel);
      }
    } catch (error) {
      yield ErrorBusinessDetailsState();
    }
  }

  Stream<BusinessDetailsState> _mapBusinessRefreshTokenEvent(
      BusinessRefreshTokenEvent event) async* {
    try {
      String refreshToken = await secureStorage.read(key: "refreshToken");
      final response = await userRepository.refreshToken(refreshToken);
      if (response.hasException) {
        yield ErrorBusinessDetailsState();
      } else {
        yield BusinessDetailsInitial("0");
      }
    } catch (error) {
      yield ErrorBusinessDetailsState();
    }
  }
}
