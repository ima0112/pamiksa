import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pamiksa/src/data/repositories/remote/register_data_repository.dart';
import 'package:pamiksa/src/data/shared/shared.dart';
import 'package:pamiksa/src/ui/navigation/locator.dart';
import 'package:pamiksa/src/ui/navigation/navigation_service.dart';
import 'package:pamiksa/src/ui/navigation/route_paths.dart' as routes;

part 'register_personal_info_event.dart';
part 'register_personal_info_state.dart';

class RegisterPersonalInfoBloc
    extends Bloc<RegisterPersonalInfoEvent, RegisterPersonalInfoState> {
  final NavigationService navigationService = locator<NavigationService>();
  final RegisterDataRepository registerDataRepository;
  Shared preferences = Shared();
  RegisterPersonalInfoBloc(this.registerDataRepository)
      : super(RegisterPersonalInfoInitial());

  @override
  Stream<RegisterPersonalInfoState> mapEventToState(
    RegisterPersonalInfoEvent event,
  ) async* {
    if (event is SaveUserPersonalInfoEvent) {
      yield* _mapSaveUserPersonalInfoEvent(event);
    }
    if (event is SelectDateEvent) {
      yield DateSelectedState();
    }
  }

  Stream<RegisterPersonalInfoState> _mapSaveUserPersonalInfoEvent(
      SaveUserPersonalInfoEvent event) async* {
    await preferences.saveString('fullname', event.fullname);
    await preferences.saveString('birthday', event.birthday);

    navigationService.navigateTo(routes.RegisterLocationRoute);
  }
}
