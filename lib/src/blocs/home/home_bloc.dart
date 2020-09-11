import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pamiksa/src/data/models/business.dart';
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
    } else if (event is ChangeToInitialStateEvent) {
      yield* _mapChangeToInitialStateEvent(event);
    }
  }

  Stream<HomeState> _mapChangeToInitialStateEvent(
      ChangeToInitialStateEvent event) async* {
    yield HomeInitial();
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
        yield LoadedBusinessState(results: businessModel);
      }
    } catch (error) {
      yield ConnectionFailedState();
    }
  }
}
