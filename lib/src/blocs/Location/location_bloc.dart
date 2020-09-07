import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pamiksa/src/data/models/municipality.dart';
import 'package:pamiksa/src/data/models/province.dart';
import 'package:pamiksa/src/data/repositories/remote/provinces_repository.dart';
import 'package:pamiksa/src/data/repositories/remote/user_repository.dart';
import 'package:pamiksa/src/data/shared/shared.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
import 'package:pamiksa/src/ui/navigation/route_paths.dart' as routes;

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final NavigationService navigationService = locator<NavigationService>();
  final ProvincesRepository provincesRepository;
  final UserRepository userRepository;
  List<ProvinceModel> province = List();
  Shared preferences = Shared();
  LocationBloc(this.provincesRepository, this.userRepository)
      : super(LocationInitial());

  @override
  Stream<LocationState> mapEventToState(
    LocationEvent event,
  ) async* {
    if (event is FetchProvincesEvent) {
      yield* _mapFetchProvincesEvent(event);
    }
    if (event is MutateCodeEvent) {
      yield* _mapMutateCodeEvent(event);
    }
  }

  Stream<LocationState> _mapFetchProvincesEvent(
      FetchProvincesEvent event) async* {
    await preferences.saveString('fullname', event.name);
    await preferences.saveString('birthday', event.birthday);

    final response = await this.provincesRepository.userLocation();
    final List provincesData = response.data['provinces'] as List;

    provincesData.forEach((element) {
      List<MunicipalityModel> municipios = List();
      element['municipality'].forEach((element) {
        MunicipalityModel municipio = MunicipalityModel(
            id: element['id'],
            name: element['name'],
            provinceFk: element['provinceFk']);
        municipios.add(municipio);
      });
      ProvinceModel provinceModel = ProvinceModel(
          id: element['id'], name: element['name'], municipalities: municipios);
      province.add(provinceModel);
    });

    print({
      await preferences.read('email'),
      await preferences.read('password'),
      await preferences.read('fullname'),
      await preferences.read('birthday')
    });

    yield LoadedLocationsState(results: province);
    navigationService.navigateTo(routes.RegisterLocationRoute);
  }

  Stream<LocationState> _mapMutateCodeEvent(MutateCodeEvent event) async* {
    String email = await preferences.read('email');

    int min = 100000;
    int max = 999999;
    var randomizer = new Random();
    int code = min + randomizer.nextInt(max - min);

    await preferences.saveString('code', code.toString());
    await preferences.saveString('adress', event.adress);
    final response =
        await this.userRepository.sendVerificationCode(email, code.toString());

    print({"response": response.data.toString(), "code": code, "email": email});
    navigationService.navigateTo(routes.VerificationRoute);
  }
}
