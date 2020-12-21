import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/data/errors.dart';
import 'package:pamiksa/src/data/models/models.dart';
import 'package:pamiksa/src/data/repositories/remote/food_repository.dart';
import 'package:pamiksa/src/data/repositories/repositories.dart';
import 'package:pamiksa/src/data/storage/secure_storage.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';

part 'business_details_event.dart';

part 'business_details_state.dart';

class BusinessDetailsBloc
    extends Bloc<BusinessDetailsEvent, BusinessDetailsState> {
  final BusinessRepository businessRepository;
  final FoodRepository foodRepository;
  final UserRepository userRepository;
  final NavigationService navigationService = locator<NavigationService>();

  SecureStorage secureStorage = SecureStorage();
  List foodModel = List();

  String id;

  BusinessDetailsBloc(
      this.businessRepository, this.foodRepository, this.userRepository)
      : super(BusinessDetailsInitial(" "));

  @override
  Stream<BusinessDetailsState> mapEventToState(
    BusinessDetailsEvent event,
  ) async* {
    if (event is FetchBusinessDetailsEvent) {
      yield* _mapFetchBusinessDetails(event);
    } else if (event is SetInitialBusinessDetailsEvent) {
      yield BusinessDetailsInitial(id);
    } else if (event is BusinessRefreshTokenEvent) {
      yield* _mapBusinessRefreshTokenEvent(event);
    } else if (event is SetInitialBusinessDetailsEvent) {
      yield BusinessDetailsInitial(" ");
    }
  }

  Stream<BusinessDetailsState> _mapFetchBusinessDetails(
      FetchBusinessDetailsEvent event) async* {
    yield LoadingBusinessDetailsState();
    id = event.id;
    try {
      BusinessModel businessResult = await businessRepository.getById(event.id);
      final response = await foodRepository.foods(event.id);

      if (response.hasException) {
        if (response.exception.graphqlErrors[0].message ==
            Errors.TokenExpired) {
          yield BusinessTokenExpired();
        } else {
          yield ErrorBusinessDetailsState(event);
        }
      } else {
        foodRepository.clear();
        final List foodsData = response.data['foods']['foods'];
        foodModel = foodsData
            .map((e) => FoodModel(
                id: e['id'],
                availability: e['availability'],
                isAvailable: e['isAvailable'] ? 1 : 0,
                isFavorite: e['isFavorite'] ? 1 : 0,
                name: e['name'],
                photo: e['photo'],
                photoUrl: e['photoUrl'],
                price: e['price']))
            .toList();

        foodModel.forEach((element) {
          foodRepository.insert('Food', element.toMap());
        });
        yield LoadedBusinessDetailsState(
            businessModel: businessResult, foodModel: foodModel);
      }
    } catch (error) {
      yield ErrorBusinessDetailsState(event);
    }
  }

  Stream<BusinessDetailsState> _mapBusinessRefreshTokenEvent(
      BusinessRefreshTokenEvent event) async* {
    try {
      String refreshToken = await secureStorage.read(key: "refreshToken");
      final response = await userRepository.refreshToken(refreshToken);
      if (response.hasException &&
          response.exception.graphqlErrors[0].message ==
              Errors.RefreshTokenExpired) {
        await navigationService.navigateWithoutGoBack(Routes.LoginRoute);
        yield BusinessDetailsInitial(id);
      } else if (response.hasException) {
        yield ErrorBusinessDetailsState(event);
      } else {
        yield BusinessDetailsInitial(id);
      }
    } catch (error) {
      yield ErrorBusinessDetailsState(event);
    }
  }
}
