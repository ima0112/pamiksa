import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pamiksa/src/data/models/business.dart';
import 'package:pamiksa/src/data/models/device.dart';
import 'package:pamiksa/src/data/models/models.dart';
import 'package:pamiksa/src/data/repositories/remote/business_repository.dart';
import 'package:pamiksa/src/data/repositories/remote/remote_repository.dart';
import 'package:pamiksa/src/data/repositories/remote/user_repository.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/data/device_info.dart' as deviceInfo;
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BusinessRepository businessRepository;
  final UserRepository userRepository;
  final FavoriteRepository favoriteRepository;
  final NavigationService navigationService = locator<NavigationService>();
  final secureStorage = new FlutterSecureStorage();

  DeviceModel deviceModel = DeviceModel();
  UserModel userModel = UserModel();

  List<BusinessModel> businessModel = List();
  List<FavoriteModel> favoriteModel = List();

  HomeBloc(
      this.businessRepository, this.userRepository, this.favoriteRepository)
      : super(HomeInitial(0));

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is FetchBusinessEvent) {
      yield* _mapFetchBusinessEvent(event);
    } else if (event is ChangeToInitialStateEvent) {
      yield* _mapChangeToInitialStateEvent(event);
    } else if (event is BottomNavigationItemTappedEvent) {
      yield* _mapBottomNavigationItemTappedEvent(event);
    } else if (event is LogoutEvent) {
      yield* _mapLogoutEvent(event);
    } else if (event is ShowedDevicesEvent) {
      navigationService.navigateTo("/devices");
    }
  }

  Stream<HomeState> _mapBottomNavigationItemTappedEvent(
      BottomNavigationItemTappedEvent event) async* {
    if (event.index == 0) {
      try {
        final response = await businessRepository.fetchBusiness();
        if (response.hasException) {
          yield HomeConnectionFailedState(event.index);
        } else {
          final List businessData = response.data['business'];
          businessModel = businessData
              .map((e) => BusinessModel(
                    id: e['id'],
                    name: e['name'],
                    adress: e['adress'],
                    valoration: e['valoration'],
                    deliveryPrice: e['deliveryPrice'].toDouble(),
                    valorationsQuantity: e['valorationsQuantity'],
                    valorationSum: e['valorationSum'],
                    email: e['email'],
                    photo: e['photo'],
                    description: e['description'],
                    phone: e['phone'],
                  ))
              .toList();
          businessRepository.clear();
          businessModel.forEach((element) {
            businessRepository.insert('Business', element.toMap());
          });
          yield LoadedBusinessState(event.index, businessModel);
        }
      } catch (error) {
        yield HomeConnectionFailedState(event.index);
      }
    } else if (event.index == 1) {
      final response = await favoriteRepository.fetchFavorite();
      final List favoriteData = response.data['favorites'];

      favoriteModel = favoriteData
          .map((e) => FavoriteModel(
              id: e['id'],
              availability: e['availability'],
              isAvailable: e['isAvailable'],
              name: e['name'],
              photo: e['photo'],
              price: e['price']))
          .toList();

      yield ShowSecondState(
          index: event.index,
          favoriteModel: favoriteModel,
          count: favoriteModel.length);
    } else if (event.index == 2) {
      yield ShowThirdState(event.index);
    } else if (event.index == 3) {
      yield ShowFourState(event.index);
    }
  }

  Stream<HomeState> _mapChangeToInitialStateEvent(
      ChangeToInitialStateEvent event) async* {
    yield HomeInitial(0);
  }

  Stream<HomeState> _mapFetchBusinessEvent(FetchBusinessEvent event) async* {
    try {
      final response = await businessRepository.fetchBusiness();
      if (response.hasException) {
        print(response.exception);
        yield HomeConnectionFailedState(0);
      } else {
        final List businessData = response.data['business'];
        businessModel = businessData
            .map((e) => BusinessModel(
                  id: e['id'],
                  name: e['name'],
                  adress: e['adress'],
                  valoration: e['valoration'],
                  deliveryPrice: e['deliveryPrice'].toDouble(),
                  valorationsQuantity: e['valorationsQuantity'],
                  valorationSum: e['valorationSum'],
                  email: e['email'],
                  photo: e['photo'],
                  description: e['description'],
                  phone: e['phone'],
                ))
            .toList();
        businessRepository.clear();
        businessModel.forEach((element) {
          businessRepository.insert('Business', element.toMap());
        });
        /*List<Map<String, dynamic>> resultado = await businessRepository.all();
        List<BusinessModel> retorno = List();
        retorno = resultado
            .map((e) => BusinessModel(
                  id: e['id'].toString(),
                  name: e['name'],
                  adress: e['adress'],
                  valoration: e['valoration'],
                  deliveryPrice: e['deliveryPrice'].toDouble(),
                  valorationsQuantity: e['valorationsQuantity'],
                  valorationSum: e['valorationSum'],
                  email: e['email'],
                  photo: e['photo'],
                  description: e['description'],
                  phone: e['phone'],
                ))
            .toList();*/
        yield LoadedBusinessState(0, businessModel);
      }
    } catch (error) {
      print(error.toString());
      yield HomeConnectionFailedState(0);
    }
  }

  Stream<HomeState> _mapLogoutEvent(LogoutEvent event) async* {
    await deviceInfo.initPlatformState(deviceModel);
    await userRepository.signOut(deviceModel.deviceId);
    secureStorage.delete(key: "authToken");
    secureStorage.delete(key: "refreshToken");
    await navigationService.navigateAndRemove("/login");
    yield HomeInitial(0);
  }
}
