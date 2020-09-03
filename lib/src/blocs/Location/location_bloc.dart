import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pamiksa/src/data/models/municipality.dart';
import 'package:pamiksa/src/data/models/province.dart';
import 'package:pamiksa/src/data/repositories/repository.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final Repository repository;
  List<Province> provinces;
  LocationBloc(this.repository) : super(LocationInitial());

  @override
  Stream<LocationState> mapEventToState(
    LocationEvent event,
  ) async* {
    if (event is FetchLocations) {
      yield* _mapFetchLocationsToState(event);
    }
  }

  Stream<LocationState> _mapFetchLocationsToState(FetchLocations event) async* {
    final queryResults = await this.repository.userLocation();
    final List<dynamic> provinces =
        queryResults.data['provinces'] as List<dynamic>;
    print(provinces);
    final List<Province> listOfProvince = provinces
        .map((dynamic e) => Province(
              id: e['id'] as String,
              name: e['name'] as String,
              municipalities: e['municipality'] as List<dynamic>,
            ))
        .toList();

    this.provinces = listOfProvince;
    print(listOfProvince);
    yield LocationsFetched(results: listOfProvince);
  }
}
