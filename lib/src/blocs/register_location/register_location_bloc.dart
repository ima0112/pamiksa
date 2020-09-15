import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pamiksa/src/data/models/municipality.dart';
import 'package:pamiksa/src/data/models/province.dart';
import 'package:pamiksa/src/data/repositories/remote/municipality_repository.dart';
import 'package:pamiksa/src/data/repositories/remote/province_repository.dart';
import 'package:pamiksa/src/data/repositories/remote/user_repository.dart';
import 'package:pamiksa/src/data/shared/shared.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
import 'package:pamiksa/src/data/random.dart' as random;
import 'package:pamiksa/src/ui/navigation/route_paths.dart' as routes;

part 'register_location_event.dart';
part 'register_location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final NavigationService navigationService = locator<NavigationService>();
  final ProvinceRepository provinceRepository;
  final UserRepository userRepository;
  final MunicipalityRepository municipalityRepository;

  List<ProvinceModel> province = List();
  Shared preferences = Shared();
  LocationBloc(
      this.provinceRepository, this.userRepository, this.municipalityRepository)
      : super(LocationInitial());

  @override
  Stream<LocationState> mapEventToState(
    LocationEvent event,
  ) async* {
    if (event is MutateCodeEvent) {
      yield* _mapMutateCodeEvent(event);
    }
    if (event is FetchProvinceMunicipalityDataEvent) {
      yield* _mapFetchProvinceMunicipalityDataEvent(event);
    }
    if (event is ProvinceSelectedEvent) {
      yield* _mapProvinceSelectedEvent(event);
    }
  }

  Stream<LocationState> _mapMutateCodeEvent(MutateCodeEvent event) async* {
    String email = await preferences.read('email');
    int code = await random.randomCode();

    await preferences.saveString('code', code.toString());
    await preferences.saveString('adress', event.adress);
    final response =
        await this.userRepository.sendVerificationCode(email, code.toString());

    print({"response": response.data.toString(), "code": code, "email": email});
    navigationService.navigateAndRemoveUntil(
        routes.VerificationRoute, routes.LoginRoute);
  }

  Stream<LocationState> _mapFetchProvinceMunicipalityDataEvent(
      FetchProvinceMunicipalityDataEvent event) async* {
    List<Map<String, dynamic>> provinceResult = await provinceRepository.all();
    List<ProvinceModel> provinceReturn = List();
    provinceReturn = provinceResult
        .map((e) => ProvinceModel(
              id: e['id'].toString(),
              name: e['name'],
            ))
        .toList();

    yield LoadedProvinceMunicipalityState(results: provinceReturn);
  }

  Stream<LocationState> _mapProvinceSelectedEvent(
      ProvinceSelectedEvent event) async* {
    List<Map<String, dynamic>> municipalitiesResult =
        await municipalityRepository.all();
    List<MunicipalityModel> municipalitiesReturn = List();
    municipalitiesReturn = municipalitiesResult
        .map((e) => MunicipalityModel(
            id: e['id'].toString(),
            name: e['name'],
            provinceFk: e['provinceFk']))
        .toList();

    yield MunicipalitiesLoadedState(results: municipalitiesReturn);
  }
}
