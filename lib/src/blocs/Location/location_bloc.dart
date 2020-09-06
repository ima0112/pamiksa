import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pamiksa/src/data/models/municipality.dart';
import 'package:pamiksa/src/data/models/province.dart';
import 'package:pamiksa/src/data/repositories/remote/provinces_repository.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final ProvincesRepository provincesRepository;
  List<ProvinceModel> province = List();
  LocationBloc(this.provincesRepository) : super(LocationInitial());

  @override
  Stream<LocationState> mapEventToState(
    LocationEvent event,
  ) async* {
    if (event is FetchProvincesEvent) {
      yield* _mapFetchProvincesEvent(event);
    }
  }

  Stream<LocationState> _mapFetchProvincesEvent(
      FetchProvincesEvent event) async* {
    final response = await this.provincesRepository.userLocation();
    final List provincesData = response.data['provinces'] as List;
    print(provincesData);

    provincesData.forEach((element) {
      List<MunicipalityModel> municipios = List();
      element['municipality'].forEach((element) {
        MunicipalityModel municipio = MunicipalityModel(
            id: element['id'],
            name: element['name'],
            provinceFk: element['provinceFk']);
        municipios.add(municipio as MunicipalityModel);
      });
      ProvinceModel provinceModel = ProvinceModel(
          id: element['id'], name: element['name'], municipalities: municipios);
      province.add(provinceModel);
    });

    print(province);

    yield LoadedLocationsState(results: province);
  }
}
