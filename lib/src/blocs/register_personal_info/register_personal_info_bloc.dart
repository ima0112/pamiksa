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
    if (event is TakeDateEvent) {
      yield* _mapTakeDateEvent(event);
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

  Stream<RegisterPersonalInfoState> _mapTakeDateEvent(
      TakeDateEvent event) async* {
    yield LoadingState();

    final response = await this.registerDataRepository.registerData();

    String date = response.data['dateNow'];
    int year = int.parse(date.substring(0, 4)) - 18;
    int month = int.parse(date.substring(5, 7));
    int day = int.parse(date.substring(8));

    print({"date": date, "year": year, "month": month, "day": day});

    yield DateTakenState(year, month, day);
  }
}
