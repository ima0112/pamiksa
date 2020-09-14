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
import 'package:pamiksa/src/data/random.dart' as random;
import 'package:pamiksa/src/ui/navigation/route_paths.dart' as routes;

part 'register_location_event.dart';
part 'register_location_state.dart';

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
    if (event is MutateCodeEvent) {
      yield* _mapMutateCodeEvent(event);
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
}
