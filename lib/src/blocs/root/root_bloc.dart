import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/data/errors.dart';
import 'package:pamiksa/src/data/models/business.dart';
import 'package:pamiksa/src/data/models/device.dart';
import 'package:pamiksa/src/data/models/models.dart';
import 'package:pamiksa/src/data/repositories/remote/business_repository.dart';
import 'package:pamiksa/src/data/repositories/remote/remote_repository.dart';
import 'package:pamiksa/src/data/repositories/remote/user_repository.dart';
import 'package:pamiksa/src/data/storage/secure_storage.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/data/device_info.dart' as deviceInfo;
import 'package:pamiksa/src/ui/navigation/navigation.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';

part 'root_bloc_event.dart';

part 'root_bloc_state.dart';

class RootBloc extends Bloc<RootEvent, RootState> {
  final BusinessRepository businessRepository;
  final UserRepository userRepository;
  final FavoriteRepository favoriteRepository;
  final NavigationService navigationService = locator<NavigationService>();

  SecureStorage secureStorage = SecureStorage();

  DeviceModel deviceModel = DeviceModel();
  UserModel userModel = UserModel();

  List<BusinessModel> businessModel = List();
  List<FavoriteModel> favoriteModel = List();

  RootBloc(
      this.businessRepository, this.userRepository, this.favoriteRepository)
      : super(HomeInitial());

  @override
  Stream<RootState> mapEventToState(
    RootEvent event,
  ) async* {
    if (event is FetchBusinessEvent) {
      yield* _mapFetchBusinessEvent(event);
    } else if (event is ChangeToInitialStateEvent) {
      yield* _mapChangeToInitialStateEvent(event);
    } else if (event is LogoutEvent) {
      yield* _mapLogoutEvent(event);
    } else if (event is RefreshTokenEvent) {
      yield* _mapRefreshTokenEvent(event);
    }
  }

  Stream<RootState> _mapChangeToInitialStateEvent(
      ChangeToInitialStateEvent event) async* {
    yield HomeInitial();
  }

  Stream<RootState> _mapRefreshTokenEvent(RefreshTokenEvent event) async* {
    try {
      String refreshToken = await secureStorage.read(key: "refreshToken");
      final response = await userRepository.refreshToken(refreshToken);
      if (response.hasException) {
        yield HomeConnectionFailedState();
      } else {
        add(event.childEvent);
      }
    } catch (error) {
      yield HomeConnectionFailedState();
    }
  }

  Stream<RootState> _mapFetchBusinessEvent(FetchBusinessEvent event) async* {
    try {
      final response = await businessRepository.fetchBusiness();
      if (response.hasException) {
        if (response.exception.graphqlErrors[0].message ==
            Errors.TokenExpired) {
          add(RefreshTokenEvent(event));
        } else {
          yield HomeConnectionFailedState();
        }
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
                  photoUrl: e['photoUrl'],
                  description: e['description'],
                  phone: e['phone'],
                ))
            .toList();
        businessRepository.clear();
        businessModel.forEach((element) {
          businessRepository.insert('Business', element.toMap());
        });
        yield LoadedBusinessState(businessModel);
      }
    } catch (error) {
      print(error.toString());
      yield HomeConnectionFailedState();
    }
  }

  Stream<RootState> _mapLogoutEvent(LogoutEvent event) async* {
    await deviceInfo.initPlatformState(deviceModel);
    await userRepository.signOut(deviceModel.deviceId);
    secureStorage.remove(key: "authToken");
    secureStorage.remove(key: "refreshToken");
    await navigationService.navigateAndRemove(Routes.LoginRoute);
    yield HomeInitial();
  }
}
