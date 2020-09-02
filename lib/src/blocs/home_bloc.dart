import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:pamiksa/src/data/models/business.dart';
import 'package:pamiksa/src/data/models/businessOwner.dart';
import 'package:pamiksa/src/data/repositories/BusinessRepository.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BusinessRepository repository;
  List<Business> business;

  HomeBloc(this.repository) : super(HomeInitial());

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is FetchBusiness) {
      yield* _mapBusinessFetched(event);
    }
  }

  Stream<HomeState> _mapBusinessFetched(FetchBusiness event) async* {
    final queryResults = await this.repository.business();
    final List<dynamic> business =
        queryResults.data['business'] as List<dynamic>;
    print(business);
    final List<Business> listOfBusiness = business
        .map((dynamic e) => Business(
              id: e['id'],
              name: e['name'],
              adress: e['adress'],
              valoration: 4.5,
              deliveryPrice: 25.7,
              email: e['email'],
              photo: e['photo'],
              description: e['description'],
              phone: e['phone'],
              businessOwnerFk: BusinessOwner(
                  id: e['businessOwner']['id'],
                  ci: e['businessOwner']['ci']),
            ))
        .toList();
    this.business = listOfBusiness;
    print(listOfBusiness);
    yield BusinessFetchedState(businessResults: listOfBusiness);
  }
}
