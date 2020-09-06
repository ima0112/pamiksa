import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pamiksa/src/data/models/business.dart';
import 'package:pamiksa/src/data/models/business_owner.dart';
import 'package:pamiksa/src/data/repositories/remote/business_repository.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BusinessRepository businessRepository;
  List<BusinessModel> businessModel;

  HomeBloc(this.businessRepository) : super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is FetchBusinessEvent) {
      yield* _mapFetchBusinessEvent(event);
    }
  }

  Stream<HomeState> _mapFetchBusinessEvent(FetchBusinessEvent event) async* {
    try {
      final response = await businessRepository.fetchBusiness();
      if (response.hasException) {
        yield ConnectionFailedState();
      } else {
        final List businessData = response.data['business'];
        businessModel = businessData
            .map((e) => BusinessModel(
                  id: e['id'],
                  name: e['name'],
                  adress: e['adress'],
                  valoration: 4.5,
                  deliveryPrice: 25.7,
                  email: e['email'],
                  photo: e['photo'],
                  description: e['description'],
                  phone: e['phone'],
                  businessOwner: BusinessOwnersModel(
                      id: e['businessOwner']['id'],
                      ci: e['businessOwner']['ci']),
                ))
            .toList();
        yield LoadedBusinessState(results: businessModel);
      }
    } catch (error) {
      yield ConnectionFailedState();
    }
  }
}
