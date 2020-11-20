import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/blocs/blocs.dart';
import 'package:pamiksa/src/data/errors.dart';
import 'package:pamiksa/src/data/models/municipality.dart';
import 'package:pamiksa/src/data/models/province.dart';
import 'package:pamiksa/src/data/repositories/remote/municipality_repository.dart';
import 'package:pamiksa/src/data/repositories/remote/province_repository.dart';
import 'package:pamiksa/src/data/repositories/remote/user_repository.dart';
import 'package:pamiksa/src/data/storage/secure_storage.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
import 'package:pamiksa/src/data/random.dart' as random;
import 'package:pamiksa/src/ui/navigation/navigation.dart';

part 'register_location_event.dart';
part 'register_location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final NavigationService navigationService = locator<NavigationService>();
  final ProvinceRepository provinceRepository;
  final UserRepository userRepository;
  final MunicipalityRepository municipalityRepository;

  List<ProvinceModel> province = List();
  SecureStorage secureStorage = SecureStorage();
  List<ProvinceModel> provinceReturn = List();
  List<MunicipalityModel> municipalitiesReturn = new List();

  String adress;
  String provinceId;
  String municipalityId;

  LocationBloc(
      this.provinceRepository, this.userRepository, this.municipalityRepository)
      : super(LocationInitial());

  @override
  Stream<LocationState> mapEventToState(
    LocationEvent event,
  ) async* {
    if (event is LocationMutateCodeEvent) {
      yield* _mapMutateCodeEvent(event);
    } else if (event is FetchProvinceMunicipalityDataEvent) {
      yield* _mapFetchProvinceMunicipalityDataEvent(event);
    } else if (event is ProvinceSelectedEvent) {
      yield* _mapProvinceSelectedEvent(event);
    } else if (event is LocationRefreshTokenEvent) {
      yield* _mapLocationRefreshTokenEvent(event);
    }
  }

  Stream<LocationState> _mapMutateCodeEvent(
      LocationMutateCodeEvent event) async* {
    adress = event.adress;
    provinceId = event.provinceId;
    municipalityId = event.municipalityId;
    try {
      String email = await secureStorage.read(key: 'email');
      int code = await random.randomCode();

      await secureStorage.save(key: 'code', value: code.toString());
      await secureStorage.save(key: 'adress', value: event.adress);
      await secureStorage.save(key: 'province', value: event.provinceId);
      await secureStorage.save(
          key: 'municipality', value: event.municipalityId);
      final response = await this
          .userRepository
          .sendVerificationCode(email, code.toString());

      if (response.hasException) {
        if (response.exception.graphqlErrors[0].message ==
            Errors.TokenExpired) {
          add(LocationRefreshTokenEvent());
        } else {
          yield LocationConnectionFailedState();
        }
      }

      print(
          {"response": response.data.toString(), "code": code, "email": email});
      navigationService.navigateAndRemoveUntil(Routes.VerificationRoute);
    } catch (error) {
      yield LocationConnectionFailedState();
    }
  }

  Stream<LocationState> _mapFetchProvinceMunicipalityDataEvent(
      FetchProvinceMunicipalityDataEvent event) async* {
    yield LoadingProvinceMunicipalityState();

    List<Map<String, dynamic>> provinceResult = await provinceRepository.all();

    provinceReturn = provinceResult
        .map((e) => ProvinceModel(
              id: e['id'].toString(),
              name: e['name'],
            ))
        .toList();

    yield LoadedProvinceMunicipalityState(provinceReturn, municipalitiesReturn);
  }

  Stream<LocationState> _mapProvinceSelectedEvent(
      ProvinceSelectedEvent event) async* {
    yield LoadedProvinceMunicipalityState(provinceReturn, municipalitiesReturn);
    List<Map<String, dynamic>> municipalitiesResult =
        await municipalityRepository.all();

    municipalitiesReturn = municipalitiesResult
        .map((e) => MunicipalityModel(
            id: e['id'].toString(),
            name: e['name'],
            provinceFk: e['provinceFk']))
        .where((element) => element.provinceFk == event.provinceFk)
        .toList();

    yield MunicipalitiesLoadedState(municipalitiesReturn, provinceReturn);
  }

  Stream<LocationState> _mapLocationRefreshTokenEvent(
      LocationRefreshTokenEvent event) async* {
    try {
      String refreshToken = await secureStorage.read(key: "refreshToken");
      final response = await userRepository.refreshToken(refreshToken);
      if (response.hasException) {
        yield LocationConnectionFailedState();
      } else {
        add(LocationMutateCodeEvent(
            adress: adress,
            municipalityId: municipalityId,
            provinceId: provinceId));
      }
    } catch (error) {
      yield LocationConnectionFailedState();
    }
  }
}
