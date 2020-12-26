import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/data/errors.dart';
import 'package:pamiksa/src/data/models/cart_food.dart';
import 'package:pamiksa/src/data/models/cart_food_view.dart';
import 'package:pamiksa/src/data/repositories/remote/cart_food_view_repository.dart';
import 'package:pamiksa/src/data/repositories/remote/cart_repository.dart';
import 'package:pamiksa/src/data/repositories/remote/remote_repository.dart';
import 'package:pamiksa/src/data/storage/secure_storage.dart';
import 'package:pamiksa/src/ui/navigation/navigation.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartFoodRepository cartFoodRepository;
  final CartFoodViewRepository cartFoodViewRepository;
  final UserRepository userRepository;
  final NavigationService navigationService = locator<NavigationService>();

  SecureStorage secureStorage = SecureStorage();
  List<CartFoodModel> cartFoodModel = List();
  List<CartFoodViewModel> cartFoodViewModel = List();

  String id;
  int isFavorite;

  CartBloc(
    this.cartFoodRepository,
    this.userRepository,
    this.cartFoodViewRepository,
  ) : super(CartInitial());

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    if (event is FetchCartEvent) {
      yield* _mapFetchCartEvent(event);
    } else if (event is CartRefreshTokenEvent) {
      yield* _mapCartRefreshTokenEvent(event);
    } else if (event is SetInitialCartEvent) {
      yield CartInitial();
    } else if (event is EmptyCartEvent) {
      yield* _mapEmptyCartEvent(event);
    }
  }

  Stream<CartState> _mapEmptyCartEvent(EmptyCartEvent event) async* {
    try {
      final response = await cartFoodRepository.deleteAllFoodCart();
      if (response.hasException) {
        if (response.exception.graphqlErrors[0].message ==
            Errors.TokenExpired) {
          add(CartRefreshTokenEvent(event));
        } else {
          yield ErrorCartState(event);
        }
      } else {
        yield EmptyCartState();
      }
    } catch (error) {
      yield ErrorCartState(event);
    }
  }

  Stream<CartState> _mapFetchCartEvent(FetchCartEvent event) async* {
    try {
      cartFoodViewModel.clear();
      yield LoadingCartState();
      final response = await cartFoodRepository.cart();
      if (response.hasException) {
        if (response.exception.graphqlErrors[0].message ==
            Errors.TokenExpired) {
          add(CartRefreshTokenEvent(event));
        } else {
          yield ErrorCartState(event);
        }
      } else {
        final List cartData = response.data['cart'];
        cartFoodModel = cartData
            .map((e) => CartFoodModel(
                id: e['id'],
                name: e['name'],
                description: e['description'],
                price: e['price'],
                photo: e['photo'],
                photoUrl: e['photoUrl'],
                foodFk: e['foodFk'],
                availability: e['availability'],
                quantity: e['quantity']))
            .toList();
        cartFoodRepository.clear();
        //cartFoodViewRepository.clear();
        cartFoodModel.forEach((element) {
          if (cartFoodViewModel.isEmpty) {
            cartFoodViewModel.add(CartFoodViewModel(
                id: element.foodFk,
                name: element.name,
                availability: element.availability,
                photo: element.photo,
                photoUrl: element.photoUrl,
                price: element.price,
                quantity: element.quantity));
          } else {
            int cartFoodViewModelIndex = cartFoodViewModel.indexWhere(
                (elementItem) => (elementItem.id == element.foodFk));
            if (cartFoodViewModelIndex != -1) {
              cartFoodViewModel[cartFoodViewModelIndex].quantity += 1;
              cartFoodViewModel[cartFoodViewModelIndex].price += element.price;
            } else {
              cartFoodViewModel.add(CartFoodViewModel(
                  id: element.foodFk,
                  name: element.name,
                  availability: element.availability,
                  photo: element.photo,
                  photoUrl: element.photoUrl,
                  price: element.price,
                  quantity: element.quantity));
            }
          }
          cartFoodRepository.insert('CartFood', element.toMap());
        });
        yield LoadedCartState(cartFoodViewModel: cartFoodViewModel);
      }
    } catch (error) {
      yield ErrorCartState(event);
    }
  }

  Stream<CartState> _mapCartRefreshTokenEvent(
      CartRefreshTokenEvent event) async* {
    try {
      String refreshToken = await secureStorage.read(key: "refreshToken");
      final response = await userRepository.refreshToken(refreshToken);
      if (response.hasException &&
          response.exception.graphqlErrors[0].message ==
              Errors.RefreshTokenExpired) {
        await navigationService.navigateWithoutGoBack(Routes.LoginRoute);
      } else if (response.hasException) {
        yield ErrorCartState(event);
      } else {
        add(event.childEvent);
      }
    } catch (error) {
      yield ErrorCartState(event);
    }
  }
}
