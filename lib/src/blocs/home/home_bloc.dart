import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pamiksa/src/data/models/business.dart';
import 'package:pamiksa/src/data/repositories/remote/business_repository.dart';
import 'package:pamiksa/src/data/repositories/remote/user_repository.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BusinessRepository businessRepository;
  final UserRepository userRepository;
  final NavigationService navigationService = locator<NavigationService>();

  List<BusinessModel> businessModel;
  final secureStorage = new FlutterSecureStorage();

  HomeBloc(this.businessRepository, this.userRepository)
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
    }
  }

  Stream<HomeState> _mapBottomNavigationItemTappedEvent(
      BottomNavigationItemTappedEvent event) async* {
    if (event.index == 0) {
      try {
        final response = await businessRepository.fetchBusiness();
        if (response.hasException) {
          yield ConnectionFailedState(event.index);
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
        yield ConnectionFailedState(event.index);
      }
    } else if (event.index == 1) {
      yield ShowSecondState(event.index);
    } else if (event.index == 2) {
      yield ShowThirdState(event.index);
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
        yield ConnectionFailedState(0);
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
      yield ConnectionFailedState(0);
    }
  }

  Stream<HomeState> _mapLogoutEvent(LogoutEvent event) async* {
    await userRepository.signOut();
    secureStorage.delete(key: "authToken");
    secureStorage.delete(key: "refreshToken");
    await navigationService.navigateAndRemove("/login");
    yield HomeInitial(0);
  }
}
